import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medicine_app/models/medicine_model.dart';
import 'package:http/http.dart' as http;

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  var formKey = GlobalKey<FormState>();

  String name = '';
  String desc = '';
  int price = 0;
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                onSaved: (val) {
                  name = val ?? "";
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                onSaved: (val) {
                  desc = val ?? "";
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                onSaved: (val) {
                  price = int.parse(val ?? '0');
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Price',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                onSaved: (val) {
                  quantity = int.parse(val ?? '0');
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Quantity',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                formKey.currentState!.save();

                var medicine = Medicine(
                  name: name,
                  description: desc,
                  price: price,
                  imageUrl:
                      'https://apteka.uz/upload/iblock/6d7/6d7e7d1f0b0f604a1b6a21a796c4c8b9.jpeg',
                  quantity: quantity,
                );

                postMedicine(medicine);
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  void postMedicine(Medicine medicine) async {
    String url = "https://pharmacy-app-management.herokuapp.com/api/drugs";

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };

    var response = await http.post(Uri.parse(url),
        body: jsonEncode(medicine.toJson()), headers: headers);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Info'),
              content: Text(response.body.toString()),
            );
          });
    }
  }
}
