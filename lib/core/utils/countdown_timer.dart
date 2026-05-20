import 'dart:async';

class CountdownTimer {
  int totalSeconds;
  late Timer _timer;
  late int _currentSeconds;

  CountdownTimer({required this.totalSeconds}) {
    _currentSeconds = totalSeconds;
  }

  // Starts the countdown
  void start(Function(String) onTick, {Function? onFinish}) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSeconds > 0) {
        _currentSeconds--;
        onTick(_formatTime(_currentSeconds));
      } else {
        _timer.cancel();
        if (onFinish != null) {
          onFinish();
        }
      }
    });
  }

  // Formats the current seconds into mm:ss
  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  // Stops the countdown
  void stop() {
    _timer.cancel();
  }

  // Resets the countdown
  void reset() {
    _currentSeconds = totalSeconds;
  }
}
