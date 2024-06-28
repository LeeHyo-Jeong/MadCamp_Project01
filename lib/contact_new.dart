import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactNew extends StatefulWidget {
  const ContactNew({super.key});

  @override
  _ContactNewState createState() => _ContactNewState();
}

class _ContactNewState extends State<ContactNew> {
  double screenWidth = 0;
  double avatarRadius = 0;
  String firstname = "";
  String lastname = "";
  String email = "";
  String phone = "";

  // TextEditingController 생성
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> addContact(String firstname, String lastname, String email, String phone) async {
    // 새 연락처 생성
    final newContact = Contact(
      givenName: firstname,
      familyName: lastname,
      emails: [Item(value: email)],
      phones: [Item(value: phone)],
    );

    // 연락처 추가
    await ContactsService.addContact(newContact);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    avatarRadius = screenWidth * 0.1;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "New Contact",
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                addContact(firstname, lastname, email, phone); // 연락처가 추가된다.
              },
              child: Text(
                "save",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: avatarRadius * 2.5,
                backgroundColor: Color(0xff98e0ff),
                child: Icon(
                  Icons.person,
                  size: avatarRadius * 3.5,
                  color: Colors.white,
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField(
                        label: "First name",
                        controller: firstnameController,
                        onChanged: (value) {
                          setState(() {
                            firstname = value;
                          });
                        },
                        icon: Icons.person,
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        label: "Last name",
                        controller: lastnameController,
                        onChanged: (value) {
                          setState(() {
                            lastname = value;
                          });
                        },
                        icon: Icons.person,
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        label: "Phone",
                        controller: phoneController,
                        onChanged: (value) {
                          setState(() {
                            phone = value;
                          });
                        },
                        icon: Icons.phone,
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        label: "Email",
                        controller: emailController,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        icon: Icons.email,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}