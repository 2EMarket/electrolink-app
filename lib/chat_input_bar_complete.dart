// import 'package:flutter/material.dart';
// import 'package:record/record.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class ChatInputBar extends StatefulWidget {
//   final bool showSuggestions;
//   final Function(String)? onSend;
//   final Function(String)? onSendAudio; // Callback for sending audio file path
//   final VoidCallback? onAttach;
//   final VoidCallback? onCamera;
//   final VoidCallback? onEmoji;

//   const ChatInputBar({
//     super.key,
//     this.showSuggestions = true,
//     this.onSend,
//     this.onSendAudio,
//     this.onAttach,
//     this.onCamera,
//     this.onEmoji,
//   });

//   @override
//   State<ChatInputBar> createState() => _ChatInputBarState();
// }

// class _ChatInputBarState extends State<ChatInputBar> with SingleTickerProviderStateMixin {
//   final TextEditingController _controller = TextEditingController();
//   bool _isHasText = false;
  
//   // Recording variables
//   late Record _audioRecorder;
//   late AudioPlayer _audioPlayer;
//   bool _isRecording = false;
//   bool _isLocked = false;
//   bool _isCanceled = false;
//   bool _isPlaying = false;
//   String? _recordingPath;
//   Duration _recordingDuration = Duration.zero;
//   Duration _playingDuration = Duration.zero;
  
//   // Gesture tracking
//   Offset _dragStartPosition = Offset.zero;
//   Offset _dragOffset = Offset.zero;
  
//   // Animation
//   late AnimationController _animationController;
//   late Animation<double> _waveAnimation;
  
//   // Waveform data (simulated)
//   final List<double> _waveformData = List.generate(20, (index) => 0.3 + (index % 3) * 0.2);

//   @override
//   void initState() {
//     super.initState();
//     _audioRecorder = Record();
//     _audioPlayer = AudioPlayer();
    
//     _controller.addListener(() {
//       setState(() {
//         _isHasText = _controller.text.trim().isNotEmpty;
//       });
//     });

//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     )..repeat();
    
//     _waveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    
//     // Listen to audio player events
//     _audioPlayer.onPlayerStateChanged.listen((state) {
//       setState(() {
//         _isPlaying = state == PlayerState.playing;
//       });
//     });
    
//     _audioPlayer.onDurationChanged.listen((duration) {
//       setState(() {
//         _playingDuration = duration;
//       });
//     });
    
//     _audioPlayer.onPositionChanged.listen((duration) {
//       setState(() {
//         _playingDuration = duration;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     // Record package لا يوفّر dispose() لذلك نحذفه لتجنب الخطأ
//     _audioPlayer.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }

//   Future<bool> _ensureMicPermission() async {
//     final status = await Permission.microphone.request();
//     return status.isGranted;
//   }

//   Future<void> _startRecording() async {
//     try {
//       if (!await _ensureMicPermission()) return;
//       if (await _audioRecorder.hasPermission()) {
//         final dir = await getApplicationDocumentsDirectory();
//         final filePath = '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
        
//         await _audioRecorder.start(
//           path: filePath,
//           encoder: AudioEncoder.aacLc,
//           bitRate: 128000,
//           samplingRate: 44100,
//         );
        
//         setState(() {
//           _isRecording = true;
//           _isCanceled = false;
//           _isLocked = false;
//           _dragOffset = Offset.zero;
//           _recordingPath = filePath;
//           _recordingDuration = Duration.zero;
//         });
        
//         // Update recording duration
//         _startDurationTimer();
//       }
//     } catch (e) {
//       print('Error starting recording: $e');
//     }
//   }

//   void _startDurationTimer() {
//     Future.doWhile(() async {
//       if (_isRecording) {
//         await Future.delayed(const Duration(milliseconds: 100));
//         setState(() {
//           _recordingDuration += const Duration(milliseconds: 100);
//         });
//         return true;
//       }
//       return false;
//     });
//   }

//   Future<void> _stopRecording() async {
//     try {
//       final path = await _audioRecorder.stop();
//       setState(() {
//         _isRecording = false;
//         _isLocked = false;
//         _recordingPath = path;
//       });
//     } catch (e) {
//       print('Error stopping recording: $e');
//     }
//   }

//   Future<void> _cancelRecording() async {
//     try {
//       await _audioRecorder.stop();
//       if (_recordingPath != null) {
//         final file = File(_recordingPath!);
//         if (await file.exists()) {
//           await file.delete();
//         }
//       }
//       setState(() {
//         _isRecording = false;
//         _isCanceled = true;
//         _isLocked = false;
//         _recordingPath = null;
//         _recordingDuration = Duration.zero;
//       });
//     } catch (e) {
//       print('Error canceling recording: $e');
//     }
//   }

//   void _lockRecording() {
//     setState(() {
//       _isLocked = true;
//       _dragOffset = Offset.zero;
//     });
//   }

