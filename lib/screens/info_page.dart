import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/medicine_model.dart';
import 'package:http/http.dart' as http;

class InfoPage extends StatefulWidget {
  num medicineId;
  String title1;
  bool title2;

  InfoPage({
    Key? key,
    required this.medicineId,
    required this.title1,
    required this.title2,
  }) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  Future<Medicine?> getMedicine() async {
    String url = "https://pharmacy-app-management.herokuapp.com/"
        "api/drugs/${widget.medicineId}";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      return Medicine.fromJson(jsonData);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: FutureBuilder<Medicine?>(
        future: getMedicine(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            Medicine medicine = snapshot.data!;
            return Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.all(12),
              child: Column(
                children: [
                  Image.network(
                    medicine.imageUrl,
                    width: 120,
                  ),
                  SizedBox(height: 12),
                  Text(medicine.name)
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
