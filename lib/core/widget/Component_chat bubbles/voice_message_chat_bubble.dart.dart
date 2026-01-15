import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:second_hand_electronics_marketplace/core/widget/Component_Voice/audio_control.dart';

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
    // الألوان بناءً على كود Figma والصورة المرفقة
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
  final AudioPlayer _player = AudioPlayer();
  final PlayerController _waveController = PlayerController();
  bool isPlaying = false;
  Duration current = Duration.zero;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeAudio();
  }

  Future<void> _initializeAudio() async {
    try {
      await _waveController.preparePlayer(
        path: widget.audioUrl,
        shouldExtractWaveform: true,
        noOfSamples: 40, // تقليل العينات ليتناسب مع حجم الفقاعة الصغير
      );

      _player.onPositionChanged.listen((p) {
        if (mounted) setState(() => current = p);
      });

      _player.onPlayerComplete.listen((_) {
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
    if (isPlaying) {
      await _player.pause();
    } else {
      await _player.play(UrlSource(widget.audioUrl));
    }
    if (mounted) setState(() => isPlaying = !isPlaying);
  }

  @override
  void dispose() {
    _player.dispose();
    _waveController.dispose();
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
            VerticalAudioControl(),
            // زر التشغيل الدائري الأبيض
            // GestureDetector(
            //   onTap: _togglePlay,
            //   child: Container(
            //     width: 38,
            //     height: 38,
            //     decoration: const BoxDecoration(
            //       color: Colors.white,
            //       shape: BoxShape.circle,
            //     ),
            //     child: Icon(
            //       isPlaying ? Icons.pause : Icons.play_arrow_rounded,
            //       color: widget.themeColor,
            //       size: 26,
            //     ),
            //   ),
            // ),
            const SizedBox(width: 10),
            // الموجة الصوتية والوقت تحتها
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isInitialized)
                    AudioFileWaveforms(
                      size: const Size(double.infinity, 30),
                      playerController: _waveController,
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
                  // الوقت الصغير بجانب النقطة الزرقاء كما في الصورة
                  Row(
                    children: [
                      Text(
                        formatDuration(current),
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.circle, size: 4, color: Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        // التوقيت السفلي وعلامة الصح
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
                  color: widget.isRead ? Colors.blue : Colors.grey,
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