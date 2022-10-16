import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:mymusicapp/provider/song_model_provider.dart';

import 'package:mymusicapp/splashscreen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => SongModelProvider(),
    child: const Myapp(),
  ));
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        // primaryColor: Color.fromARGB(255, 209, 28, 15),
        // textTheme: TextTheme(bodyText1: )

      ),
      debugShowCheckedModeBanner: false,
      home: ScreenSplash(),
    );
  }
}