import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

class VoiceMessageMobile extends StatefulWidget {
  final bool isSender;
  final String audioUrl;
  final String time;
  final bool isRead;

  const VoiceMessageMobile({
    super.key,
    required this.isSender,
    required this.audioUrl,
    required this.time,
    required this.isRead, required String duration,
  });

  @override
  State<VoiceMessageMobile> createState() => _VoiceMessageMobileState();
}

class _VoiceMessageMobileState extends State<VoiceMessageMobile> {
  late final PlayerController _controller;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = PlayerController();
    _prepare();
  }

  Future<void> _prepare() async {
    await _controller.preparePlayer(
      path: widget.audioUrl,
      shouldExtractWaveform: true,
      noOfSamples: 40,
    );

    _controller.onCompletion.listen((_) {
      setState(() => isPlaying = false);
      _controller.seekTo(0);
    });
  }

  void _toggle() async {
    if (isPlaying) {
      await _controller.pausePlayer();
    } else {
      await _controller.startPlayer();
    }
    setState(() => isPlaying = !isPlaying);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = widget.isSender
        ? const Color(0x1A2563EB)
        : const Color(0x1A10B981);
    final main = widget.isSender
        ? const Color(0xFF2563EB)
        : const Color(0xFF10B981);

    return _BubbleBase(
      isSender: widget.isSender,
      bg: bg,
      time: widget.time,
      isRead: widget.isRead,
      child: Row(
        children: [
          _PlayButton(
            isPlaying: isPlaying,
            color: main,
            onTap: _toggle,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: AudioFileWaveforms(
              playerController: _controller,
              size: const Size(double.infinity, 32),
              waveformType: WaveformType.fitWidth,
              playerWaveStyle: PlayerWaveStyle(
                liveWaveColor: main,
                fixedWaveColor: main.withOpacity(.3),
                waveThickness: 3,
                spacing: 4,
                waveCap: StrokeCap.round,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _BubbleBase extends StatelessWidget {
  final bool isSender;
  final Color bg;
  final Widget child;
  final String time;
  final bool isRead;

  const _BubbleBase({
    required this.isSender,
    required this.bg,
    required this.child,
    required this.time,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            child,
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(time,
                    style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF8E8E93))),
                const SizedBox(width: 4),
                if (isSender)
                  Icon(
                    isRead ? Icons.done_all : Icons.done,
                    size: 14,
                    color:
                        isRead ? Colors.blue : Colors.grey,
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
class _PlayButton extends StatelessWidget {
  final bool isPlaying;
  final Color color;
  final VoidCallback onTap;

  const _PlayButton({
    required this.isPlaying,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }
}
