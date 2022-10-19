

import 'package:hive_flutter/adapters.dart';

import '../db/functins/db_functions.dart';
import '../db/songs.dart';

class MostPlayed {
  static final Box<AllSongs> songBox = getSongBox();
  static final Box<List> playlistBox = getlibrarybox();

  static addSongToPlaylist(String songId) async {
    final mostPlayedlist =
        playlistBox.get('Most Played')!.toList().cast<AllSongs>();

    final dbSongs = songBox.values.toList().cast<AllSongs>();

    final mostPlayedSong =
        dbSongs.firstWhere((song) => song.id.contains(songId));
    if (mostPlayedlist.length >= 10) {
      mostPlayedlist.removeLast();
    }
    if (mostPlayedSong.count >= 3) {
      if (mostPlayedlist
          .where((song) => song.id == mostPlayedSong.id)
          .isEmpty) {
        mostPlayedlist.insert(0, mostPlayedSong);
        await playlistBox.put('Most Played', mostPlayedlist);
      } else {
        mostPlayedlist.removeWhere((song) => song.id == mostPlayedSong.id);
        mostPlayedlist.insert(0, mostPlayedSong);
        await playlistBox.put('Most Played', mostPlayedlist);
      }
    }
  }
}
