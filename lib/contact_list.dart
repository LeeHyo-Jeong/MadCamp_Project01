import 'package:flutter/material.dart';
import 'package:madcamp_project01/contact_detail.dart';
import 'package:madcamp_project01/contact_new.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

class ContactsWidget extends StatefulWidget {
  const ContactsWidget({super.key});

  @override
  State<ContactsWidget> createState() => _ContactsWidgetState();
}

class _ContactsWidgetState extends State<ContactsWidget> {
  bool _isDisposed = false; // flag to track whether the widget is disposed

  List<Contact>? _contacts = null; // ios 오류때문에 초기화 해야함
  final ScrollController _scrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<Contact>? _filteredContacts = [];

  @override
  void initState() {
    super.initState();
    _filteredContacts = _contacts;
    getContacts();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _scrollController.dispose();
    super.dispose();
  }

  String getInitials(String text) {
    final StringBuffer buffer = StringBuffer();
    final List<String> CHOSUNG1 = [
      0x1100,
      0x1101,
      0x1102,
      0x1103,
      0x1104,
      0x1105,
      0x1106,
      0x1107,
      0x1108,
      0x1109,
      0x110A,
      0x110B,
      0x110C,
      0x110D,
      0x110E,
      0x110F,
      0x1110,
      0x1111,
      0x1112
    ].map((e) => String.fromCharCode(e)).toList();
    final List<String> CHOSUNG2 = {
      0x3131,
      0x3132,
      0x3134,
      0x3137,
      0x3138,
      0x3139,
      0x3141,
      0x3142,
      0x3143,
      0x3145,
      0x3146,
      0x3147,
      0x3148,
      0x3149,
      0x314a,
      0x314b,
      0x314c,
      0x314d,
      0x314e
    }.map((e) => String.fromCharCode(e)).toList();

    for (int i = 0; i < text.length; i++) {
      int unicode = text.codeUnitAt(i);

      // 한글인 경우에만 초성 추출
      if (0xAC00 <= unicode && unicode <= 0xD7A3) {
        // 한글 음절 코드
        final int syllableIndex = unicode - 0xAC00;

        // 초성 인덱스 계산
        final int initialIndex = syllableIndex ~/ 588;
        final int index =
            CHOSUNG1.indexOf(String.fromCharCode(initialIndex + 0x1100));
        buffer.write(CHOSUNG2[index]);
      } else {
        // 한글이 아닌 경우에는 원래 문자 추가
        buffer.write(text[i]);
      }
    }

    return buffer.toString();
  }

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
        if (_isDisposed) return;
        setState(() {
          _contacts = contacts.toList();
          _contacts?.sort((a, b) => a.displayName!.compareTo(b.displayName!));
        });
        _filteredContacts = _contacts;
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
      if (_isDisposed) return;
      setState(() {
        _contacts = contacts.toList();
        _contacts?.sort((a, b) => a.displayName!.compareTo(b.displayName!));
      });
      _filteredContacts = _contacts;
    }
  }

  void _filterItems(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredContacts = _contacts;
      });
    } else {
      setState(() {
        _filteredContacts = _contacts!.where((contact) {
          String fullName = contact.displayName!.toLowerCase();
          String initials = getInitials(contact.displayName!).toLowerCase();
          return fullName.contains(query) || initials.contains(query);
        }).toList();
      });
    }
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
      _filterItems('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Contacts"),
          centerTitle: true,
        ),
        body: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: AppBar(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  title: _isSearching
                      ? TextField(
                          controller: _searchController,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            border: InputBorder.none,
                          ),
                          onChanged: _filterItems,
                        )
                      : TextButton(
                          onPressed: _startSearch,
                          child: Text(
                            'Search',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          )),
                  actions: _isSearching
                      ? [
                          IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: _stopSearch,
                          )
                        ]
                      : [
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: _startSearch,
                          )
                        ],
                ),
              ),
            ),
          ),
          body: _contacts == null
              ? Center(
                  child: CircularProgressIndicator(color: Color(0xff98e0ff)))
              : DraggableScrollbar.arrows(
                  backgroundColor: Color(0xff98e0ff),
                  controller: _scrollController,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _filteredContacts?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      Contact contact = _filteredContacts![index];
                      return ListTile(
                        leading: contact.avatar != null &&
                                contact.avatar!.isNotEmpty
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(contact.avatar!),
                                radius: 20, // 반지름 설정
                              )
                            : CircleAvatar(
                                backgroundColor: Color(
                                    0xff98e0ff), // 배경색 설정 (원형 아바타를 만들 때 중요)
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
                        onTap: () async {
                          bool? shouldRefresh = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ContactDetails(contact: contact),
                              ));
                          if (shouldRefresh == true) {
                            setState(() {
                              getContacts();
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xff98e0ff),
            shape: CircleBorder(),
            onPressed: () async {
              bool? shouldRefresh = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactNew(),
                  ));
              if (shouldRefresh == true) {
                setState(() {
                  getContacts();
                });
              }
            },
            child: Icon(
              Icons.add,
              color: Color(0xfff7f2f9),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.endFloat, //
        ));
  }
}
