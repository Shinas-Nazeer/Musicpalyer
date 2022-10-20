import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mymusicapp/Functions/text.dart';
import 'package:mymusicapp/widgets/songslist.dart';

import '../Functions/functions.dart';
import '../db/functins/db_functions.dart';
import '../db/songs.dart';

class ScreenFavourites extends StatelessWidget {
  ScreenFavourites({super.key, required this.playlistName});
  final String playlistName;

  final Box<List> playlistBox = getlibrarybox();
  final Box<AllSongs> songBox = getSongBox();

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: krose,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          playlistName,
          style: coustomFont(fontSize: 24),
          
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
        child: ValueListenableBuilder(
          valueListenable: playlistBox.listenable(),
          builder: (BuildContext context, Box<List> value, Widget? child) {
            List<AllSongs> songList =
                playlistBox.get(playlistName)!.toList().cast<AllSongs>();
            return (songList.isEmpty)
                ? Center(
                    child: Text('No Songs Found',
                    style: coustomFont(fontSize: 15),),
                  )
                : ListView.builder(
                    itemCount: songList.length,
                    itemBuilder: (context, index) {
                      return AllSongsList(
                        onPressed: () {
                          showPlaylistModalSheet(
                            context: context,
                            screenHeight: screenHeight,
                            song: songList[index],
                          );
                        },
                        songList: songList,
                        index: index,
                        audioPlayer: audioPlayer,
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
