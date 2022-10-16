
import 'package:flutter/material.dart';

import 'currentplaying.dart';


class RecentlyPlayed extends StatelessWidget {
  const RecentlyPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        
      
        iconTheme:
        const    IconThemeData(color: Color.fromARGB(255, 241, 81, 183), size: 28.0),
        //  centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
        
             IconButton(onPressed: (){}, icon: Icon( Icons.record_voice_over_outlined,)),
             Text(
              "Recently Played",
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
   
     
      body: 
          ListView.builder(
             shrinkWrap: true,
            itemBuilder: ((context, index) => Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListTile(
                    //Navogate to current Playing Screen from songlist
                    onTap: (() {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>const CurrrentScreen())); 
                      
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
                   
                 
                  ),
                )),
            itemCount: 15,
          ),
      
    );
  }
}