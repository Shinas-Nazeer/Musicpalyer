
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           iconTheme: IconThemeData(
                  color: Color.fromARGB(255, 241, 81, 183), size: 28.0),
          elevation: 0,
              backgroundColor: Colors.white,
        
        title: Text("Privacy Policy",
         style: TextStyle(
                      color: Color.fromARGB(255, 241, 81, 183),
                      fontFamily: ('Itim'),
                      fontSize: 25.0)
        
        
        
        ),
        ),

      body:ListView(
        children: [
          ListTile(
            title: Text("Introduction",
             style: TextStyle(
                      color: Color.fromARGB(255, 241, 81, 183),
                      fontFamily: ('Itim'),
                      fontSize: 20.0)),
            subtitle: Text("Music Player for Reddit values its visitors’ privacy. This privacy policy is effective 14/12/2030; it summarizes what information we might collect from a registered user or other visitor (“you”), and what we will and will not do with itPlease note that this privacy policy does not govern the collection and use of information by companies that Music Player for Reddit does not control, nor by individuals not employed or managed by Music Player for Reddit. If you visit a Web site that we mention or link to, be sure to review its privacy policy before providing the site with information.", 
            style: TextStyle( fontFamily: ('Itim'),),),
          ),
           ListTile(
            title: Text("Cookies",
             style: TextStyle(
                      color: Color.fromARGB(255, 241, 81, 183),
                      fontFamily: ('Itim'),
                      fontSize: 20.0)),
            subtitle: Text("Music Player for Reddit uses “cookies” to store personal data on your computer. We may also link information stored on your computer in cookies with personal data about specific individuals stored on our servers. If you set up your Web browser (for example, Internet Explorer or Firefox) so that cookies are not allowed, you might not be able to use some or all of the features of our Web site(s).", 
            style: TextStyle( fontFamily: ('Itim'),),),
          ),
           ListTile(
            title: Text("Your  Privacy Resposibilities",
             style: TextStyle(
                      color: Color.fromARGB(255, 241, 81, 183),
                      fontFamily: ('Itim'),
                      fontSize: 20.0)),
            subtitle: Text("To help protect your privacy, be sure:not to share your Reddit username or password with anyone else\nto log off the Music Player for Reddit Web site when you are finished;to take customary precautions to guard against “malware” (viruses, Trojan horses, bots, etc.), for example by installing and updating suitable anti-virus software.to use a browser plugin or extension that protects your privacy, see the Electronic Frontier Foundation's Surveillance Self-Defense Starter Pack", 
            style: TextStyle( fontFamily: ('Itim'),),),
          )
        ],
      )
      
      
    );
  }
}