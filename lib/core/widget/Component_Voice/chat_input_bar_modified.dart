import 'dart:async';
import 'package:flutter/material.dart';

class ChatInputBarFigma extends StatefulWidget {
  final Function(String)? onSend;
  final VoidCallback? onStartRecording;
  final VoidCallback? onStopRecording;

  const ChatInputBarFigma({
    super.key,
    this.onSend,
    this.onStartRecording,
    this.onStopRecording,
  });

  @override
  State<ChatInputBarFigma> createState() => _ChatInputBarFigmaState();
}

class _ChatInputBarFigmaState extends State<ChatInputBarFigma> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;
  bool _isRecording = false;

  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  // ===================== RECORDING =====================

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _seconds = 0;
    });

    widget.onStartRecording?.call();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _seconds++);
    });
  }

  void _stopRecording() {
    _timer?.cancel();
    setState(() => _isRecording = false);
    widget.onStopRecording?.call();
  }

  void _cancelRecording() {
    _timer?.cancel();
    setState(() => _isRecording = false);
  }

  // ===================== UI =====================

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: _isRecording ? _recordingUI() : _textInputUI(),
    );
  }

  // ===================== TEXT INPUT =====================

  Widget _textInputUI() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Message...",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        _sendOrMicButton(),
      ],
    );
  }

  Widget _sendOrMicButton() {
    return GestureDetector(
      onTap: () {
        if (_hasText) {
          widget.onSend?.call(_controller.text.trim());
          _controller.clear();
        }
      },
      onLongPress: _hasText ? null : _startRecording,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: _hasText ? const Color(0xFF2563EB): const Color(0xFF2563EB),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _hasText ? Icons.send_rounded : Icons.mic_none,
          color: Colors.white,
        ),
      ),
    );
  }

  // ===================== RECORDING UI (FIGMA) =====================

  Widget _recordingUI() {
    return Row(
      children: [
        // 🗑 Delete
        GestureDetector(
          onTap: _cancelRecording,
          child: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFFF4D4F),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),

        const SizedBox(width: 8),

        // 🎧 Bubble
        Expanded(
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                // ⏸ Pause (UI فقط)
                const Icon(
                  Icons.pause_circle_filled,
                  color: Color(0xFF6B7280),
                  size: 24,
                ),

                const SizedBox(width: 8),

                // 🌊 Fake waveform
                Expanded(
                  child: Row(
                    children: List.generate(
                      20,
                      (i) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        child: Container(
                          width: 2,
                          height: i.isEven ? 14 : 8,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // ⏱ Time
                Text(
                  _formatTime(_seconds),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 8),

        // 🎤 Confirm Mic
        GestureDetector(
          onTap: _stopRecording,
          child: Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: const Color.fromARGB(255, 235, 37, 37),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.mic,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }
}
