import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mymusicapp/favouritepage.dart';
import 'package:mymusicapp/recently.dart';

import 'currentplaying.dart';
import 'mostplayed.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        
        shrinkWrap: true,
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Screenfavourite()));
            },
            shape: RoundedRectangleBorder(
                side: const BorderSide(
                    width: 1, color: Color.fromARGB(255, 241, 81, 183)),
                borderRadius: BorderRadius.circular(20)),
            leading: Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 241, 81, 183),
            ),
            title: Text("My favourite",
                style: TextStyle(
                    color: Color.fromARGB(255, 241, 81, 183),
                    fontFamily: ('Itim'),
                    fontSize: 18.0)),
          ),
          SizedBox(
            height: 7.0,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ScreenMostplayed()));
            },
            shape: RoundedRectangleBorder(
                side: const BorderSide(
                    width: 1, color: Color.fromARGB(255, 241, 81, 183)),
                borderRadius: BorderRadius.circular(20)),
            leading: Icon(
              Icons.slow_motion_video_sharp,
              color: Color.fromARGB(255, 241, 81, 183),
            ),
            title: Text("Most Played",
                style: TextStyle(
                    color: Color.fromARGB(255, 241, 81, 183),
                    fontFamily: ('Itim'),
                    fontSize: 18.0)),
          ),
          SizedBox(
            height: 7.0,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RecentlyPlayed()));
            },
            shape: RoundedRectangleBorder(
                side: const BorderSide(
                    width: 1, color: Color.fromARGB(255, 241, 81, 183)),
                borderRadius: BorderRadius.circular(20)),
            leading: Icon(
              Icons.record_voice_over_outlined,
              color: Color.fromARGB(255, 241, 81, 183),
            ),
            title: Text("Recently Played",
                style: TextStyle(
                    color: Color.fromARGB(255, 241, 81, 183),
                    fontFamily: ('Itim'),
                    fontSize: 18.0)),
          ),
          SizedBox(
            height: 7.0,
          ),
        ],
      ),
    );
  }
}
