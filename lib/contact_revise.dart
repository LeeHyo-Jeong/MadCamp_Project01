import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactRevise extends StatefulWidget {
  final Contact contact;

  const ContactRevise({super.key, required this.contact});

  @override
  _ContactReviseState createState() => _ContactReviseState();
}

class _ContactReviseState extends State<ContactRevise> {
  late Contact givencontact;
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

  @override
  void initState() {
    super.initState();
    givencontact = widget.contact;
    firstname = givencontact.givenName ?? "";
    lastname = givencontact.familyName ?? "";
    email = givencontact.emails?.isNotEmpty == true ? givencontact.emails!.first.value ?? "" : "";
    phone = givencontact.phones?.isNotEmpty == true ? givencontact.phones!.first.value ?? "" : "";

    // TextEditingController 초기값 설정
    firstnameController.text = firstname;
    lastnameController.text = lastname;
    emailController.text = email;
    phoneController.text = phone;
  }
  @override
  void dispose() {
    // dispose 메서드 내용...
    super.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  Future<void> reviseContact(Contact contact, String firstname, String lastname, String email, String phone) async {
    // 연락처 수정 내용 적용
    contact.givenName = firstname;
    contact.familyName = lastname;
    contact.emails = [Item(label: "email", value: email)];
    contact.phones = [Item(label: "mobile", value: phone)];

    // 연락처 수정
    await ContactsService.updateContact(contact);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    avatarRadius = screenWidth * 0.1;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff7f2f9),
          title: Text(
            "Revise Contract",
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                reviseContact(givencontact, firstname, lastname, email, phone); // 연락처가 수정된다.
                Navigator.pop(context, true);
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