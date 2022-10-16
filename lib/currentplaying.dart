import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:mymusicapp/Functions/text.dart';
import 'package:mymusicapp/provider/song_model_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class CurrrentScreen extends StatefulWidget {
 

  const  CurrrentScreen(
      {super.key, required this.songModelList, required this.audioPlayer,});
   final List <SongModel> songModelList;
  final AudioPlayer audioPlayer;

  @override
  State<CurrrentScreen> createState() => _CurrrentScreenState();
}

class _CurrrentScreenState extends State<CurrrentScreen> {
 Duration _duration = const Duration();
  Duration _position = const Duration();

  bool _isPlaying = false;
  List<AudioSource> songList = [];

  int currentIndex = 0;

  void popBack() {
    Navigator.pop(context);
  }

  void seekToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }

  @override
  void initState() {
    super.initState();
    parseSong();
  }

  void parseSong() {
    try {
      for (var element in widget.songModelList) {
        songList.add(
          AudioSource.uri(
            Uri.parse(element.uri!),
            tag: MediaItem(
              id: element.id.toString(),
              album: element.album ?? "No Album",
              title: element.displayNameWOExt,
              artUri: Uri.parse(element.id.toString()),
            ),
          ),
        );
      }

      widget.audioPlayer.setAudioSource(
        ConcatenatingAudioSource(children: songList),
      );
      widget.audioPlayer.play();
      _isPlaying = true;

      widget.audioPlayer.durationStream.listen((duration) {
        if (duration != null) {
          setState(() {
            _duration = duration;
          });
        }
      });
      widget.audioPlayer.positionStream.listen((position) {
        setState(() {
          _position = position;
        });
      });
      listenToEvent();
      listenToSongIndex();
    } on Exception catch (_) {
      popBack();
    }
  }

  void listenToEvent() {
    widget.audioPlayer.playerStateStream.listen((state) {
      if (state.playing) {
        setState(() {
          _isPlaying = true;
        });
      } else {
        setState(() {
          _isPlaying = false;
        });
      }
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  void listenToSongIndex() {
    widget.audioPlayer.currentIndexStream.listen(
      (event) {
        setState(
          () {
            if (event != null) {
              currentIndex = event;
            }
            context
                .read<SongModelProvider>()
                .setId(widget.songModelList[currentIndex].id);
          },
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
              color: Color.fromARGB(255, 241, 81, 183), size: 28.0),
          centerTitle: true,
          title: Text("Musicplayer", style: coustomFont(fontSize: 23.0)),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 70.0,
              ),
               const ArtWorkWidget(),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                widget.songModelList[currentIndex].displayNameWOExt,
                  style: coustomFont(fontSize: 24.0)),
              Text(
                overflow: TextOverflow.ellipsis,
                widget.songModelList[currentIndex].artist.toString(),
                style: coustomFont(fontSize: 14.0),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite,
                        size: 25.0,
                        color: Color.fromARGB(255, 241, 81, 183),
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.playlist_add,
                        size: 25.0,
                        color: Color.fromARGB(255, 241, 81, 183),
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _position.toString().split(".")[0],
                    style: coustomFont(fontSize: 14.0),
                  ),
                  Expanded(
                      child: Slider(
                    min: const Duration(microseconds: 0).inSeconds.toDouble(),
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                         seekToSeconds(value.toInt());
                        value = value;
                      });
                    },
                    activeColor: const Color.fromARGB(255, 241, 81, 183),
                    thumbColor: const Color.fromARGB(255, 241, 81, 183),
                    inactiveColor: Colors.grey,
                  )),
                  Text(
                    _duration.toString().split(".")[0],
                    style: coustomFont(fontSize: 14.0),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  coustomIcon(coustomIcon: Icons.shuffle, ontap: () {}),
                  coustomIcon(
                      coustomIcon: Icons.skip_previous_sharp, ontap: () {
                         if (widget.audioPlayer.hasPrevious) {
                              widget.audioPlayer.seekToPrevious();
                            }
                      }),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (_isPlaying) {
                            widget.audioPlayer.pause();
                          } else {
                            widget.audioPlayer.play();
                          }
                          _isPlaying = !_isPlaying;
                        });
                      },
                      icon: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 30.0,
                        color: const Color.fromARGB(255, 241, 81, 183),
                      )),
                  coustomIcon(
                      coustomIcon: Icons.skip_next,
                      ontap: () {
                        if (widget.audioPlayer.hasNext) {
                              widget.audioPlayer.seekToNext();
                            }
                        
                     
                      }),
                  coustomIcon(coustomIcon: Icons.loop_rounded, ontap: () {}),
                ],
              )
            ],
          ),
        ));
  }

  Widget coustomIcon({required coustomIcon, required void ontap()}) {
    return IconButton(
        onPressed: ontap,
        icon: Icon(
          coustomIcon,
          size: 30.0,
          color: const Color.fromARGB(255, 241, 81, 183),
        ));
  }

  
}

class ArtWorkWidget extends StatelessWidget {
  const ArtWorkWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
        id: context.watch<SongModelProvider>().id,
        type: ArtworkType.AUDIO,
        artworkHeight: 250,
        artworkWidth: 250,
        artworkFit: BoxFit.cover,
        nullArtworkWidget: Image.asset(
          "assets/image/cover.jpg",
          height: 250,
          width: 250,
        ));
  }
}
