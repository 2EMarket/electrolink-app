import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'voice_message_mobiledel.dart';
import 'package:audioplayers/audioplayers.dart';
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
class VoiceMessageDesktop extends StatefulWidget {
  final bool isSender;
  final String audioUrl;
  final String time;
  final bool isRead;

  const VoiceMessageDesktop({
    super.key,
    required this.isSender,
    required this.audioUrl,
    required this.time,
    required this.isRead,
  });

  @override
  State<VoiceMessageDesktop> createState() => _VoiceMessageDesktopState();
}

class _VoiceMessageDesktopState extends State<VoiceMessageDesktop> {
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;

  void _toggle() async {
    if (isPlaying) {
      await _player.pause();
    } else {
      await _player.play(UrlSource(widget.audioUrl));
    }
    setState(() => isPlaying = !isPlaying);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = widget.isSender
        ? const Color(0x1A2563EB)
        : const Color(0x1A10B981);

    return _BubbleBase(
      isSender: widget.isSender,
      bg: bg,
      time: widget.time,
      isRead: widget.isRead,
      child: Row(
        children: [
          _PlayButton(
            isPlaying: isPlaying,
            color: Colors.black,
            onTap: _toggle,
          ),
          const SizedBox(width: 10),
          const Text(
            'Voice message',
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class VoiceMessageBubble extends StatelessWidget {
  final bool isSender;
  final String audioUrl;
  final String time;
  final bool isRead;

  const VoiceMessageBubble({
    super.key,
    required this.isSender,
    required this.audioUrl,
    required this.time,
    this.isRead = false,
  });

  bool get isMobile =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return VoiceMessageMobile(
        isSender: isSender,
        audioUrl: audioUrl,
        time: time,
        isRead: isRead, duration: '',
      );
    } else {
      return VoiceMessageDesktop(
        isSender: isSender,
        audioUrl: audioUrl,
        time: time,
        isRead: isRead,
      );
    }
  }
}
