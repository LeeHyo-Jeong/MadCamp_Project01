import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:madcamp_project01/contact_revise.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ContactDetails extends StatelessWidget {
  final Contact contact;

  const ContactDetails({super.key, required this.contact});

  void _launchPhoneApp() async {
    String? phoneNumber = "tel:" + (contact.phones?.first.value ?? "");
    if (await canLaunchUrlString(phoneNumber)) {
      await launchUrlString(phoneNumber);
    } else {
      throw 'Could not launch ${phoneNumber}';
    }
  }

  void _launchMessageApp() async {
    String? phoneNumber = "sms:" + (contact.phones?.first.value ?? "");
    if (await canLaunchUrlString(phoneNumber)) {
      await launchUrlString(phoneNumber);
    } else {
      throw 'Could not launch ${phoneNumber}';
    }
  }

  void _deleteContact(BuildContext context) async {
    await ContactsService.deleteContact(contact);
    Navigator.pop(context, true);
  }

  void _deleteConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.8),
          title: Text("Delete Contact"),
          content: Text("Are you sure you want to delete this contact?"),
          actions: [
            TextButton(
              child: Text("Cancel",
                  style: TextStyle(
                    color: Colors.black54,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete",
                  style: TextStyle(
                    color: Colors.red,
                  )),
              onPressed: () {
                _deleteContact(context);
                Navigator.pop(context, true);
                Fluttertoast.showToast(
                    msg: "Contact deleted !",
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black87,
                    fontSize: 17,
                    textColor: Colors.white,
                    toastLength: Toast.LENGTH_SHORT);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double avatarRadius = screenWidth * 0.1;
    var phones = contact.phones ?? [];
    String phoneNumber = phones.isNotEmpty
        ? phones.first.value ?? "No Phone Number"
        : "No Phone Number";

    return Scaffold(
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
          actions: [
            // 번호 삭제 버튼
            IconButton(
              icon: Icon(Icons.delete_outline_rounded, color: Colors.red),
              onPressed: () async {
                _deleteConfirmDialog(context);
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(flex: 3),
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
              Spacer(flex: 3),
              Container(
                  child: Row(
                children: [
                  Spacer(flex: 3),
                  Container(
                    // 전화 앱 열기 구현
                    width: 100,
                    child: GestureDetector(
                        onTap: () {
                          _launchPhoneApp();
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // color: Color(0xfff7f2f9),
                            elevation: 2,
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.phone)))),
                  ),
                  Spacer(flex: 1),
                  Container(
                    // 메세지 앱 열기 구현
                    width: 100,
                    child: GestureDetector(
                        onTap: () {
                          _launchMessageApp();
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            // color: Color(0xfff7f2f9),
                            elevation: 2,
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.message)))),
                  ),
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
                            // color: Color(0xfff7f2f9),
                            elevation: 2,
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.edit)))),
                  ),
                  Spacer(flex: 3)
                ],
              )),
              Spacer(flex: 1),
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
              ),
              Spacer(flex: 2),
            ],
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
        enabled: false,
        readOnly: true, // readOnly 속성을 true로 설정
        style: TextStyle(
          color: Colors.black, // 텍스트 색상을 진하게 설정
          fontWeight: FontWeight.bold, // 글자 두께를 굵게 설정 (선택사항)
        ),
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
}
