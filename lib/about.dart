import 'package:flutter/material.dart';


class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           iconTheme: IconThemeData(
                  color: Color.fromARGB(255, 241, 81, 183), size: 28.0),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("About",
            style: TextStyle(
                color: Color.fromARGB(255, 241, 81, 183),
                fontFamily: ('Itim'),
                fontSize: 25.0)),

      ),
      body:  ListView(
        children: [
           ListTile(
           
            subtitle: Text("This app is free to use, and created by Shinas Nazeer- is a self taught flutter developer ",
            
            style: TextStyle( fontFamily: ('Itim'))
            
            
            
            )
          )
        ],
      ),
      
      
      
      
      
      
      
      );
  }
}