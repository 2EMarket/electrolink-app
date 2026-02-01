import 'package:flutter/material.dart';
class VerticalAudioControl extends StatefulWidget {
  const VerticalAudioControl({super.key});

  @override
  State<VerticalAudioControl> createState() =>
      _VerticalAudioControlState();
}

class _VerticalAudioControlState extends State<VerticalAudioControl> {
  bool isPlaying = false;

  void _toggle() {
    setState(() => isPlaying = !isPlaying);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _toggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                isPlaying ? Colors.white : const Color(0xFFF2F2F2),
            boxShadow: isPlaying
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    )
                  ]
                : [],
          ),
          child: Icon(
            isPlaying
                ? Icons.pause_rounded
                : Icons.play_arrow_rounded,
            size: 28,
            color: isPlaying
                ? const Color(0xFF2563EB)
                : Colors.grey,
          ),
        ),
      ),
    );
  }
}
