
import 'package:flutter/material.dart';
import 'package:mymusicapp/Functions/text.dart';
import 'package:mymusicapp/screens/favouritepage.dart';



import '../db/functins/db_functions.dart';
import '../db/songs.dart';
import '../screens/Screen_createdplaylist.dart';
import '../screens/mostplayed.dart';

class CoutomPlaylist extends StatelessWidget {
  const CoutomPlaylist ({super.key, required this.playlistName});
final String playlistName;

  @override
  Widget build(BuildContext context) {
        final List<AllSongs> songList =
        getlibrarybox().get(playlistName)!.toList().cast<AllSongs>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
          shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: 1, color: Color.fromARGB(255, 241, 81, 183)),
              borderRadius: BorderRadius.circular(20)),
              title: Text(playlistName,
              style: coustomFont(fontSize: 14),),

                onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              if (playlistName == 'Favourites') {
                return ScreenFavourites(
                  playlistName: "Favourites",
                );
              }
              if (playlistName == 'Recent') {
                return ScreenFavourites(
                  playlistName: "Recent",
                );
              }
              if (playlistName == 'Most Played') {
                return ScreenFavourites(
                  playlistName: "Most Played",
                );
              }
              return ScreenCreatedPlaylist(
                playlistName: playlistName,
              );
          
          
           
            }
          ));
                }

                
                
      ));       
                
                
                
      }    }