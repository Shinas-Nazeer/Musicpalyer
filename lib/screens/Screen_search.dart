


import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mymusicapp/Functions/text.dart';
import 'package:mymusicapp/widgets/songslist.dart';

import '../Functions/functions.dart';
import '../db/functins/db_functions.dart';
import '../db/songs.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key, required this.audioPlayer});
 final AssetsAudioPlayer audioPlayer;
  @override
  State<ScreenSearch> createState() => _ScreenSearch();
}

class _ScreenSearch extends State<ScreenSearch> {
    final TextEditingController _searchController = TextEditingController();
  Box<AllSongs> songBox = getSongBox();
  List<AllSongs>? dbSongs;
  List<AllSongs>? searchedSongs;
  @override
  void initState() {
    super.initState();
    dbSongs = songBox.values.toList().cast<AllSongs>();
    searchedSongs = List<AllSongs>.from(dbSongs!).toList().cast<AllSongs>();
  }
    searchSongfomDb(String searchSong) {
    setState(() {
      searchedSongs = dbSongs!
          .where((song) =>
              song.songname.toLowerCase().contains(searchSong.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
     final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:  AppBar(
        title:  Text(
          'Search',
          style:coustomFont(fontSize: 20)
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20,
        ),
        child: Column(
          children: [
            SearchField(
              validator: (value) {
                return null;
              },
              textController: _searchController,
              hintText: 'Songs or Playlist',
              icon: Icons.search,
              onChanged: (value) {
                searchSongfomDb(value);
              },
            ),
             Expanded(
              child: (searchedSongs!.isEmpty)
                  ? Center(
                      child: Text('No Songs Found',
                      style: coustomFont(fontSize: 15),),
                    )
                  : ListView.builder(
                      itemCount: searchedSongs!.length,
                      itemBuilder: (ctx, index) {
                        return AllSongsList(
                          onPressed: () {
                            showPlaylistModalSheet(
                                context: context,
                                screenHeight: screenHeight,
                                song: dbSongs![index]);
                          },
                          songList: searchedSongs!,
                          index: index,
                          audioPlayer: widget.audioPlayer,
                        );
                      },
                    ),
            ),
          ]
    ))
    
    );
  }
}




class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.textController,
    required this.validator,
    this.onChanged,
  });
  final String hintText;
  final IconData icon;
  final TextEditingController textController;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        style: const TextStyle(color: krose,fontFamily: ('Itim'),),
        textCapitalization: TextCapitalization.sentences,
        onChanged: onChanged,
        validator: validator,
        controller: textController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: krose,
            size: 25,
          ),
          hintText: hintText,
          hintStyle:  const TextStyle(color:krose),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 0, color: krose),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 0, color: krose),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 1,
              color: krose
            ),
          ),
        ),
      ),
    );
  }
}