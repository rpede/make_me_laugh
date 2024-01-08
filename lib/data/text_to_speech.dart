import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_text_to_speech/cloud_text_to_speech.dart';

class TextToSpeech {
  final player = AudioPlayer();

  Future<void> dispose() async {
    await player.stop();
    await player.dispose();
  }

  Future<void> speak(String text) async {
    final voicesResponse = await TtsMicrosoft.getVoices();
    final voices = voicesResponse.voices;

    TtsParamsMicrosoft ttsParams = TtsParamsMicrosoft(
      voice:
          voices.firstWhere((element) => element.locale.code.startsWith("en-")),
      audioFormat: AudioOutputFormatMicrosoft.audio48Khz192kBitrateMonoMp3,
      text: text,
    );

    final ttsResponse = await TtsMicrosoft.convertTts(ttsParams);

    player.play(BytesSource(ttsResponse.audio.buffer.asUint8List()));
  }
}
