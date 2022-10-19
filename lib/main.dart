import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mymusicapp/screens/Screen_splash.dart';

import 'db/songs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(AllSongsAdapter());
  }
  await Hive.openBox<AllSongs>('AllSongs');
  await Hive.openBox<List>('Library');

runApp(const Myapp());

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
      home: const ScreenSplash(),
    );
  }
}