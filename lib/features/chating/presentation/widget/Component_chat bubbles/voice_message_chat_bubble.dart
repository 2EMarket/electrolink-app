import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:audioplayers/audioplayers.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_Voice/audio_control.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';

class VoiceMessageBubble1 extends StatelessWidget {
  final bool isSender;
  final String audioUrl;
  final String duration;
  final String time;
  final bool isRead;

  const VoiceMessageBubble1({
    super.key,
    required this.isSender,
    required this.audioUrl,
    required this.duration,
    required this.time,
    this.isRead = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isSender ? const Color(0x1A2563EB) : const Color(0x1A10B981);
    final themeColor = isSender ? const Color(0xFF2563EB) : const Color(0xFF10B981);

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
        constraints: const BoxConstraints(maxWidth: 260),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: _VoiceMessageContent(
          isSender: isSender,
          audioUrl: audioUrl,
          themeColor: themeColor,
          time: time,
          isRead: isRead,
        ),
      ),
    );
  }
}

class _VoiceMessageContent extends StatefulWidget {
  final bool isSender;
  final String audioUrl;
  final Color themeColor;
  final String time;
  final bool isRead;

  const _VoiceMessageContent({
    required this.isSender,
    required this.audioUrl,
    required this.themeColor,
    required this.time,
    required this.isRead,
  });

  @override
  State<_VoiceMessageContent> createState() => _VoiceMessageContentState();
}

class _VoiceMessageContentState extends State<_VoiceMessageContent> {
  AudioPlayer? _player;
  PlayerController? _waveController;
  bool isPlaying = false;
  Duration current = Duration.zero;
  bool isInitialized = false;
  bool audioSupported = false;

  @override
  void initState() {
    super.initState();
    audioSupported = !kIsWeb; // avoid initializing audio on web (or other unsupported targets)
    if (audioSupported) {
      _initializeAudio();
    }
  }

  Future<void> _initializeAudio() async {
    try {
      _player = AudioPlayer();
      _waveController = PlayerController();

      await _waveController!.preparePlayer(
        path: widget.audioUrl,
        shouldExtractWaveform: true,
        noOfSamples: 40,
      );

      _player!.onPositionChanged.listen((p) {
        if (mounted) setState(() => current = p);
      });

      _player!.onPlayerComplete.listen((_) {
        if (mounted) {
          setState(() {
            isPlaying = false;
            current = Duration.zero;
          });
        }
      });

      if (mounted) setState(() => isInitialized = true);
    } catch (e) {
      debugPrint('Error initializing audio: $e');
    }
  }

  void _togglePlay() async {
    if (!isInitialized || _player == null) return;
    try {
      if (isPlaying) {
        await _player!.pause();
      } else {
        await _player!.play(UrlSource(widget.audioUrl));
      }
      if (mounted) setState(() => isPlaying = !isPlaying);
    } catch (e) {
      debugPrint('Audio play error: $e');
    }
  }

  @override
  void dispose() {
    _player?.dispose();
    _waveController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isInitialized) VerticalAudioControl() else Icon(Icons.play_arrow, color: widget.themeColor),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isInitialized)
                    AudioFileWaveforms(
                      size: const Size(double.infinity, 30),
                      playerController: _waveController!,
                      waveformType: WaveformType.fitWidth,
                      playerWaveStyle: PlayerWaveStyle(
                        fixedWaveColor: widget.themeColor.withOpacity(0.3),
                        liveWaveColor: widget.themeColor,
                        waveThickness: 3,
                        spacing: 5,
                        waveCap: StrokeCap.round,
                      ),
                    )
                  else
                    const SizedBox(height: 30, child: LinearProgressIndicator(value: 0.1)),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        formatDuration(current),
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.circle, size: 4, color: AppColors.mainColor),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.time,
                style: const TextStyle(fontSize: 10, color: Color(0xFF8E8E93)),
              ),
              const SizedBox(width: 4),
              if (widget.isSender)
                Icon(
                  widget.isRead ? Icons.done_all : Icons.done,
                  size: 15,
                  color: widget.isRead ? AppColors.mainColor : Colors.grey,
                ),
            ],
          ),
        ),
      ],
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "00:${twoDigits(duration.inSeconds.remainder(60))}";
  }
}
