import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medicine_app/models/medicine_model.dart';
import 'package:medicine_app/screens/admin_page.dart';
import 'package:medicine_app/screens/info_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Medicine>> getMedicineList() async {
    String url = "https://pharmacy-app-management.herokuapp.com/api/drugs";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as List;
      List<Medicine> medicines = json.map((e) => Medicine.fromJson(e)).toList();
      return medicines;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page"),
      ),
      body: FutureBuilder<List<Medicine>>(
        future: getMedicineList(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Medicine>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return myGrid(snapshot.data!);
          }
          return Center(
            child: Text("nimadir ishkal"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AdminPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget myGrid(List<Medicine> medicineList) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: medicineList.length,
      itemBuilder: (context, index) {
        return Dismissible(
            behavior: HitTestBehavior.deferToChild,
            key: Key(index.toString()),
            direction: DismissDirection.startToEnd,
            background: Container(
              color: Colors.red,
              child: Center(
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                showDeleteDialog(medicineList[index].id);
              }
            },
            child: medicineItem(medicineList, index));
      },
    );
  }

  Widget medicineItem(medicineList, index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => InfoPage(medicineId: medicineList[index].id ?? 0),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                medicineList[index].imageUrl,
                width: 120,
              ),
            ),
            SizedBox(height: 12),
            Text(medicineList[index].name)
          ],
        ),
      ),
    );
  }

  void showDeleteDialog(num? id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete ??"),
            content: Text("Rostdan ham o'chirmoqchimisiz ?"),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Text("No")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    callDelete(id);
                  },
                  child: Text("Yes")),
            ],
          );
        });
  }

  void callDelete(num? id) async {
    String url =
        "https://pharmacy-app-management.herokuapp.com/api/drugs/${id}";

    var response = await http.delete(Uri.parse(url));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('SUCCESS'),
              content: Text(response.body.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Text("OK"),
                )
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('ERROR'),
              content: Text(response.body.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                )
              ],
            );
          });
    }
  }
}
