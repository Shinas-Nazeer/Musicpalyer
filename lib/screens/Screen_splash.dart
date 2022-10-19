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
  
  Box<List> librarysongbox = getlibrarybox();
  Box<AllSongs> allSongsBox = getSongBox();


  

List<SongModel> onAudioQuerysongs = []; //for first fetched song
  List<SongModel> sortedsongs = []; //for after sorted
  List<List> likedsongs = []; //for liked screen value
  List<List> recentsongs = []; //for recenlyplayed
  List<List> mostplaed = [];


  

  final audioQuery = OnAudioQuery();



  @override
  void initState() {
     requestPermission();
     songfetchngfuction();
     super.initState();
     gotoScreenHome(context);
    
    
  }
  void requestPermission() async{
   await Permission.storage.request();
  }

 Future songfetchngfuction() async {
    onAudioQuerysongs = await audioQuery.querySongs(
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.ASC_OR_SMALLER,
      ignoreCase: true,
      uriType: UriType.EXTERNAL,
    );
    //for sorting the song
    for (var song in onAudioQuerysongs) {
      if (song.fileExtension == 'mp3') {
        sortedsongs.add(song);
      }
    }
    //for adding to hive of all songs
    for (var audio in sortedsongs) {
      final song = AllSongs(
        id: audio.id.toString(),
        songname: audio.displayNameWOExt,
        path: audio.uri!,
        songartist: audio.artist!,
      );
      await allSongsBox.put(song.id, song);
    }
    getlikedsongs();
    getrecentplaylist();
    getmostplaed();
  }

  //for add fav song
  getlikedsongs() async {
    if (!librarysongbox.keys.contains('Likedsong')) {
      await librarysongbox.put('Likedsong', likedsongs);
    }
  }

//for recentsong
  getrecentplaylist() async {
    if (!librarysongbox.keys.contains('Recent')) {
      await librarysongbox.put('Recent', recentsongs);
    }
  }
  //for mostplaed

  getmostplaed() async {
    if (!librarysongbox.keys.contains('Mostplayed')) {
      await librarysongbox.put('Mostplayed', mostplaed);
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
                'assets/image/Icon musi cpalyer.png',
                width: 200,
                height: 200,
              ),
              Text("Music Player", style: coustomFont(fontSize: 14))
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