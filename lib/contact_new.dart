import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactNew extends StatelessWidget {
  const ContactNew({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double avatarRadius = screenWidth * 0.1;

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
                // 연락처에 정보 저장하는 거 구현하기
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
                radius: avatarRadius*2.5,
                backgroundColor: Color(0xff98e0ff),
                child: Icon(
                  Icons.person,
                  size: avatarRadius*3.5,
                  color: Colors.white,
                ),
              ),
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
                        initialValue: "",
                        icon: Icons.person,
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        label: "Last name",
                        initialValue: "",
                        icon: Icons.person,
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        label: "Phone",
                        initialValue: "",
                        icon: Icons.phone,
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        label: "Email",
                        initialValue: "",
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
