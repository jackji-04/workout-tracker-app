class DateStore {
  final String time;
  final int duration;
  final String exercise;

  const DateStore({
    required this.time,
    required this.duration,
    required this.exercise,
  });

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'duration': duration,
      'exercise': exercise,
    };
  }

  @override
  String toString() {
    return 'Exercise{t: $time, dur: $duration, exe: $exercise}';
  }
}