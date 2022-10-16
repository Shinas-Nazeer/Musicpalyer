import 'package:flutter/material.dart';
import 'package:mymusicapp/playlisttop.dart';

import 'addplaylist.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 241, 81, 183),
            foregroundColor: Colors.white,
            child: const Icon(Icons.playlist_add),
            onPressed: () {},
          ),
          body: Column(
            children: [
               Favourite(),
              Expanded(child: PlayList()),
            ],
          ));
    
  }
}
