



import 'package:hive_flutter/adapters.dart';

import '../db/functins/db_functions.dart';
import '../db/songs.dart';
import 'mostplayed.dart';

class Recents {
  static final Box<AllSongs> songBox = getSongBox();
  static final Box<List> playlistBox = getlibrarybox();

  static addSongsToRecents({required String songId}) async {
    final List<AllSongs> dbSongs = songBox.values.toList().cast<AllSongs>();
    final List<AllSongs> recentSongList =
        playlistBox.get('Recent')!.toList().cast<AllSongs>();

    final AllSongs recentSong =
        dbSongs.firstWhere((song) => song.id.contains(songId));
    /////////////////---------For Most Played----------///////////////////////////
    int count = recentSong.count;
    recentSong.count = count + 1;

    //////////////////////////////////////////////////////////////////////////////
    /////////////////---------Calling MostPlayed---------/////////////////////////
    MostPlayed.addSongToPlaylist(songId);
    //////////////////////////////////////////////////////////////////////////////
    if (recentSongList.length >= 10) {
      recentSongList.removeLast();
    }
    if (recentSongList.where((song) => song.id == recentSong.id).isEmpty) {
      recentSongList.insert(0, recentSong);
      await playlistBox.put('Recent', recentSongList);
    } else {
      recentSongList.removeWhere((song) => song.id == recentSong.id);
      recentSongList.insert(0, recentSong);
      await playlistBox.put('Recent', recentSongList);
    }
  }
}