import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<Contact>? _contacts = null; // ios 오류때문에 초기화 해야함
  final TextEditingController _phoneNumberController = TextEditingController(); // Controller 선언 및 초기화

  // 연락처 가져오기 기능
  Future<void> getContacts() async {
    if (await Permission.contacts.request().isGranted) {
      var contacts = await ContactsService.getContacts(
        withThumbnails: false,
      );

      // 가져온 연락처 목록 변수에 할당
      setState(() {
        _contacts = contacts;
      });

      // 연락처 목록 모달 열기
      showModal();

      // Iterate over the contacts and look for the phone number
    } else {
      // Permission denied, handle the error
    }
  }

  // 연락처 모달 오픈
  Future<void> showModal() async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: ListView.builder(
            itemCount: _contacts?.length,
            itemBuilder: (BuildContext context, int index) {
              Contact c = _contacts!.elementAt(index);
              var userName = c.displayName;
              var phoneNumber = c.phones?.first.value;
              return TextButton(
                onPressed: () {
                  _phoneNumberController.text = phoneNumber.toString();
                  Navigator.of(context).pop();
                },
                child: Text(userName ?? ""),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          if (_contacts == null) {
            getContacts(); // 최초로 가져오기
          } else {
            showModal(); // 한번 가져온 후 실행
          }
        },
        child: Text(
          '연락처에서 선택',
          style: TextStyle(
            fontSize: 13,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ),
    );
  }
}