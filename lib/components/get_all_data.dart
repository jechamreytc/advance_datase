import 'package:advance_datase/session_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetAllData extends StatefulWidget {
  const GetAllData({Key? key}) : super(key: key);

  @override
  _GetAllDataState createState() => _GetAllDataState();
}

class _GetAllDataState extends State<GetAllData> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  List<dynamic> allData = [];
  String _userID = "";

  void getAllData() async {
    try {
      var url = Uri.parse("${SessionStorage.url}login.php");
      Map<String, String> requestBody = {
        "operation": "getDataAll",
      };

      var response = await http.post(url, body: requestBody);

      if (response.statusCode == 200) {
        setState(() {
          allData = json.decode(response.body);
        });
        print("Response ni" + response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  void updateData() async {
    try {
      var url = Uri.parse("${SessionStorage.url}login.php");
      Map<String, dynamic> jsonData = {
        "userID": _userID,
        "username": _usernameController.text,
        "fname": _firstnameController.text,
        "lname": _lastnameController.text
      };
      Map<String, String> requestBody = {
        "operation": "updateData",
        "json": jsonEncode(jsonData)
      };
      var response = await http.post(url, body: requestBody);
      var res = json.decode(response.body);
      if (res != 0) {
        print("Data updated successfully");
        print("Response ni" + _userID.toString());
        getAllData();
      } else {
        print("Failed to update data");
      }
    } catch (e) {
      print(e);
    }
  }

  void deleteData() async {
    try {
      var url = Uri.parse("${SessionStorage.url}login.php");
      Map<String, dynamic> jsonData = {
        "userID": _userID,
      };
      Map<String, String> requestBody = {
        "operation": "deleteData",
        "json": jsonEncode(jsonData)
      };
      var response = await http.post(url, body: requestBody);
      var res = json.decode(response.body);
      if (res != 0) {
        print("Data deleted successfully");
        print("Response ni" + _userID.toString());
        getAllData();
      } else {
        print("Failed to delete data");
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Get All Data"),
          Expanded(
            child: allData.isNotEmpty
                ? createDatatable()
                : Center(
                    child:
                        CircularProgressIndicator()), // Show a loader until data is fetched
          ),
        ],
      ),
    );
  }

  Widget createDatatable() {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: DataTable(
          columns: _columns(),
          rows: _rows(),
        ),
      ),
    );
  }

  List<DataColumn> _columns() {
    return [
      const DataColumn(
        label: Text("User ID"),
      ),
      const DataColumn(
        label: Text("User Username"),
      ),
      DataColumn(
        label: Text("User First Name"),
      ),
      DataColumn(
        label: Text("User Last Name"),
      ),
      DataColumn(
        label: Text("Action"),
      ),
    ];
  }

  List<DataRow> _rows() {
    return allData.map((data) {
      return DataRow(
        cells: [
          DataCell(
            Text(data['user_id'].toString()),
          ),
          DataCell(
            Text(data['user_username']),
          ),
          DataCell(
            Text(data['user_fname']),
          ),
          DataCell(
            Text(data['user_lname']),
          ),
          DataCell(
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _userID = data['user_id'].toString();
                      _usernameController.text = data['user_username'];
                      _firstnameController.text = data['user_fname'];
                      _lastnameController.text = data['user_lname'];
                    });
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Edit User"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  labelText: "Username",
                                ),
                              ),
                              TextField(
                                controller: _firstnameController,
                                decoration: InputDecoration(
                                  labelText: "First Name",
                                ),
                              ),
                              TextField(
                                controller: _lastnameController,
                                decoration: InputDecoration(
                                  labelText: "Last Name",
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                updateData();
                                Navigator.of(context).pop();
                              },
                              child: Text("Save"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Edit"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _userID = data['user_id'].toString();
                    });
                    deleteData();
                  },
                  child: Text("Delete"),
                ),
              ],
            ),
          ),
        ],
      );
    }).toList();
  }
}
