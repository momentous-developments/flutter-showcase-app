import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class VoiceMessagePlayer extends StatefulWidget {
  final String url;
  final int duration;
  final List<double>? waveform;

  const VoiceMessagePlayer({
    super.key,
    required this.url,
    required this.duration,
    this.waveform,
  });

  @override
  State<VoiceMessagePlayer> createState() => _VoiceMessagePlayerState();
}

class _VoiceMessagePlayerState extends State<VoiceMessagePlayer>
    with TickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  late AnimationController _waveAnimationController;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _totalDuration = Duration(seconds: widget.duration);
    
    _waveAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });

      if (_isPlaying) {
        _waveAnimationController.repeat();
      } else {
        _waveAnimationController.stop();
      }
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _totalDuration = duration;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _waveAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _togglePlayback,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWaveform(),
                const SizedBox(height: 4),
                _buildProgressBar(),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _formatDuration(_totalDuration - _currentPosition),
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaveform() {
    if (widget.waveform == null || widget.waveform!.isEmpty) {
      return _buildDefaultWaveform();
    }

    return SizedBox(
      height: 20,
      child: Row(
        children: widget.waveform!.asMap().entries.map((entry) {
          final index = entry.key;
          final amplitude = entry.value;
          
          final progress = _totalDuration.inMilliseconds > 0
              ? _currentPosition.inMilliseconds / _totalDuration.inMilliseconds
              : 0.0;
          
          final barProgress = progress * widget.waveform!.length;
          final isActive = index < barProgress;

          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 0.5),
              height: (amplitude * 20).clamp(2.0, 20.0),
              decoration: BoxDecoration(
                color: isActive
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDefaultWaveform() {
    return AnimatedBuilder(
      animation: _waveAnimationController,
      builder: (context, child) {
        return SizedBox(
          height: 20,
          child: Row(
            children: List.generate(20, (index) {
              final animationOffset = (_waveAnimationController.value * 2 - 1) * 10;
              final baseHeight = 4.0;
              final animationHeight = _isPlaying
                  ? (1 + 0.5 * (1 + (animationOffset - index).abs() / 10).clamp(0.0, 1.0)) * baseHeight
                  : baseHeight;

              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 0.5),
                  height: animationHeight,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildProgressBar() {
    return LinearProgressIndicator(
      value: _totalDuration.inMilliseconds > 0
          ? _currentPosition.inMilliseconds / _totalDuration.inMilliseconds
          : 0.0,
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
      minHeight: 2,
    );
  }

  Future<void> _togglePlayback() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play(UrlSource(widget.url));
      }
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}