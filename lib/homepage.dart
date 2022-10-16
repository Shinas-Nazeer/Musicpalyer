import 'package:flutter/material.dart';
import 'package:mymusicapp/platlist.dart';
import 'package:mymusicapp/settings.dart';
import 'package:mymusicapp/songslist.dart';

import 'Functions/text.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Songs'),
    const Tab(text: 'Playlist'),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.pink,
          tabBarTheme: (const TabBarTheme(
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
              width: 2.0,
              color: Color.fromARGB(255, 241, 81, 183),
            )),
            labelColor: Color.fromARGB(255, 241, 81, 183),
            labelStyle: TextStyle(fontFamily: ('Itim'), fontSize: 23.0),
          ))),
      home: DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                  color: Color.fromARGB(255, 241, 81, 183), size: 28.0),
              centerTitle: true,
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
              elevation: 0,
              backgroundColor: Colors.white,
              bottom: TabBar(
                tabs: myTabs,
              ),
              title:  Text("Music Player",style: coustomFont(fontSize: 23.0) )
            ),
            drawer: const SettingScreen(),
            body: const TabBarView(children: [Songlist(), PlaylistScreen()])),
      ),
    );
  }
}
