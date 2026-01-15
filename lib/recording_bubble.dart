import 'dart:math';
import 'package:flutter/material.dart';

class RecordingBubble extends StatefulWidget {
  final int seconds;
  final VoidCallback onDelete;
  final VoidCallback onConfirm;

  const RecordingBubble({
    super.key,
    required this.seconds,
    required this.onDelete,
    required this.onConfirm,
  });

  @override
  State<RecordingBubble> createState() => _RecordingBubbleState();
}

class _RecordingBubbleState extends State<RecordingBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;
  bool _isPaused = false;

  final List<double> _amplitudes =
      List.generate(40, (_) => Random().nextDouble());

  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      _isPaused ? _waveController.stop() : _waveController.repeat(reverse: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 🗑 Delete
        GestureDetector(
          onTap: widget.onDelete,
          child: _circle(
            color: const Color(0xFFFF4D4F),
            icon: Icons.delete_outline,
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
                // ▶️ / ⏸
                GestureDetector(
                  onTap: _togglePause,
                  child: Icon(
                    _isPaused
                        ? Icons.play_circle_fill
                        : Icons.pause_circle_filled,
                    color: const Color(0xFF6B7280),
                    size: 24,
                  ),
                ),

                const SizedBox(width: 8),

                // 🌊 Animated Waveform
                Expanded(
                  child: AnimatedBuilder(
                    animation: _waveController,
                    builder: (_, __) {
                      return CustomPaint(
                        painter: WaveformPainter(
                          amplitudes: _amplitudes,
                          progress: _waveController.value,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 8),

                // ⏱ Time
                Text(
                  _formatTime(widget.seconds),
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

        // 🎤 Confirm
        GestureDetector(
          onTap: widget.onConfirm,
          child: _circle(
            color: const Color(0xFF2563EB),
            icon: Icons.mic,
          ),
        ),
      ],
    );
  }

  Widget _circle({required Color color, required IconData icon}) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white),
    );
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }
}
class WaveformPainter extends CustomPainter {
  final List<double> amplitudes;
  final double progress;

  WaveformPainter({
    required this.amplitudes,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final spacing = size.width / amplitudes.length;

    for (int i = 0; i < amplitudes.length; i++) {
      final amp = amplitudes[i] * (0.5 + progress);
      final x = i * spacing;
      final y = size.height / 2;

      canvas.drawLine(
        Offset(x, y - amp * 20),
        Offset(x, y + amp * 20),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
