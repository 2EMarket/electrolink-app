import 'dart:async';

import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/core/widget/Component_attachments%20icons/attachment_icon.dart';
import 'package:second_hand_electronics_marketplace/core/widget/Component_msgChip/suggestions.dart';

class ChatInputBarMode extends StatefulWidget {
  final bool showSuggestions;
  final Function(String)? onSend;
  final VoidCallback? onAttach;
  final VoidCallback? onCamera;
  final VoidCallback? onEmoji;
  final Function()? onStartRecording;
  final Function()? onStopRecording;
  final bool isRecording;

  const ChatInputBarMode({
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
  State<ChatInputBarMode> createState() => _ChatInputBarModeState();
}

class _ChatInputBarModeState extends State<ChatInputBarMode> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  bool _isHasText = false;
  bool _isRecording = false;
  bool _showCancel = false;
  Offset _dragStartPosition = Offset.zero;
  Offset _dragOffset = Offset.zero;
  late AnimationController _animationController;
  int _recordingSeconds = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isHasText = _controller.text.trim().isNotEmpty;
      });
    });

    _animationController = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 200)
    );
  }

  void _startTimer() {
    _recordingSeconds = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordingSeconds++;
      });
    });
  }

  void _stopTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    _stopTimer();
    super.dispose();
  }

  void _handleVoiceButtonTap() {
    if (_isHasText) {
      widget.onSend?.call(_controller.text.trim());
      _controller.clear();
    }
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _showCancel = false;
      _dragOffset = Offset.zero;
    });
    _startTimer();
    widget.onStartRecording?.call();
    _animationController.forward();
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
      _showCancel = false;
      _dragOffset = Offset.zero;
    });
    _stopTimer();
    widget.onStopRecording?.call();
    _animationController.reverse();
  }

  void _cancelRecording() {
    setState(() {
      _isRecording = false;
      _showCancel = true;
      _dragOffset = Offset.zero;
    });
    _stopTimer();
    widget.onStopRecording?.call();
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
          if (_isRecording) ...[
            _buildWhatsappRecordingIndicator(),
            const SizedBox(height: 16),
          ],
          
          if (widget.showSuggestions && !_isRecording) ...[
            _buildSuggestions(),
            const SizedBox(height: 16),
          ],
          
          Row(
            children: [
              if (!_isRecording) ...[
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
                child: GestureDetector(
                  onHorizontalDragStart: _isRecording ? (details) {
                    _dragStartPosition = details.globalPosition;
                  } : null,
                  onHorizontalDragUpdate: _isRecording ? (details) {
                    setState(() {
                      _dragOffset = details.globalPosition - _dragStartPosition;
                    });
                    
                    // إلغاء بالتوجيه لليسار كما في واتساب
                    if (_dragOffset.dx < -80) {
                      _cancelRecording();
                    }
                  } : null,
                  onHorizontalDragEnd: _isRecording ? (details) {
                    if (_dragOffset.dx >= -80) {
                      setState(() {
                        _dragOffset = Offset.zero;
                      });
                    }
                  } : null,
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: _isRecording ? const Color(0xFFFEEBEE) : Colors.grey[50],
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: _isRecording ? const Color(0xFFF28B82) : Colors.grey[300]!,
                      ),
                    ),
                    child: Row(
                      children: [
                        if (_isRecording)
                          Icon(
                            Icons.keyboard_voice,
                            color: const Color(0xFFEA4335),
                            size: 20,
                          ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _isRecording
                              ? _buildWhatsappRecordingContent()
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
                        
                        if (!_isRecording) ...[
                          AttachmentButtons(
                            onAttach: widget.onAttach ?? () {},
                            onCamera: widget.onCamera ?? () {},
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 8),
              
              // زر واتساب للميكروفون/الإرسال
              _buildWhatsappVoiceButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWhatsappRecordingIndicator() {
    return Column(
      children: [
        const Text(
          "Recording...",
          style: TextStyle(
            color: Color(0xFFEA4335),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // مؤشر الوقت
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFEEBEE),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF28B82)),
              ),
              child: Row(
                children: [
                  Text(
                    _formatTime(_recordingSeconds),
                    style: const TextStyle(
                      color: Color(0xFFEA4335),
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "/ 1:00",
                    style: TextStyle(
                      color: Color(0xFFEA4335),
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // زر إلغاء التسجيل
            GestureDetector(
              onTap: _cancelRecording,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Color(0xFF5F6368),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWhatsappRecordingContent() {
    return Row(
      children: [
        Expanded(
          child: Transform.translate(
            offset: Offset(_dragOffset.dx.clamp(-100, 0), 0),
            child: Text(
              "Slide to cancel",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        if (_dragOffset.dx < -40)
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Color(0xFFEA4335),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildWhatsappVoiceButton() {
    return GestureDetector(
      onLongPressStart: (details) {
        _startRecording();
      },
      onLongPressEnd: (details) {
        if (!_showCancel) {
          _stopRecording();
        }
      },
      onTap: _handleVoiceButtonTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: _isRecording
              ? const Color(0xFFEA4335)
              : _isHasText
                  ? const Color(0xFF007AFF)
                  : const Color(0xFF075E54),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            _isRecording
                ? Icons.mic
                : _isHasText
                    ? Icons.send_rounded
                    : Icons.mic_none,
            color: Colors.white,
            size: _isRecording ? 24 : 22,
          ),
        ),
      ),
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

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$remainingSeconds";
  }
}