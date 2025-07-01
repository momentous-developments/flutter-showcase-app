import 'package:flutter/material.dart';
import 'package:record/record.dart';

class VoiceRecorder extends StatefulWidget {
  final Function(String path, int duration, List<double> waveform) onRecordingComplete;
  final VoidCallback? onRecordingStart;
  final VoidCallback? onRecordingCancel;

  const VoiceRecorder({
    super.key,
    required this.onRecordingComplete,
    this.onRecordingStart,
    this.onRecordingCancel,
  });

  @override
  State<VoiceRecorder> createState() => _VoiceRecorderState();
}

class _VoiceRecorderState extends State<VoiceRecorder>
    with TickerProviderStateMixin {
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  DateTime? _recordingStartTime;
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late Animation<double> _pulseAnimation;
  List<double> _waveform = [];

  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _waveController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_isRecording) _buildWaveformVisualization(),
        if (_isRecording) _buildRecordingTimer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isRecording) ...[
              // Cancel button
              GestureDetector(
                onTap: _cancelRecording,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(width: 40),
              // Recording indicator
              ScaleTransition(
                scale: _pulseAnimation,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(width: 40),
              // Stop button
              GestureDetector(
                onTap: _stopRecording,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ] else
              // Start recording button
              GestureDetector(
                onTap: _startRecording,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildWaveformVisualization() {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: AnimatedBuilder(
        animation: _waveController,
        builder: (context, child) {
          return Row(
            children: List.generate(30, (index) {
              final amplitude = _waveform.isNotEmpty && index < _waveform.length
                  ? _waveform[index]
                  : 0.1 + (index % 3) * 0.2;
              
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  height: (amplitude * 50).clamp(5.0, 50.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildRecordingTimer() {
    return StreamBuilder<int>(
      stream: _getTimerStream(),
      builder: (context, snapshot) {
        final seconds = snapshot.data ?? 0;
        final minutes = seconds ~/ 60;
        final remainingSeconds = seconds % 60;
        
        return Text(
          '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        );
      },
    );
  }

  Stream<int> _getTimerStream() {
    return Stream.periodic(const Duration(seconds: 1), (i) {
      if (_recordingStartTime != null) {
        return DateTime.now().difference(_recordingStartTime!).inSeconds;
      }
      return 0;
    });
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final path = 'voice_message_${DateTime.now().millisecondsSinceEpoch}.m4a';
        await _audioRecorder.start(const RecordConfig(), path: path);
        
        setState(() {
          _isRecording = true;
          _recordingStartTime = DateTime.now();
          _waveform.clear();
        });
        
        _pulseController.repeat(reverse: true);
        widget.onRecordingStart?.call();
        
        // Simulate waveform data (in real app, you'd get this from audio processing)
        _simulateWaveform();
      }
    } catch (e) {
      debugPrint('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      final duration = _recordingStartTime != null
          ? DateTime.now().difference(_recordingStartTime!).inSeconds
          : 0;
      
      setState(() {
        _isRecording = false;
        _recordingStartTime = null;
      });
      
      _pulseController.stop();
      
      if (path != null) {
        widget.onRecordingComplete(path, duration, List.from(_waveform));
      }
    } catch (e) {
      debugPrint('Error stopping recording: $e');
    }
  }

  void _cancelRecording() async {
    try {
      await _audioRecorder.stop();
      
      setState(() {
        _isRecording = false;
        _recordingStartTime = null;
        _waveform.clear();
      });
      
      _pulseController.stop();
      widget.onRecordingCancel?.call();
    } catch (e) {
      debugPrint('Error canceling recording: $e');
    }
  }

  void _simulateWaveform() {
    if (!_isRecording) return;
    
    // Simulate audio amplitude data
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_isRecording) {
        setState(() {
          _waveform.add(0.1 + (DateTime.now().millisecond % 100) / 100.0);
          if (_waveform.length > 30) {
            _waveform.removeAt(0);
          }
        });
        _waveController.forward().then((_) => _waveController.reset());
        _simulateWaveform();
      }
    });
  }
}