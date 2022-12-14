import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mymusicapp/Functions/text.dart';

import 'package:mymusicapp/widgets/playlisttop.dart';

import '../Functions/functions.dart';
import '../db/functins/db_functions.dart';
import '../db/songs.dart';
import '../widgets/createdplaylist.dart';
import 'addplaylist.dart';

class PlaylistScreen extends StatelessWidget {
  PlaylistScreen({super.key});
  Box<List> playlistBox = getlibrarybox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 241, 81, 183),
          foregroundColor: Colors.white,
          child: const Icon(Icons.playlist_add),
          onPressed: () {
            showCreatingPlaylistDialoge(context: context);
          },
        ),
        body: Column(
          children: [
            CoutomPlaylist(playlistName: 'Recent'),
            CoutomPlaylist(playlistName: 'Favourites'),
            CoutomPlaylist(playlistName: 'Most Played'),
            Expanded(child: Scaffold(body: createdplay()))
          ],
        ));
  }

  ValueListenableBuilder<Box<List<dynamic>>> createdplay() {
    return ValueListenableBuilder(
      valueListenable: playlistBox.listenable(),
      builder: (context, value, child) {
        List keys = playlistBox.keys.toList();
        keys.removeWhere((key) => key == 'Favourites');
        keys.removeWhere((key) => key == 'Recent');
        keys.removeWhere((key) => key == 'Most Played');
        keys.removeWhere((key) => key == 'Likedsong');
        keys.removeWhere((key) => key == 'Mostplayed');
        return (keys.isEmpty)
            ?  Center(
                child: Text('No Created Playlist..', style: coustomFont(fontSize: 15),),
              )

          
            : ListView.builder(
                itemCount: keys.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
             
                itemBuilder: (context, index) {
                  final String playlistName = keys[index];

                  final List<AllSongs> songList =
                      playlistBox.get(playlistName)!.toList().cast<AllSongs>();

                  final int songListlength = songList.length;

                  return CreatedPlaylist(
                    playlistName: playlistName,
                    playlistSongNum: '$songListlength Songs',
                  );
                },
              );
      },
    );
  }
}
