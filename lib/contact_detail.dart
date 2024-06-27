import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactDetails extends StatelessWidget {
  final Contact contact;

  const ContactDetails({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    var phones = contact.phones ?? [];
    String phoneNumber = phones.isNotEmpty
        ? phones.first.value ?? "No Phone Number"
        : "No Phone Number";

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
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xff98e0ff),
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
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
                      ),
                      _buildTextField(
                        label: "Phone",
                        initialValue: phoneNumber,
                        icon: Icons.phone,
                      ),
                      _buildDropdownField(
                        label: "Mobile",
                        items: ["Mobile", "Home", "Work"],
                      ),
                      _buildTextField(
                        label: "Email",
                        initialValue: contact.emails?.isNotEmpty == true
                            ? contact.emails!.first.value ?? ""
                            : "",
                        icon: Icons.email,
                      ),
                      _buildDropdownField(
                        label: "Home",
                        items: ["Home", "Work", "Other"],
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
