import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mymusicapp/text/terms.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           iconTheme: IconThemeData(
                  color: Color.fromARGB(255, 241, 81, 183), size: 28.0),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Terms and Conditions",
            style: TextStyle(
                color: Color.fromARGB(255, 241, 81, 183),
                fontFamily: ('Itim'),
                fontSize: 25.0)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Html(data: termsAndConditions),
        ),
      ),
    );
  }
}
