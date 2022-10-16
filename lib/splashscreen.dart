import 'package:flutter/material.dart';


import 'Functions/text.dart';
import 'homepage.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    gotohome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/Icon musi cpalyer.png',
                width: 200,
                height: 200,
              ),
              Text("Music Player", style: coustomFont(fontSize: 14))
            ],
          ),
        ),
      ),
    );
  }


 Future<void> gotohome()async{
  await Future.delayed(const Duration(seconds: 3 )); 
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (ctx) =>  MainScreen()
     )
     );
  

}
  
}