import 'package:flutter/material.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("User Dashboard"),
          createDatatable(),
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
        label: Text("Name"),
      ),
      const DataColumn(
        label: Text("Age"),
      ),
      DataColumn(
        label: Text("Action"),
      ),
    ];
  }

  List<DataRow> _rows() {
    return [
      DataRow(
        cells: [
          DataCell(
            Text("John"),
          ),
          DataCell(
            Text("25"),
          ),
          DataCell(
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Edit"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Delete"),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
  }
}
