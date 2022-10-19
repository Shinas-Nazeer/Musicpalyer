import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:mymusicapp/screens/Screen_playlist.dart';
import 'package:mymusicapp/screens/Screen_search.dart';
import 'package:mymusicapp/widgets/settings.dart';
import 'package:mymusicapp/widgets/songslist.dart';
import '../Functions/text.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Songs'),
    const Tab(text: 'Playlist'),
  ];
    AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: krose,
          tabBarTheme: (const TabBarTheme(
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
              width: 2.0,
              color: krose,
            )),
            labelColor: krose,
            labelStyle: TextStyle(fontFamily: ('Itim'), fontSize: 23.0),
          ))),
      home: DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                  color: krose, size: 28.0),
              centerTitle: true,
              actions: [
                IconButton(onPressed: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ScreenSearch(
                        audioPlayer: audioPlayer,
                      );
                    },
                  ),
                );




                }, icon: const Icon(Icons.search))
              ],
              elevation: 0,
              backgroundColor: Colors.white,
              bottom: TabBar(
                tabs: myTabs,
              ),
              title:  Text("Music Player",style: coustomFont(fontSize: 23.0) )
            ),
            drawer: const SettingScreen(),
            body:  TabBarView(children: [Songlist(), PlaylistScreen()])),
      ),
    );
  }
}
