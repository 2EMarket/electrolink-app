
import 'package:flutter/material.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_colors.dart';
import 'package:second_hand_electronics_marketplace/configs/theme/app_typography.dart';
import 'package:second_hand_electronics_marketplace/features/chating/presentation/widget/Component_chat bubbles/chat_bubble.dart';
import 'reply_message_model.dart';
import 'reply_preview_widget.dart';

/// نوع محتوى الرسالة الأصلية (الرد نفسه وليس الرسالة المردود عليها)
enum ReplyBubbleContentType {
  text,
  image,
  audio,
}

class ReplyMessageBubble3 extends StatelessWidget {
  // ── بيانات الرسالة المردود عليها ──────────────────────────
  final ReplyMessageModel replyTo;

  // ── نوع ومحتوى الرد ───────────────────────────────────────
  final ReplyBubbleContentType contentType;

  // نص
  final String? message;

  // صورة
  final String? imageUrl;
  final String? imageLocalPath;
  final String? imageCaption;

  // صوت
  final String? audioUrl;
  final Duration? audioDuration;
  final bool isAudioPlaying;
  final double audioProgress; // 0.0 → 1.0
  final VoidCallback? onAudioPlayPause;

  // ── بيانات الرسالة العامة ─────────────────────────────────
  final bool isSender;
  final String time;
  final bool isRead;
  final bool isDelivered;

  /// يُستدعى عند الضغط على معاينة الرسالة المردود عليها للانتقال إليها
  final VoidCallback? onReplyTap;

  const ReplyMessageBubble3({
    super.key,
    required this.isSender,
    required this.replyTo,
    required this.contentType,
    required this.time,
    required this.isRead,
    this.isDelivered = false,
    this.message,
    this.imageUrl,
    this.imageLocalPath,
    this.imageCaption,
    this.audioUrl,
    this.audioDuration,
    this.isAudioPlaying = false,
    this.audioProgress = 0.0,
    this.onAudioPlayPause,
    this.onReplyTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChatBubbleBase(
      isSender: isSender,
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onReplyTap,
            child: ReplyPreviewWidget(
              reply: replyTo,
              isSender: isSender,
            ),
          ),

          const SizedBox(height: 8),

          _buildContent(),

          const SizedBox(height: 6),

          _buildFooter(),
        ],
      ),
    );
  }

  // محتوى الرد

  Widget _buildContent() {
    switch (contentType) {
      case ReplyBubbleContentType.text:
        return _buildTextContent();
      case ReplyBubbleContentType.image:
        return _buildImageContent();
      case ReplyBubbleContentType.audio:
        return _buildAudioContent();
    }
  }

  // ── نص ──────────────────────────────────────────────────
  Widget _buildTextContent() {
    return Text(
      message ?? '',
      style: AppTypography.body14Regular.copyWith(
        color: AppColors.text,
      ),
    );
  }

  // ── صورة ─────────────────────────────────────────────────
  Widget _buildImageContent() {
    final url = imageUrl ?? imageLocalPath;
    return Column(
      crossAxisAlignment:
          isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 300), // تحديد أقصى ارتفاع للصورة
            child: url != null
                ? Image.network(
                    url,
                    width: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _imagePlaceholder(),
                  )
                : _imagePlaceholder(),
          ),
        ),
        if (imageCaption?.isNotEmpty == true) ...[
          const SizedBox(height: 4),
          Text(
            imageCaption!,
            style: AppTypography.body14Regular.copyWith(color: AppColors.text),
          ),
        ],
      ],
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: 220,
      height: 140,
      color: AppColors.hint.withOpacity(0.15),
      child: Icon(Icons.image_outlined, color: AppColors.hint, size: 36),
    );
  }

  // ── صوت ──────────────────────────────────────────────────
  Widget _buildAudioContent() {
    final duration = audioDuration ?? Duration.zero;
    final durationText =
        '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    final accentColor =
        isSender ? AppColors.mainColor : AppColors.secondaryColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // زر تشغيل/إيقاف
          GestureDetector(
            onTap: onAudioPlayPause,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: accentColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isAudioPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 10),
          // شريط التقدم
          Flexible( 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _AudioProgressBar(
                  progress: audioProgress,
                  color: accentColor,
                ),
                const SizedBox(height: 4),
                Text(
                  durationText,
                  style: AppTypography.label10Regular.copyWith(
                    color: AppColors.hint,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          // أيقونة الميكروفون
          Icon(Icons.mic, size: 14, color: AppColors.hint),
        ],
      ),
    );
  }

  // فوتر: الوقت + حالة القراءة

  Widget _buildFooter() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Text(
          time,
          style: AppTypography.label10Regular.copyWith(
            color: AppColors.hint,
            fontWeight: FontWeight.w400,
          ),
        ),
        if (isSender) ...[
          const SizedBox(width: 4),
          _MessageStatusIcon(isRead: isRead, isDelivered: isDelivered),
        ],
      ],
    );
  }
}

// شريط تقدم الصوت

class _AudioProgressBar extends StatelessWidget {
  final double progress; // 0.0 → 1.0
  final Color color;

  const _AudioProgressBar({required this.progress, required this.color});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              height: 3,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Container(
              height: 3,
              width: constraints.maxWidth * progress.clamp(0.0, 1.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        );
      },
    );
  }
}

// أيقونة حالة الرسالة (مُرسَلة / مُسلَّمة / مقروءة)

class _MessageStatusIcon extends StatelessWidget {
  final bool isRead;
  final bool isDelivered;

  const _MessageStatusIcon({required this.isRead, required this.isDelivered});

  @override
  Widget build(BuildContext context) {
    if (isRead) {
      return Icon(Icons.done_all, size: 14, color: AppColors.success);
    } else if (isDelivered) {
      return Icon(Icons.done_all, size: 14, color: AppColors.hint);
    } else {
      return Icon(Icons.done, size: 14, color: AppColors.hint);
    }
  }
}
