/// The three compression presets offered on the Compress PDF screen.
enum CompressLevel { high, medium, low }

extension CompressLevelX on CompressLevel {
  String get label => switch (this) {
    CompressLevel.high => 'High',
    CompressLevel.medium => 'Medium',
    CompressLevel.low => 'Low',
  };

  String get subtitle => switch (this) {
    CompressLevel.high => 'Smallest size',
    CompressLevel.medium => 'Balanced',
    CompressLevel.low => 'Best quality',
  };
}
