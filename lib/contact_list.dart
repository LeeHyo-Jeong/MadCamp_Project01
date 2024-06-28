import 'package:flutter/material.dart';
import 'package:madcamp_project01/contact_detail.dart';
import 'package:madcamp_project01/contact_new.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactsWidget extends StatefulWidget {
  const ContactsWidget({super.key});

  @override
  State<ContactsWidget> createState() => _ContactsWidgetState();
}

class _ContactsWidgetState extends State<ContactsWidget> {
  List<Contact>? _contacts = null; // ios 오류때문에 초기화 해야함

  // 연락처 가져오기 기능
  Future<void> getContacts() async {
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      // 권한 요청
      if (await Permission.contacts.request().isGranted) {
        // 권한 허용, 연락처 가져오기
        var contacts = await ContactsService.getContacts(
          withThumbnails: true,
        );
        setState(() {
          _contacts = contacts.toList();
          _contacts?.sort((a, b) => a.displayName!.compareTo(b.displayName!));
        });
      } else {
        // 권한 거부
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Permission denied")));
      }
    } else {
      // 이미 권한이 허용된 경우
      var contacts = await ContactsService.getContacts(
        withThumbnails: true,
      );
      setState(() {
        _contacts = contacts.toList();
        _contacts?.sort((a, b) => a.displayName!.compareTo(b.displayName!));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _contacts == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _contacts?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                Contact contact = _contacts![index];
                return ListTile(
                  leading: contact.avatar != null && contact.avatar!.isNotEmpty
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(contact.avatar!),
                          radius: 20, // 반지름 설정
                        )
                      : CircleAvatar(
                          backgroundColor: Color(0xff98e0ff), // 배경색 설정 (원형 아바타를 만들 때 중요)
                          radius: 20, // 반지름 설정
                          child: Icon(
                            Icons.person, // Icons 클래스의 person 아이콘 사용
                            color: Colors.white, // 아이콘 색상 설정
                            size: 28, // 아이콘 크기 설정
                          )),
                  title: Text(contact.displayName ?? "No Name"),
                  subtitle: Text(
                    contact.phones?.isNotEmpty == true
                        ? contact.phones!.first.value ?? "No Phone Number"
                        : "No Phone Number",
                  ),
                  onTap: () {
                    // 전화번호를 누르면 상세 페이지로 이동
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ContactDetails(contact: contact),
                        ));
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ContactNew(),
              ));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, //
    );
  }
}
