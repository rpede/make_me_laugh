import 'package:cloud_text_to_speech/cloud_text_to_speech.dart';
import 'package:flutter/material.dart';
import 'package:make_me_laugh/data/joke_dto.dart';
import 'package:audioplayers/audioplayers.dart';

class JokeTts extends StatefulWidget {
  final JokeDto joke;
  const JokeTts(this.joke, {super.key});

  @override
  State<JokeTts> createState() => _JokeTtsState();
}

class _JokeTtsState extends State<JokeTts> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _speak();
  }

  @override
  void dispose() {
    player.stop().then((value) => player.dispose());
    super.dispose();
  }

  Future<void> _speak() async {
    var text = "";
    if (widget.joke.type == 'single') {
      text = widget.joke.joke!;
    } else {
      text = "${widget.joke.setup}\n\n${widget.joke.delivery}";
    }

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

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
