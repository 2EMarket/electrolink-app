
import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/core/widget/Component_attachments%20icons/attachment_icon.dart';
import 'package:second_hand_electronics_marketplace/core/widget/Component_msgChip/suggestions.dart';

class ChatInputBar extends StatefulWidget {
  final bool showSuggestions;
  final Function(String)? onSend;
  final VoidCallback? onAttach;
  final VoidCallback? onCamera;
  final VoidCallback? onEmoji;
  final Function()? onStartRecording;
  final Function()? onStopRecording;
  final bool isRecording;

  const ChatInputBar({
    super.key,
    this.showSuggestions = true,
    this.onSend,
    this.onAttach,
    this.onCamera,
    this.onEmoji,
    this.onStartRecording,
    this.onStopRecording,
    this.isRecording = false,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  bool _isHasText = false;
  bool _isRecording = false;
  bool _isLocked = false;
  bool _isCanceled = false;
  Offset _dragStartPosition = Offset.zero;
  Offset _dragOffset = Offset.zero;
  late AnimationController _animationController;
  late Animation<double> _slideToCancelAnimation;
  late Animation<double> _slideToLockAnimation;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isHasText = _controller.text.trim().isNotEmpty;
      });
    });

    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _slideToCancelAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _slideToLockAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleVoiceButtonTap() {
    if (_isHasText) {
      widget.onSend?.call(_controller.text.trim());
      _controller.clear();
    } else if (_isLocked) {
      // If locked, tapping sends the recording
      widget.onStopRecording?.call();
      _resetRecordingState();
    } else {
      // This case should ideally not be reached if long press is handled correctly
      // but as a fallback, if not recording, start recording on tap
      if (!_isRecording) {
        _startRecording();
      } else {
        _stopRecording();
      }
    }
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _isCanceled = false;
      _isLocked = false;
      _dragOffset = Offset.zero;
    });
    widget.onStartRecording?.call();
    _animationController.forward();
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
      _isCanceled = false;
      _isLocked = false;
      _dragOffset = Offset.zero;
    });
    widget.onStopRecording?.call();
    _animationController.reverse();
  }

  void _cancelRecording() {
    setState(() {
      _isRecording = false;
      _isCanceled = true;
      _isLocked = false;
      _dragOffset = Offset.zero;
    });
    widget.onStopRecording?.call(); // Call stop to discard the recording
    _animationController.reverse();
  }

  void _lockRecording() {
    setState(() {
      _isLocked = true;
      _dragOffset = Offset.zero; // Reset drag offset after locking
    });
    // No need to call onStopRecording here, as recording continues in locked state
  }

  void _resetRecordingState() {
    setState(() {
      _isRecording = false;
      _isLocked = false;
      _isCanceled = false;
      _dragOffset = Offset.zero;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 20, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 0.5),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isRecording && !_isLocked) ...[
            _buildRecordingIndicator(),
            const SizedBox(height: 16),
          ],
          if (widget.showSuggestions && !_isRecording && !_isLocked) ...[
            _buildSuggestions(),
            const SizedBox(height: 16),
          ],
          Row(
            children: [
              if (!_isRecording && !_isLocked) ...[
                IconButton(
                  onPressed: widget.onEmoji,
                  icon: Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.grey[600],
                    size: 24,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: _isRecording ? Colors.red[50] : Colors.grey[50],
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: _isRecording ? Colors.red[300]! : Colors.grey[300]!,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _isRecording
                            ? _buildRecordingContent()
                            : TextField(
                                controller: _controller,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                ),
                                decoration: const InputDecoration(
                                  hintText: "Message...",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Color(0xFF9CA3AF),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                      ),
                      if (!_isRecording && !_isLocked) ...[
                        AttachmentButtons(onAttach: () {  }, onCamera: () {  },)
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              
              // Microphone/Send Button
              GestureDetector(
                onLongPressStart: (details) {
                  _dragStartPosition = details.globalPosition;
                  _startRecording();
                },
                onLongPressMoveUpdate: (details) {
                  if (_isLocked) return; // No drag actions if locked

                  setState(() {
                    _dragOffset = details.globalPosition - _dragStartPosition;
                  });

                  // Slide to cancel logic
                  if (_dragOffset.dx < -50 && !_isCanceled) {
                    _cancelRecording();
                  }
                  // Slide to lock logic
                  else if (_dragOffset.dy < -50 && !_isLocked) {
                    _lockRecording();
                  }
                },
                onLongPressEnd: (details) {
                  if (_isCanceled) {
                    // Already handled by _cancelRecording
                  } else if (_isLocked) {
                    // Recording continues in locked state, no action here
                  } else {
                    _stopRecording();
                  }
                  _resetRecordingState();
                },
                onTap: _handleVoiceButtonTap,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _isRecording || _isLocked
                        ? Colors.red
                        : _isHasText
                            ? const Color(0xFF007AFF)
                            : Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          _isRecording && !_isLocked
                              ? Icons.mic_outlined // Show mic while recording, not locked
                              : _isLocked
                                  ? Icons.stop_rounded // Show stop when locked
                                  : _isHasText
                                      ? Icons.send_rounded
                                      : Icons.mic_outlined,
                          color: _isRecording || _isLocked || _isHasText
                              ? Colors.white
                              : Colors.grey[600],
                          size: 22,
                        ),
                      ),
                      if (_isRecording && !_isLocked) // Recording indicator for non-locked state
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.red, width: 1),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.fiber_manual_record,
                                color: Colors.red,
                                size: 6,
                              ),
                            ),
                          ),
                        ),
                      // Lock icon for slide up
                      if (_isRecording && !_isLocked) // Only show lock hint when recording and not yet locked
                        Positioned(
                          top: _dragOffset.dy.clamp(-60, 0) - 30, // Adjust position based on drag
                          left: 0,
                          right: 0,
                          child: FadeTransition(
                            opacity: _slideToLockAnimation,
                            child: Icon(
                              Icons.lock_outline,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingIndicator() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.keyboard_voice,
              color: Colors.red,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              _isLocked ? "Recording Locked" : "Recording...",
              style: TextStyle(
                color: Colors.red[700],
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Time indicator (placeholder)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red[100]!),
              ),
              child: Row(
                children: [
                  Text(
                    "0:00", // Placeholder for actual timer
                    style: TextStyle(
                      color: Colors.red[800],
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "/ 0:05", // Placeholder for max duration
                    style: TextStyle(
                      color: Colors.red[600],
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Cancel button (only visible if not locked and not canceled by drag)
            if (!_isLocked && !_isCanceled) // Only show cancel button if not locked or canceled by drag
              GestureDetector(
                onTap: _cancelRecording,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecordingContent() {
    return Row(
      children: [
        Icon(
          Icons.keyboard_voice,
          color: Colors.red,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Waveform indicator (placeholder)
              Row(
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      width: 4,
                      height: 8 + i * 3,
                      margin: const EdgeInsets.only(right: 3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              // Slide to cancel text
              if (!_isLocked) // Only show slide to cancel if not locked
                FadeTransition(
                  opacity: _slideToCancelAnimation,
                  child: Transform.translate(
                    offset: Offset(_dragOffset.dx.clamp(-100, 0), 0), // Move text with drag
                    child: Text(
                      "< Slide to cancel",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestions() {
    return SuggestionChips(
      suggestions: const [
        "Is it still available?",
        "Can you send another picture?",
        "What's the condition?",
        "Would you take an offer?"
      ],
      onSelected: (selectedText) {
        setState(() {
          _controller.text = selectedText;
          _isHasText = true;
        });
      },
    );
  }
}
