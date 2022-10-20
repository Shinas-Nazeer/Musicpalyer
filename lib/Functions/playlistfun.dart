  import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mymusicapp/Functions/text.dart';

import '../db/functins/db_functions.dart';
import '../db/songs.dart';



class UserPlaylist {
  static final Box<List> playlistBox = getlibrarybox();
  static final Box<AllSongs> songBox = getSongBox();

  static addSongToPlaylist({
    required BuildContext context,
    required String songId,
    required String playlistName,
  }) async {
    List<AllSongs> playlistSongs =
        playlistBox.get(playlistName)!.toList().cast<AllSongs>();

    List<AllSongs> allSongs = songBox.values.toList().cast<AllSongs>();
    AllSongs song = allSongs.firstWhere((element) => element.id.contains(songId));

    if (playlistSongs.contains(song)) {
      showPlaylistSnackbar(
          context: context,
          songName: song.songname,
          message: 'Already Exist in the playlist');
    } else {
      playlistSongs.add(song);
      await playlistBox.put(playlistName, playlistSongs);
      showPlaylistSnackbar(
          context: context,
          songName: song.songname,
          message: 'Added to the Playlist');
    }
  }

  static deleteFromPlaylist({
    required BuildContext context,
    required String playlistName,
    required String songId,
  }) async {
    List<AllSongs> playlistSongs =
        playlistBox.get(playlistName)!.toList().cast<AllSongs>();
    List<AllSongs> allSongs = songBox.values.toList().cast<AllSongs>();

    AllSongs song = allSongs.firstWhere((element) => element.id.contains(songId));

    playlistSongs.removeWhere((element) => element.id == songId);
    await playlistBox.put(playlistName, playlistSongs);
    showPlaylistSnackbar(
        context: context,
        songName: song.songname,
        message: 'Deleted from playlist');
  }

  static void showPlaylistSnackbar({
    required BuildContext context,
    required String songName,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.white,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: coustomFont(fontSize: 20)
            ),
            Text(
              songName,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
