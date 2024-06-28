import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:madcamp_project01/contact_revise.dart';

class ContactDetails extends StatelessWidget {
  final Contact contact;

  const ContactDetails({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double avatarRadius = screenWidth * 0.1;
    var phones = contact.phones ?? [];
    String phoneNumber = phones.isNotEmpty
        ? phones.first.value ?? "No Phone Number"
        : "No Phone Number";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Contact",
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              contact.avatar != null && contact.avatar!.isNotEmpty
                  ? CircleAvatar(
                      backgroundImage: MemoryImage(contact.avatar!),
                      radius: avatarRadius * 2, // 반지름 설정
                    )
                  : CircleAvatar(
                      backgroundColor: Color(0xff98e0ff), // 색깔 변경하기?
                      // 배경색 설정 (원형 아바타를 만들 때 중요)
                      radius: avatarRadius * 2,
                      // 반지름 설정
                      child: Icon(
                        Icons.person, // Icons 클래스의 person 아이콘 사용
                        color: Colors.white, // 아이콘 색상 설정
                        size: avatarRadius * 2.8, // 아이콘 크기 설정
                      )),
              Container(
                  child: Row(
                children: [
                  Spacer(flex: 3),
                  Container(
                      // 전화 앱 열기 구현?
                      width: 100,
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Color(0xfff7f2f9),
                          elevation: 2,
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(Icons.phone)))),
                  Spacer(flex: 1),
                  Container(
                      // 메세지 앱 열기 구현
                      width: 100,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Color(0xfff7f2f9),
                          elevation: 2,
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(Icons.message)))),
                  Spacer(flex: 1),
                  Container(
                    // 수정 기능 추가 가능: 연필 아이콘으로 바꾸고 수정 화면으로 변경되도록.
                    width: 100,
                    child: GestureDetector(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ContactRevise(contact: contact),
                              ));
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Color(0xfff7f2f9),
                            elevation: 2,
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.edit)))),
                  ),
                  Spacer(flex: 3)
                ],
              )),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                // color: Color(0xff98e0ff),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField(
                        label: "First name",
                        initialValue: contact.givenName ?? "",
                        icon: Icons.person,
                      ),
                      _buildTextField(
                        label: "Last name",
                        initialValue: contact.familyName ?? "",
                        icon: Icons.person,
                      ),
                      _buildTextField(
                        label: "Phone",
                        initialValue: phoneNumber,
                        icon: Icons.phone,
                      ),
                      _buildTextField(
                        label: "Email",
                        initialValue: contact.emails?.isNotEmpty == true
                            ? contact.emails!.first.value ?? ""
                            : "",
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
    required String initialValue,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        controller: TextEditingController(text: initialValue),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required List<String> items,
  }) {
    String dropdownValue = items.first;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: dropdownValue,
            isDense: true,
            onChanged: (String? newValue) {
              dropdownValue = newValue!;
            },
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
