import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mymusicapp/db/songs.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Functions/favouritefunction.dart';
import '../Functions/functions.dart';
import '../Functions/recents.dart';
import '../Functions/text.dart';
import '../db/functins/db_functions.dart';

class Songlist extends StatefulWidget {
  const Songlist({super.key});

  @override
  State<Songlist> createState() => _SonglistState();
}

class _SonglistState extends State<Songlist> {
  Box<AllSongs> songBox = Hive.box<AllSongs>('Allsongs');
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return ValueListenableBuilder(
        valueListenable: songBox.listenable(),
        builder:
            (BuildContext context, Box<AllSongs> allSongs, Widget? child) {
          List<AllSongs> allSongsList = [];

          allSongsList = allSongs.values.toList();
          if (songBox.isEmpty) {
            return const Center(
              child: Text(
                'Songs Not Found',
                style: TextStyle(fontSize: 25, color: krose),
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return AllSongsList(
                onPressed: (() {
                   log(allSongsList.length.toString());
                  showPlaylistModalSheet(context: context, screenHeight: screenHeight, song: allSongsList[index]);
                }),
              audioPlayer: audioPlayer,
              index: index,
              songList: allSongsList,
            );},
            itemCount: allSongsList.length,
          );
        });
  }
}


class AllSongsList extends StatefulWidget {
  final int index;
  final AssetsAudioPlayer audioPlayer;
  final List<AllSongs> songList;
  final void Function()? onPressed;
  final IconData icon;

  const AllSongsList(
      {Key? key,
      this.icon = Icons.playlist_add,
      required this.index,
      required this.audioPlayer,
      required this.songList,
      this.onPressed
      
      }): super(key: key);

  @override
  State<AllSongsList> createState() => _AllSongsListState();
}

class _AllSongsListState extends State<AllSongsList> {
    Box<AllSongs> songBox = getSongBox();
  Box<List> playlistBox = getlibrarybox();


   @override
  void initState() {
    super.initState();
    setState(() {
      Favourites.isThisFavourite(id: widget.songList[widget.index].id);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ListTile(
        onTap: () {
     Recents.addSongsToRecents(songId: widget.songList[widget.index].id);
       showMiniPlayer(
          context: context,
          index: widget.index,
          songList: widget.songList,
          audioPlayer: widget.audioPlayer,
        );
        },
        shape: RoundedRectangleBorder(
            side: const BorderSide(
                width: 1, color: Color.fromARGB(255, 241, 81, 183)),
            borderRadius: BorderRadius.circular(20)),
        leading: QueryArtworkWidget(
            id: int.parse(widget.songList[widget.index].id),
            type: ArtworkType.AUDIO,
            nullArtworkWidget: const Icon(Icons.music_note,
                color: Color.fromARGB(255, 241, 81, 183))),
        title: Text(
            overflow: TextOverflow.ellipsis,
            widget.songList[widget.index].songname,
            style: coustomFont(fontSize: 20.0)),
        subtitle: Text(
          overflow: TextOverflow.ellipsis,
          widget.songList[widget.index].songartist == '<unknown>'
            ? 'Unknown'
            : widget.songList[widget.index].songartist,
          style: coustomFont(fontSize: 14.0),

        ),
        trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            padding: const EdgeInsets.only(left: 0),
            onPressed: widget.onPressed,
            icon: Icon(
              widget.icon,
              color: krose,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {
              Favourites.addSongToFavourites(
                context: context,
                id: widget.songList[widget.index].id,
              );
              setState(() {
                Favourites.isThisFavourite(
                  id: widget.songList[widget.index].id,
                );
              });
            },
            icon: Icon(
              Favourites.isThisFavourite(
                id: widget.songList[widget.index].id,
              ),
              color: krose,
              size: 25,
            ),
          )
        ],
      ),

      ),
    );
  }
}


