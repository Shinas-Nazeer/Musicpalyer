// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Functions/text.dart';
import '../db/functins/db_functions.dart';
import '../db/songs.dart';

import 'Screen_home.dart';


class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  
  OnAudioQuery audioQuery = OnAudioQuery();

  Box<List> playlistBox = getlibrarybox();
  Box<AllSongs> songBox = getSongBox();

  List<SongModel> deviceSongs = [];
  List<SongModel> fetchedSongs = [];

  @override
  void initState() {
    requestPermission();
    fetchSongs();
    super.initState();
    gotoScreenHome(context);
  }

  Future<void> requestPermission() async {
    await Permission.storage.request();
  }

  Future fetchSongs() async {
    deviceSongs = await audioQuery.querySongs(
      sortType: SongSortType.TITLE,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    for (var song in deviceSongs) {
      if (song.fileExtension == 'mp3') {
        fetchedSongs.add(song);
      }
    }

    for (var audio in fetchedSongs) {
      final song = AllSongs(
        id: audio.id.toString(),
        songname: audio.displayNameWOExt,
        songartist: audio.artist!,
        path: audio.uri!,
      );
      await songBox.put(audio.id, song);
    }
    //create a Favourite songs if it is not created
    getFavSongs();
    getRecentSongs();
    getMostPlayedSongs();
  }

  Future getFavSongs() async {
    if (!playlistBox.keys.contains('Favourites')) {
      await playlistBox.put('Favourites', []);
    }
  }

  Future getMostPlayedSongs() async {
    if (!playlistBox.keys.contains('Most Played')) {
      await playlistBox.put('Most Played', []);
    }
  }

  Future getRecentSongs() async {
    if (!playlistBox.keys.contains('Recent')) {
      await playlistBox.put('Recent', []);
    }
  }
  



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/launcher.png',
                
              ),
              Text("Music Player", style: coustomFont(fontSize: 20))
            ],
          ),
        ),
      ),
    );
  }


Future<void> gotoScreenHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => const MainScreen(),
      ),
    );
  

}
  
}