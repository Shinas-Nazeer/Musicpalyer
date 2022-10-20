  import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mymusicapp/Functions/playlistfun.dart';
import 'package:mymusicapp/Functions/text.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../db/functins/db_functions.dart';
import '../db/songs.dart';
import '../screens/miniplayer.dart';
import '../screens/Screen_search.dart';




showMiniPlayer({
  required BuildContext context,
  required int index,
  required List<AllSongs> songList,
  required AssetsAudioPlayer audioPlayer,
}) {
  return showBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (ctx) {
        return MiniPlayer(
          songList: songList,
          index: index,
          audioPlayer: audioPlayer,
        );
      });
}

showPlaylistModalSheet({
  required BuildContext context,
  required double screenHeight,
  required AllSongs song,
}) {
  Box<List> playlistBox = getlibrarybox();
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          height: screenHeight * 0.55,
          child: Column(
            children: [
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  showCreatingPlaylistDialoge(context: ctx);
                },
                icon: const Icon(
                  Icons.playlist_add,
                  color: krose,
                ),
                label: Text(
                  'Create Playlist',
                  style: coustomFont(fontSize: 14)
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor:Colors.white,
                  shape: const StadiumBorder(),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: playlistBox.listenable(),
                    builder: (context, boxSongList, _) {
                    final List<dynamic> keys = playlistBox.keys.toList();

                    keys.removeWhere((key) => key == 'Favourites');
                    keys.removeWhere((key) => key == 'Recent');
                    keys.removeWhere((key) => key == 'Most Played');
                    keys.removeWhere((key) => key == 'Likedsong');
                    keys.removeWhere((key) => key == 'Mostplayed');


                    return Expanded(
                      child: (keys.isEmpty)
                          ? Center(
                              child: Text("No Playlist Found", style: coustomFont(fontSize: 18),),
                            )
                          : ListView.builder(
                              itemCount: keys.length,
                              itemBuilder: (ctx, index) {
                                final String playlistKey = keys[index];

                                return Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ListTile(
                                    onTap: () async {
                                      UserPlaylist.addSongToPlaylist(
                                          context: context,
                                          songId: song.id,
                                          playlistName: playlistKey);

                                      Navigator.pop(context);
                                    },
                                    
                                    title: Text(playlistKey, style: coustomFont(fontSize: 15.0),),
                                  ),
                                );
                              },
                            ),
                    );
                  })
            ],
          ),
        );
      });
}

showCreatingPlaylistDialoge({required BuildContext context}) {
  TextEditingController textEditingController = TextEditingController();
  Box<List> playlistBox = getlibrarybox();

  Future<void> createNewplaylist() async {
    List<AllSongs> songList = [];
    final String playlistName = textEditingController.text.trim();
    if (playlistName.isEmpty) {
      return;
    }
    await playlistBox.put(playlistName, songList);
  }

  return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        final formKey = GlobalKey<FormState>();
        return Form(
          key: formKey,
          child: AlertDialog(
            backgroundColor:Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Create playlist',
              style: coustomFont(fontSize: 16)
            ),
            content: SearchField(
              textController: textEditingController,
              hintText: 'Playlist Name',
              icon: Icons.playlist_add,
              validator: (value) {
                final keys = getlibrarybox().keys.toList();
                if (value == null || value.isEmpty) {
                  return 'Field is empty';
                }
                if (keys.contains(value)) {
                  return '$value Already exist in playlist';
                }
                return null;
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child:  Text(
                  'Cancel',
                  style: coustomFont(fontSize: 15)
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await createNewplaylist();
                    Navigator.pop(ctx);
                  }
                },
                child: Text(
                  'Confirm',
                  style: coustomFont(fontSize: 15)
                ),
              ),
            ],
          ),
        );
      });
}

showPlaylistDeleteAlert({required BuildContext context, required String key}) {
  final playlistBox = getlibrarybox();
  return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Confirm Deletion',
            style: coustomFont(fontSize: 14)
          ),
          content:  Text(
            'Do you want to delete this Playlist ?',
            style: coustomFont(fontSize: 18)
            
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text(
                'Cancel',
                style: coustomFont(fontSize: 15)
              ),
            ),
            TextButton(
              onPressed: () async {
                await playlistBox.delete(key);
                Navigator.pop(ctx);
              },
              child:  Text(
                'OK',
                style: coustomFont(fontSize: 15.0)
              ),
            ),
          ],
        );
      });
}

showSongModalSheet({
  required BuildContext context,
  required double screenHeight,
  required String playlistKey,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    builder: (ctx) {
      final songBox = getSongBox();
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        height: screenHeight * 0.55,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
             Text(
              'Add Songs',
              style:coustomFont(fontSize: 16)
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: songBox.listenable(),
                builder:
                    (BuildContext context, Box<AllSongs> boxSongs, Widget? child) {
                  return ListView.builder(
                    itemCount: boxSongs.values.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      final List<AllSongs> songsList = boxSongs.values.toList();
                      final AllSongs song = songsList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: ListTile(
                          onTap: () {
                            UserPlaylist.addSongToPlaylist(
                              context: context,
                              songId: song.id,
                              playlistName: playlistKey,
                            );

                            Navigator.pop(context);
                          },
                          leading: QueryArtworkWidget(
                            id: int.parse(song.id),
                            type: ArtworkType.AUDIO,
                            artworkBorder: BorderRadius.circular(10),
                            nullArtworkWidget: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/image/icon.png',
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                          title: Text(
                            song.songname,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:coustomFont(fontSize: 15)
                            
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