//   Future<void> _playRecording() async {
//     if (_recordingPath == null) return;
    
//     try {
//       if (_isPlaying) {
//         await _audioPlayer.pause();
//       } else {
//         await _audioPlayer.play(DeviceFileSource(_recordingPath!));
//       }
//     } catch (e) {
//       print('Error playing recording: $e');
//     }
//   }

//   Future<void> _deleteRecording() async {
//     try {
//       await _audioPlayer.stop();
//       if (_recordingPath != null) {
//         final file = File(_recordingPath!);
//         if (await file.exists()) {
//           await file.delete();
//         }
//       }
//       setState(() {
//         _recordingPath = null;
//         _recordingDuration = Duration.zero;
//         _playingDuration = Duration.zero;
//         _isPlaying = false;
//       });
//     } catch (e) {
//       print('Error deleting recording: $e');
//     }
//   }

//   Future<void> _sendRecording() async {
//     if (_recordingPath != null) {
//       widget.onSendAudio?.call(_recordingPath!);
//       await _deleteRecording();
//     }
//   }

//   void _handleVoiceButtonTap() {
//     if (_isHasText) {
//       widget.onSend?.call(_controller.text.trim());
//       _controller.clear();
//     } else if (_isLocked && _recordingPath != null) {
//       // Send the recording if locked
//       _sendRecording();
//     }
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return '$minutes:$seconds';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(top: 16, bottom: 20, left: 16, right: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           top: BorderSide(color: Colors.grey.shade200, width: 0.5),
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Recording preview section
//           if (_recordingPath != null && !_isRecording) ...[
//             _buildRecordingPreview(),
//             const SizedBox(height: 16),
//           ],
          
//           // Recording indicator
//           if (_isRecording && !_isLocked) ...[
//             _buildRecordingIndicator(),
//             const SizedBox(height: 16),
//           ],
          
//           // Suggestions
//           if (widget.showSuggestions && !_isRecording && _recordingPath == null) ...[
//             _buildSuggestions(),
//             const SizedBox(height: 16),
//           ],
          
//           // Main input row
//           Row(
//             children: [
//               // Emoji button
//               if (!_isRecording && _recordingPath == null) ...[
//                 IconButton(
//                   onPressed: widget.onEmoji,
//                   icon: Icon(
//                     Icons.emoji_emotions_outlined,
//                     color: Colors.grey[600],
//                     size: 24,
//                   ),
//                   padding: EdgeInsets.zero,
//                   constraints: const BoxConstraints(),
//                 ),
//                 const SizedBox(width: 8),
//               ],
              
//               // Input field or recording content
//               Expanded(
//                 child: Container(
//                   height: 44,
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   decoration: BoxDecoration(
//                     color: _isRecording ? Colors.red[50] : Colors.grey[50],
//                     borderRadius: BorderRadius.circular(24),
//                     border: Border.all(
//                       color: _isRecording ? Colors.red[300]! : Colors.grey[300]!,
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: _isRecording
//                             ? _buildRecordingContent()
//                             : TextField(
//                                 controller: _controller,
//                                 maxLines: 1,
//                                 style: const TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.black87,
//                                 ),
//                                 decoration: const InputDecoration(
//                                   hintText: "Message...",
//                                   border: InputBorder.none,
//                                   hintStyle: TextStyle(
//                                     color: Color(0xFF9CA3AF),
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                   contentPadding: EdgeInsets.zero,
//                                 ),
//                               ),
//                       ),
//                       if (!_isRecording && _recordingPath == null) ...[
//                         IconButton(
//                           onPressed: widget.onAttach,
//                           icon: Icon(
//                             Icons.attach_file,
//                             size: 20,
//                             color: Colors.grey[600],
//                           ),
//                           padding: EdgeInsets.zero,
//                           constraints: const BoxConstraints(),
//                         ),
//                         const SizedBox(width: 4),
//                         IconButton(
//                           onPressed: widget.onCamera,
//                           icon: Icon(
//                             Icons.camera_alt_outlined,
//                             size: 20,
//                             color: Colors.grey[600],
//                           ),
//                           padding: EdgeInsets.zero,
//                           constraints: const BoxConstraints(),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ),
              
//               const SizedBox(width: 8),
              
//               // Send/Mic button
//               GestureDetector(
//                 onLongPressStart: (details) {
//                   if (_recordingPath == null) {
//                     _dragStartPosition = details.globalPosition;
//                     _startRecording();
//                   }
//                 },
//                 onLongPressMoveUpdate: (details) {
//                   if (_isLocked || _recordingPath != null) return;

//                   setState(() {
//                     _dragOffset = details.globalPosition - _dragStartPosition;
//                   });

//                   // Slide to cancel (left)
//                   if (_dragOffset.dx < -50 && !_isCanceled) {
//                     _cancelRecording();
//                   }
//                   // Slide to lock (up)
//                   else if (_dragOffset.dy < -50 && !_isLocked) {
//                     _lockRecording();
//                   }
//                 },
//                 onLongPressEnd: (details) {
//                   if (_isCanceled) {
//                     // Already canceled
//                   } else if (_isLocked) {
//                     // Recording locked, continue
//                   } else if (_isRecording) {
//                     _stopRecording();
//                   }
//                 },
//                 onTap: _handleVoiceButtonTap,
//                 child: Container(
//                   width: 44,
//                   height: 44,
//                   decoration: BoxDecoration(
//                     color: _isRecording || _isLocked
//                         ? Colors.red
//                         : _isHasText
//                             ? const Color(0xFF007AFF)
//                             : Colors.grey[200],
//                     shape: BoxShape.circle,
//                   ),
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Icon(
//                         _isRecording && !_isLocked
//                             ? Icons.mic_outlined
//                             : _isLocked
//                                 ? Icons.stop_rounded
//                                 : _isHasText
//                                     ? Icons.send_rounded
//                                     : Icons.mic_outlined,
//                         color: _isRecording || _isLocked || _isHasText
//                             ? Colors.white
//                             : Colors.grey[600],
//                         size: 22,
//                       ),
//                       if (_isRecording && !_isLocked)
//                         Positioned(
//                           right: 0,
//                           top: 0,
//                           child: Container(
//                             width: 10,
//                             height: 10,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               shape: BoxShape.circle,
//                               border: Border.all(color: Colors.red, width: 1),
//                             ),
//                             child: const Center(
//                               child: Icon(
//                                 Icons.fiber_manual_record,
//                                 color: Colors.red,
//                                 size: 6,
//                               ),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRecordingIndicator() {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.keyboard_voice,
//               color: Colors.red,
//               size: 20,
//             ),
//             const SizedBox(width: 8),
//             Text(
//               _isLocked ? "Recording Locked" : "Recording...",
//               style: TextStyle(
//                 color: Colors.red[700],
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//               decoration: BoxDecoration(
//                 color: Colors.red[50],
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: Colors.red[100]!),
//               ),
//               child: Text(
//                 _formatDuration(_recordingDuration),
//                 style: TextStyle(
//                   color: Colors.red[800],
//                   fontWeight: FontWeight.w700,
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             if (!_isLocked)
//               GestureDetector(
//                 onTap: _cancelRecording,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     "Cancel",
//                     style: TextStyle(
//                       color: Colors.grey[800],
//                       fontWeight: FontWeight.w600,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildRecordingContent() {
//     return Row(
//       children: [
//         Icon(
//           Icons.keyboard_voice,
//           color: Colors.red,
//           size: 20,
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Animated waveform
//               Row(
//                 children: List.generate(
//                   _waveformData.length,
//                   (index) => Expanded(
//                     child: AnimatedBuilder(
//                       animation: _waveAnimation,
//                       builder: (context, child) {
//                         final height = 8.0 + (_waveformData[index] * 12 * _waveAnimation.value);
//                         return Container(
//                           height: height,
//                           margin: const EdgeInsets.symmetric(horizontal: 1.5),
//                           decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.circular(2),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 _isLocked ? "Tap to send" : "< Slide to cancel",
//                 style: TextStyle(
//                   color: Colors.grey[600],
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildRecordingPreview() {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Audio Recording",
//                 style: TextStyle(
//                   color: Colors.grey[800],
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: _deleteRecording,
//                 child: Icon(
//                   Icons.close,
//                   color: Colors.grey[600],
//                   size: 20,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               GestureDetector(
//                 onTap: _playRecording,
//                 child: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     _isPlaying ? Icons.pause : Icons.play_arrow,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(4),
//                       child: LinearProgressIndicator(
//                         value: _playingDuration.inMilliseconds > 0
//                             ? (_playingDuration.inMilliseconds /
//                                 _recordingDuration.inMilliseconds)
//                             : 0,
//                         minHeight: 4,
//                         backgroundColor: Colors.grey[300],
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       "${_formatDuration(_recordingDuration)}",
//                       style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 12),
//               GestureDetector(
//                 onTap: _sendRecording,
//                 child: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.green,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.send,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSuggestions() {
//     final suggestions = [
//       "Is it still available?",
//       "Can you send another picture?",
//       "What's the condition?",
//       "Would you take an offer?"
//     ];

//     return SizedBox(
//       height: 36,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: suggestions.length,
//         separatorBuilder: (_, __) => const SizedBox(width: 8),
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               _controller.text = suggestions[index];
//               setState(() {
//                 _isHasText = true;
//               });
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 color: Colors.grey[50],
//                 borderRadius: BorderRadius.circular(18),
//                 border: Border.all(color: Colors.grey[300]!),
//               ),
//               child: Center(
//                 child: Text(
//                   suggestions[index],
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[800],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
