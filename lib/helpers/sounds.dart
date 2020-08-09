import 'package:audioplayers/audio_cache.dart';

/// Plays a sound.
Future<void> play(String source) async {
  final AudioCache cache = AudioCache();
  await cache.play("sounds/$source.mpeg");
}
