import 'package:flutter/material.dart';
import '../../../core/models/cctv.dart';
import '../../../core/constants/app_colors.dart';

class CctvPlayer extends StatefulWidget {
  final CCTV cctv;

  const CctvPlayer({
    super.key,
    required this.cctv,
  });

  @override
  State<CctvPlayer> createState() => _CctvPlayerState();
}

class _CctvPlayerState extends State<CctvPlayer> {
  bool _isPlaying = false;
  double _currentPosition = 0.5; // 0.0 to 1.0
  String _currentTime = "23:01:00";

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _rewind() {
    setState(() {
      _currentPosition = (_currentPosition - 0.1).clamp(0.0, 1.0);
      _updateTimeDisplay();
    });
  }

  void _fastForward() {
    setState(() {
      _currentPosition = (_currentPosition + 0.1).clamp(0.0, 1.0);
      _updateTimeDisplay();
    });
  }

  void _updateTimeDisplay() {
    // This is a simplified time calculation for demonstration
    // In a real app, you would calculate this based on video duration
    int hour = 23;
    int minute = ((_currentPosition * 60) % 60).floor();
    int second = ((_currentPosition * 3600) % 60).floor();
    
    _currentTime = "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}";
  }

  void _onSliderChanged(double value) {
    setState(() {
      _currentPosition = value;
      _updateTimeDisplay();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // CCTV Video Feed
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            color: Colors.black,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // CCTV Feed (using placeholder image for demo)
                Image.asset(
                  'assets/images/cctv_feed.jpg',
                  fit: BoxFit.cover,
                ),
                
                // Overlay elements like timestamp, camera ID
                Positioned(
                  top: 16,
                  left: 16,
                  child: Text(
                    'CAM 01    11/30/16    00:03:05:14',
                    style: TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.black.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Controls and Info
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Live indicator and CCTV info
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'Live',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                // CCTV Name and Location
                Text(
                  widget.cctv.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.cctv.location,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Time display
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _currentTime,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                // Slider
                SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 4,
                    activeTrackColor: Colors.blue,
                    inactiveTrackColor: Colors.grey[300],
                    thumbColor: Colors.white,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 8,
                      elevation: 2,
                    ),
                    overlayColor: Colors.blue.withOpacity(0.2),
                  ),
                  child: Slider(
                    value: _currentPosition,
                    onChanged: _onSliderChanged,
                  ),
                ),
                
                // Playback controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Rewind button
                    ElevatedButton(
                      onPressed: _rewind,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16),
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.blue,
                        elevation: 0,
                      ),
                      child: const Icon(Icons.fast_rewind),
                    ),
                    
                    // Play/Pause button
                    ElevatedButton(
                      onPressed: _togglePlayPause,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16),
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.blue,
                        elevation: 0,
                      ),
                      child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                    ),
                    
                    // Fast forward button
                    ElevatedButton(
                      onPressed: _fastForward,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16),
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.blue,
                        elevation: 0,
                      ),
                      child: const Icon(Icons.fast_forward),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
