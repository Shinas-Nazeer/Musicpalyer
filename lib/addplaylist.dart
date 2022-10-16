import 'package:flutter/material.dart';


class PlayList extends StatefulWidget {
  const PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

void delete(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
                    width: 1, color: Color.fromARGB(255, 241, 81, 183)),
         
  borderRadius: BorderRadius.circular(20)


        ),
            title: const Text("Are you Sure Want to delete ?",
           style: TextStyle(
                      color: Color.fromARGB(255, 88, 84, 84),
                    fontFamily: ('Itim'),
                    fontSize: 18.0),
                    


            ),
            actions: [
              TextButton(onPressed: () {
                
              }, child: Text("Yes",
                style: TextStyle(
                  color: Color.fromARGB(255, 88, 84, 84),
                    // color: Color.fromARGB(255, 241, 81, 183),
                    fontFamily: ('Itim'),
                    fontSize: 18.0)
              
              
              )),
              TextButton(onPressed: () {
                
              }, child: Text("No",
                style: TextStyle(
                  color: Color.fromARGB(255, 88, 84, 84),
                    // color: Color.fromARGB(255, 241, 81, 183),
                    fontFamily: ('Itim'),
                    fontSize: 18.0)))
            ],
          ));
}

class _PlayListState extends State<PlayList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
     
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(6.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
                side: const BorderSide(
                    width: 1, color: Color.fromARGB(255, 241, 81, 183)),
                borderRadius: BorderRadius.circular(20)),
            leading: Icon(
              Icons.music_note_rounded,
              color: Color.fromARGB(255, 241, 81, 183),
            ),
            title: Text("Playlist Name....",
                style: TextStyle(
                    color: Color.fromARGB(255, 241, 81, 183),
                    fontFamily: ('Itim'),
                    fontSize: 18.0)),
            trailing: PopupMenuButton(
                icon: const Icon(Icons.more_vert,
                    color: Color.fromARGB(255, 241, 81, 183)),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () {
                          delete(context);
                        },
                          child: Row(
                        children: [
                          Icon(Icons.delete,
                              color: Color.fromARGB(255, 241, 81, 183)),
                          Text("Delete",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 241, 81, 183),
                                  fontFamily: ('Itim'),
                                  fontSize: 18.0)),
                        ],
                      )),
                      PopupMenuItem(
                          child: Row(
                        children: [
                          Icon(Icons.edit,
                              color: Color.fromARGB(255, 241, 81, 183)),
                          Text("Edit   Name",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 241, 81, 183),
                                  fontFamily: ('Itim'),
                                  fontSize: 18.0)),
                        ],
                      )),
                    ]),
          ),
        ),
        itemCount: 10,
      ),
    );
  }
}
