import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mymusicapp/Functions/text.dart';

import '../Functions/functions.dart';
import '../Functions/playlistfun.dart';
import '../db/functins/db_functions.dart';
import '../db/songs.dart';
import '../widgets/songslist.dart';
import 'Screen_search.dart';

class ScreenCreatedPlaylist extends StatefulWidget {
  const ScreenCreatedPlaylist({super.key, required this.playlistName});
   final String playlistName;

  @override
  State<ScreenCreatedPlaylist> createState() => _ScreenCreatedPlaylistState();
}

class _ScreenCreatedPlaylistState extends State<ScreenCreatedPlaylist> {
  String? newPlaylistName;
  @override
  void initState() {
    newPlaylistName = widget.playlistName;
    super.initState();
  }

  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  Box<AllSongs> songBox = getSongBox();
  Box<List> playlistBox = getlibrarybox();
  @override
  Widget build(BuildContext context) {
     final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      
      appBar: (
      AppBar(
        iconTheme: IconThemeData(color: krose),
         centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(newPlaylistName!,style: coustomFont(fontSize: 14),),
      
         actions: [
          IconButton(
            onPressed: () {
            
              final List<AllSongs> playlistSongs =
                  playlistBox.get(newPlaylistName)!.toList().cast<AllSongs>();
              showEditingPlaylistDialoge(
                context: context,
                playlistName: newPlaylistName!,
                playlistSongs: playlistSongs,
                
              );
            },
            icon: const Icon(
              Icons.edit,
              color: krose,
            ),
          ),
          IconButton(
            onPressed: () {
              showSongModalSheet(
                context: context,
                screenHeight: screenHeight,
                playlistKey: newPlaylistName!,
              );
            },
            icon: const Icon(
              Icons.add,
              size: 27,
              color: krose
            ),
          )
        ],
     

      )
    ),
    body:Playlistsongs(playlistBox: playlistBox, newPlaylistName: newPlaylistName, audioPlayer: audioPlayer),
    
    
    
    );
  }
    showEditingPlaylistDialoge({
    required BuildContext context,
    required String playlistName,
    required List<AllSongs> playlistSongs,
  }) {
    final TextEditingController textController =
        TextEditingController(text: playlistName);
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          final formKey = GlobalKey<FormState>();
          return Form(
            key: formKey,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              backgroundColor: Colors.white,
              title:  Text(
                'Edit playlist',
                style: coustomFont(fontSize: 14)
              ),
              content: SearchField(
                textController: textController,
                hintText: 'Playlist Name',
                icon: Icons.playlist_add,
                validator: (value) {
                  final keys = getlibrarybox().keys.toList();
                  if (value == null || value.isEmpty) {
                    return 'Field is empty';
                  }
                  if (keys.contains(value)) {
                    return '$value already exist in playlist';
                  }
                  return null;
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: krose, fontSize: 15),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final playlistBox = getlibrarybox();
                      setState(() {
                        newPlaylistName = textController.text.trim();
                      });
                      await playlistBox.put(newPlaylistName, playlistSongs);
                      playlistBox.delete(playlistName);
                      Navigator.pop(ctx);
                    }
                  },
                  child: Text(
                    'Confirm',
                    style:coustomFont(fontSize: 15)),
                  
                ),
              ],
            ),
          );
        });
  }
}






class Playlistsongs extends StatelessWidget {
  const Playlistsongs({
    Key? key,
    required this.playlistBox,
    required this.newPlaylistName,
    required this.audioPlayer,
  }) : super(key: key);

  final Box<List> playlistBox;
  final String? newPlaylistName;
  final AssetsAudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<List<dynamic>>>(
      valueListenable: playlistBox.listenable(),
      builder: (context, boxSongList, _) {
        final List<AllSongs> songList =
            boxSongList.get(newPlaylistName)!.cast<AllSongs>();

        if (songList.isEmpty) {
          return  Center(
            child: Text('No Songs Found', style: coustomFont(fontSize: 15),),
          );
        }
        return ListView.builder(
          itemCount: songList.length,
          itemBuilder: (ctx, index) {
            return AllSongsList(
                icon: Icons.delete_outline_rounded,
                onPressed: () {
                  UserPlaylist.deleteFromPlaylist(
                    context: context,
                    songId: songList[index].id,
                    playlistName: newPlaylistName!,
                  );
                },
                songList: songList,
                index: index,
                audioPlayer: audioPlayer);
          },
        );
      },
    );
  }
}
