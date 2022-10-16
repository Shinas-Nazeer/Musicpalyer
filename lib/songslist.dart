import 'package:flutter/material.dart';
import 'package:mymusicapp/provider/song_model_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'Functions/text.dart';
import 'currentplaying.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Songlist extends StatefulWidget {
  const Songlist({super.key});

  @override
  State<Songlist> createState() => _SonglistState();
}

class _SonglistState extends State<Songlist> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<SongModel> allsongs = [];

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() {
    Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      
      children: [
        FutureBuilder<List<SongModel>>(

            future: _audioQuery.querySongs(
                sortType: SongSortType.DATE_ADDED,
                orderType: OrderType.DESC_OR_GREATER,
                uriType: UriType.EXTERNAL,
                ignoreCase: true),
            builder: (context, item) {
              if (item.data == null) {
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Loading")
                    ],
                  ),
                );
              }
              if (item.data!.isEmpty) {
                return const Center(child: Text("Nothing found!"));
              }
              return ListView.builder(
                itemCount: item.data!.length,
                itemBuilder: ((context, index) {
                  allsongs.addAll(
                    item.data!
                  );
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ListTile(
                      onTap: (() {
                      
                      context.read<SongModelProvider>().setId(allsongs[index].id);

                  


                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CurrrentScreen(
                                      songModelList: 
                                       allsongs,
                                      audioPlayer: _audioPlayer, 
                                    
                                    )));
                      }),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color.fromARGB(255, 241, 81, 183)),
                          borderRadius: BorderRadius.circular(20)),
                      leading: QueryArtworkWidget(
                        id: allsongs[index].id,
                        // id: item.data![index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: const Icon(Icons.music_note,
                            color: Color.fromARGB(255, 241, 81, 183)),
                      ),
                      title: Text(
                          overflow: TextOverflow.ellipsis,
                          allsongs[index].displayNameWOExt,
                          // item.data![index].displayNameWOExt,
                          style: coustomFont(fontSize: 20.0)),
                      subtitle: Text(
                          overflow: TextOverflow.ellipsis,
                          allsongs[index].artist.toString(),
                          // item.data![index].artist.toString(),
                          style: coustomFont(fontSize: 14.0)),
                      trailing: popup(),
                    ),
                  );
                }),
              );
            }),
        
           
      ],
    );
  }

  PopupMenuButton<dynamic> popup() {
    return PopupMenuButton(
        icon: const Icon(Icons.more_vert,
            color: Color.fromARGB(255, 241, 81, 183)),
        itemBuilder: (context) => [
              PopupMenuItem(
                  child: Row(
                children: [
                  const Icon(Icons.favorite,
                      color: Color.fromARGB(255, 241, 81, 183)),
                  Text("Add to Favourite", style: coustomFont(fontSize: 18.0)),
                ],
              )),
              PopupMenuItem(
                  child: Row(
                children: [
                  const Icon(Icons.playlist_add,
                      color: Color.fromARGB(255, 241, 81, 183)),
                  Text("Add to Playlist", style: coustomFont(fontSize: 18.0)),
                ],
              )),
            ]);
  }
}
