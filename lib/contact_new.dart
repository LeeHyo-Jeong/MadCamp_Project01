import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';

class ContactNew extends StatefulWidget {
  const ContactNew({super.key});

  @override
  _ContactNewState createState() => _ContactNewState();
}

class _ContactNewState extends State<ContactNew> {
  double screenWidth = 0;
  double avatarRadius = 0;
  double screenHeight = 0;
  String firstname = "";
  String lastname = "";
  String email = "";
  String phone = "";
  Uint8List? _imageBytes;

  // TextEditingController 생성
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> addContact(
      String firstname, String lastname, String email, String phone) async {
    // 새 연락처 생성
    final newContact = Contact(
        givenName: firstname,
        familyName: lastname,
        emails: [Item(label: "email", value: email)],
        phones: [Item(label: "mobile", value: phone)],
        avatar: _imageBytes);

    // 연락처 추가
    await ContactsService.addContact(newContact);
  }

  // 이미지를 갤러리에서 가져와서 추가하기
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await File(pickedFile.path).readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    avatarRadius = screenWidth * 0.1;

    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Color(0xfff7f2f9),
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
              Navigator.pop(context, false);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                addContact(firstname, lastname, email, phone); // 연락처가 추가된다.
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: screenHeight * 0.07,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    _imageBytes != null
                        ? CircleAvatar(
                            backgroundImage: MemoryImage(_imageBytes!),
                            radius: avatarRadius * 2.5, // 반지름 설정
                          )
                        : CircleAvatar(
                            backgroundColor: Color(0xff98e0ff), // 색깔 변경하기?
                            // 배경색 설정 (원형 아바타를 만들 때 중요)
                            radius: avatarRadius * 2.5,
                            // 반지름 설정
                            child: Icon(
                              Icons.person, // Icons 클래스의 person 아이콘 사용
                              color: Colors.white, // 아이콘 색상 설정
                              size: avatarRadius * 3.5, // 아이콘 크기 설정
                            )),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.grey, width: 2.0),
                                ),
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 20,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                    ))))),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.07,
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
        ));
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
