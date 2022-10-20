





import 'package:flutter/material.dart';

import '../Functions/functions.dart';
import '../Functions/text.dart';
import '../screens/Screen_createdplaylist.dart';
class CreatedPlaylist extends StatelessWidget {
  const CreatedPlaylist({
    Key? key,

    required this.playlistName,
    required this.playlistSongNum,
  }) : super(key: key);
  
  final String playlistName;
  final String playlistSongNum;

  @override
  Widget build(BuildContext context) {
    return Padding(padding:const EdgeInsets.all(8.0),
    child: ListTile(
       shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: 1, color: Color.fromARGB(255, 241, 81, 183)),
              borderRadius: BorderRadius.circular(20)),
               onLongPress: () {
        showPlaylistDeleteAlert(context: context, key: playlistName);
      },
              onTap: () {
                 Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => ScreenCreatedPlaylist(
              playlistName: playlistName,
            ),
          ),
        );
                
              },
      title: Text(playlistName,
      
      style: coustomFont(fontSize: 14)),
    ),



    
     );
    

  

  }
}







    // return GestureDetector(
    //   onTap: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (ctx) => ScreenCreatedPlaylist(
    //           playlistName: playlistName,
    //         ),
    //       ),
    //     );
    //   },
    //   onLongPress: () {
    //     // showPlaylistDeleteAlert(context: context, key: playlistName);
    //   },
    //   child: Stack(
    //     children: [
    //       ClipRRect(
    //         borderRadius: BorderRadius.circular(18),
    //         child: Image.asset(
    //           playlistImage,
    //           fit: BoxFit.cover,
    //           // height: 137,
    //           height: screenHeight * 0.21,
    //         ),
    //       ),
    //       Positioned(
    //         bottom: 12,
    //         left: 7,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               playlistName,
    //               maxLines: 1,
    //               overflow: TextOverflow.ellipsis,
    //               style: const TextStyle(
    //                 fontSize: 15,
    //                 fontWeight: FontWeight.w600,
    //               ),
    //             ),
    //             Text(
    //               playlistSongNum,
    //               style: const TextStyle(
    //                 color: kLightBlue,
    //                 fontSize: 13,
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );