import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactDetails extends StatelessWidget {
  final Contact contact;
  const ContactDetails({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Contact"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }
          )
        )
      ),

    );
  }
}
