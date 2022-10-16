
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';



class MiniPlayer extends StatefulWidget {

  final List<SongModel> songModelList;
  int index;
 MiniPlayer({super.key, required this.songModelList, required this.index});



  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
 int  index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80.0,
      color: const Color.fromARGB(255, 241, 81, 183),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      
      children: [
    Text(
      
      widget.songModelList[index].displayNameWOExt,
   style: TextStyle(
    fontSize: 20.0,
    fontFamily: ('Itim'),
    color: Colors.white 
   ),),
   coustomIcon(coustomIcon: Icons.skip_previous, ontap:() {}),
    coustomIcon(coustomIcon: Icons.play_arrow, ontap:() {}),
     coustomIcon(coustomIcon: Icons.skip_next, ontap:() {})

    ]),


    );
  }


  Widget coustomIcon({required coustomIcon, required void ontap()}) {
    return IconButton(
        onPressed: ontap,
        icon: Icon(
          coustomIcon,
          size: 30.0,
          color: Colors.white
        ));
  }


}