// ignore: file_names
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:mymusicapp/Functions/text.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Functions/favouritefunction.dart';
import '../Functions/functions.dart';
import '../db/songs.dart';
import '../widgets/coustomicn.dart';




class NowplayingScreen extends StatefulWidget {
  NowplayingScreen(
      {super.key,
      required this.index,
      required this.songList,
      required this.audioPlayer, required this.id});
  final List<Audio> songList;
  final int index;
  final String id;
  final AssetsAudioPlayer audioPlayer;

  @override
  State<NowplayingScreen> createState() => _NowplayingScreenState();
}

class _NowplayingScreenState extends State<NowplayingScreen> {
   
  
  bool isPlaying = true;
  bool isLoop = true;
  bool isShuffle = true;

  void playOrPauseButtonPressed() async {
    if (isPlaying == true) {
      await widget.audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else if (isPlaying == false) {
      await widget.audioPlayer.play();
      setState(() {
        isPlaying = true;
      });
    }
  }

  void shuffleButtonPressed() {
    setState(() {
      widget.audioPlayer.toggleShuffle();
      isShuffle = !isShuffle;
    });
  }

  void repeatButtonPressed() {
    if (isLoop == true) {
      widget.audioPlayer.setLoopMode(LoopMode.single);
    } else {
      widget.audioPlayer.setLoopMode(LoopMode.playlist);
    }
    setState(() {
      isLoop = !isLoop;
    });
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) {
      return element.path == fromPath;
    });
  }
  PageController? pageController;

  @override
  Widget build(BuildContext context) {

     final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
              color: krose, size: 28.0),
          centerTitle: true,
          title: const Text(
            "Musicplayer",
            style: TextStyle(
                color: Color.fromARGB(255, 241, 81, 183),
                fontFamily: ('Itim'),
                fontSize: 23.0),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: PageView.builder(
           onPageChanged: (newValue) {
            widget.audioPlayer.playlistPlayAtIndex(newValue);
            

          },
           controller: pageController,
          scrollDirection: Axis.vertical,
          itemCount: widget.songList.length, itemBuilder: (BuildContext context, int index) { return widget.audioPlayer.builderCurrent(builder: (context, playing) {
           final myAudio = find(widget.songList, playing.audio.assetAudioPath);
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 70.0,
                ),
               QueryArtworkWidget(id:int.parse(myAudio.metas.id!), type: ArtworkType.AUDIO,
               artworkHeight: 300,artworkWidth: 300,
               nullArtworkWidget: Image.asset('assets/image/launcher.png', width: 300,height: 300,),),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  widget.audioPlayer.getCurrentAudioTitle,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: coustomFont(fontSize: 24)
                  ),

                Text(
                    widget.audioPlayer.getCurrentAudioArtist == '<unknown>'
                            ? 'Unknown'
                            : widget.audioPlayer.getCurrentAudioArtist,
                  style: coustomFont(fontSize: 14),


                ),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                   CustomIconButton(
                    icon: Favourites.isThisFavourite(
                                  id: myAudio.metas.id!),
                                  onPressed: (() {
                                     Favourites.addSongToFavourites(
                                  context: context,
                                  id: myAudio.metas.id!,
                                );
                                setState(() {
                                   Favourites.isThisFavourite(
                                    id: myAudio.metas.id!,
                                  );
                                });
                                  }),
                   ),
                    IconButton(
                        onPressed: () {
                            final song = AllSongs(
                                id: myAudio.metas.id!,
                                songname: myAudio.metas.title!,
                                songartist: myAudio.metas.artist!,
                                path: myAudio.path,
                              );
                               showPlaylistModalSheet(
                                context: context,
                                screenHeight: screenHeight,
                                song: song,
                              );
                        },
                        icon: const Icon(
                          Icons.playlist_add,
                          size: 30.0,
                          color: krose
                        ))
                  ],
                ),
              
                widget.audioPlayer.builderRealtimePlayingInfos(
                  builder: (context, info){
                    final duration = info.current!.audio.duration;
                          final position = info.currentPosition;
              return ProgressBar(
                            progress: position,
                            total: duration,
                            progressBarColor: krose,
                            baseBarColor: Colors.grey,
                            thumbColor: krose,
                            bufferedBarColor: Colors.white.withOpacity(0.24),
                            barHeight: 7.0,
                            thumbRadius: 9.0,
                            onSeek: (duration) {
                              widget.audioPlayer.seek(duration);
                            },
                            timeLabelPadding: 10,
                            timeLabelTextStyle: const TextStyle(
                              color:krose,
                              fontSize: 15,
                            ),
                          );}),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                           shuffleButtonPressed();

                        },
                        icon:
                         Icon(
                          Icons.shuffle_rounded,
                          size: 20.0,
                          color:(isShuffle == true) ? Colors.grey :krose
                        ) 
                      
                        
                        
                        ),
                    IconButton(
                        onPressed: () {
                    
                        widget.audioPlayer.previous();
                  



                        },
                        icon: const Icon(
                          Icons.skip_previous_sharp,
                          size: 30.0,
                          color: krose
                        )),
                    PlayerBuilder.isPlaying(
                        player: widget.audioPlayer,
                        builder: ((context, isPlaying) {
                          return IconButton(
                              onPressed: () {
                                widget.audioPlayer.playOrPause();
                              },
                              icon: Icon(
                                (isPlaying == true)
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: 30.0,
                                color: krose
                              ));
                        })),
                    IconButton(
                        onPressed: () {
                         
                            widget.audioPlayer.next();
                          
                        },
                        icon: Icon(
                          Icons.skip_next,
                          size: 30.0,
                          color: krose
                        )),
                    IconButton(
                        onPressed: () {
                          
                                  repeatButtonPressed();
                        },
                        icon:  Icon(
                          Icons.loop_rounded,
                          size: 20.0,
                          color: (isLoop == true) ?  Colors.grey :krose
                        ))
                  ],
                )
              ],
            ),
          );
        }
        
        );
         },
        )
        
        );
  }
}
