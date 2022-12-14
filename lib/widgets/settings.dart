import 'package:flutter/material.dart';
import 'package:mymusicapp/Functions/text.dart';



import 'package:mymusicapp/widgets/privaypolicy.dart';
import 'package:mymusicapp/screens/Screen_terms.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {


  @override
  Widget build(BuildContext context) {
    
    return Drawer(child: getListview(context),
    );
  }
  Widget getListview(BuildContext context) 
  
  => ListView(
    
      children:  [
         SizedBox(
          height: 30.0,
        ),
        ListTile(
  
       
          leading: Icon(Icons.settings,color: Color.fromARGB(255, 241, 81, 183)),
          title: Text("Settings",
              style: TextStyle(
                  color: Color.fromARGB(255, 241, 81, 183),
                  fontFamily: ('Itim'),
                  fontSize: 22.0)),
       
        ),
        
        SizedBox(
          height: 20.0,
        ),
        ListTile(
              
           onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrivacyScreen()));
                }),
          
          title: Text("Privacy Policy",
              style: TextStyle(
                  color: Color.fromARGB(255, 241, 81, 183),
                  fontFamily: ('Itim'),
                    fontSize: 20.0)),
        
        ),
        ListTile(
          onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsScreen()));
                }),
         
          title: Text("Terms and conditions",
              style: TextStyle(
                  color: Color.fromARGB(255, 241, 81, 183),
                  fontFamily: ('Itim'),
                  fontSize: 20.0)),
        
        ),
        ListTile(
           onTap: () {
            showAboutMe(context: context);
               
                },
        
          title: Text("About",
              style: TextStyle(
                  color: Color.fromARGB(255, 241, 81, 183),
                  fontFamily: ('Itim'),
                  fontSize: 20.0)),
        
        ),


        
        ListTile(
         
          title: Text("Notifications",
              style: TextStyle(
                  color: Color.fromARGB(255, 241, 81, 183),
                  fontFamily: ('Itim'),
                  fontSize: 20.0)),
                  trailing: Switch(
                    activeColor: krose,
                    value: true, onChanged: (_){},
                 )
      
        ),
        ListTile(
          // onTap: (() {
          //   PopupMenuButton(itemBuilder: (context) =>[
          //     PopupMenuItem(child: Text("Dark"))
              
          //   ],);
          // }),
          
          title: Text("Themes",
              style: TextStyle(
                   color: Color.fromARGB(255, 241, 81, 183),
                  fontFamily: ('Itim'),
                  fontSize: 20.0)),
                  trailing: PopupMenuButton(
                    icon: const Icon(Icons.arrow_drop_down_circle_outlined,
                        color: Color.fromARGB(255, 241, 81, 183)),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              child: Row(
                            children: [
                           
                              Text("Dark",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 241, 81, 183),
                                      fontFamily: ('Itim'),
                                      fontSize: 18.0)),
                                        Switch(
                                          activeColor: krose,
                                          value: true, onChanged: (_){},)
                            ],
                          )),
                          
                        ]),

          
        ),

          // ListTile(
          //   minVerticalPadding: 350.0,
          
          // title: Text("Version",
          // textAlign: TextAlign.center,
          //     style: TextStyle(
          //         color: Colors.grey,
          //         fontFamily: ('Itim'),
          //         fontSize: 20.0)),
          //           subtitle: Text("2.4.6",
          //           textAlign: TextAlign.center,
          //     style: TextStyle(
          //         color: Colors.grey,
          //         fontFamily: ('Itim'),
          //         fontSize: 15.0)),
             
          //       ),
       
      ],
    );


}

showAboutMe({required BuildContext context, }){
  showDialog(context: context, builder: (ctx){
    return Dialog(
      child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children:  [
                  Text(
                    'About Me',
                    style:coustomFont(fontSize: 19)
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'This App is designed and developed by Shinas Nazeer',
                        textAlign: TextAlign.center,
                        style: coustomFont(fontSize: 15)
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
    );

  });
}