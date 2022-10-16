



import 'package:flutter/material.dart';

import 'currentplaying.dart';

class Screenfavourite extends StatefulWidget {
  const Screenfavourite({super.key});

  @override
  State<Screenfavourite> createState() => _ScreenfavouriteState();
}

class _ScreenfavouriteState extends State<Screenfavourite> {
  @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
      appBar: AppBar(
        iconTheme:
        const    IconThemeData(color: Color.fromARGB(255, 241, 81, 183), size: 28.0),
        centerTitle: true,
        title: Row(
           mainAxisAlignment: MainAxisAlignment.start,
           
          children: [
             IconButton(onPressed: (){}, icon: Icon( Icons.favorite,)),
            const Text(
              "My Favourites",
              style: TextStyle(
                  color: Color.fromARGB(255, 241, 81, 183),
                  fontFamily: ('Itim'),
                  fontSize: 23.0),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 241, 81, 183),
            foregroundColor: Colors.white,
            child: const Icon(Icons.playlist_add),
            onPressed: () {},
          ),      
     
      body: 
          ListView.builder(
             shrinkWrap: true,
            itemBuilder: ((context, index) => Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListTile(
                    //Navogate to current Playing Screen from songlist
                    onTap: (() {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> CurrrentScreen(songModel: item.data![index]))); 
                      
                    }),
                     //Navogate to current Playing Screen from songlist
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color.fromARGB(255, 241, 81, 183)),
                        borderRadius: BorderRadius.circular(20)),
                    leading: Icon(
                      Icons.music_note,
                      color: Color.fromARGB(255, 241, 81, 183),
                    ),
                    title: Text("Song ${index+1}",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 241, 81, 183),
                            fontFamily: ('Itim'),
                            fontSize: 20.0)),
                    subtitle: Text("<Unknown>", style: TextStyle(
            color: Color.fromARGB(255, 241, 81, 183),
            fontFamily: ('Itim'),
            fontSize: 14.0)),
                    trailing:
                  
                    PopupMenuButton(
                       icon: const Icon(Icons.more_vert, color: Color.fromARGB(255, 241, 81, 183)),
                      
                      itemBuilder: (context)=>
                      [
                         PopupMenuItem(child: Row(
                          children: [
                               Icon(Icons.music_off_outlined, color: Color.fromARGB(255, 241, 81, 183)),
                             Text("Remove",style: TextStyle(
                                color: Color.fromARGB(255, 241, 81, 183),
                                fontFamily: ('Itim'),
                                fontSize: 18.0)),
                          ],
                        )),
                  
            
            
                      ]
                      
                      
                      )
                 
                  ),
                )),
            itemCount: 15,
          ),
      
    );
  }
}