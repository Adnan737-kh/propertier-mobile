import 'package:flutter/material.dart';
import 'package:propertier/Utils/textStyle.dart';

class FilesDetailTable extends StatelessWidget {
  final List<Map<String, dynamic>> data; // List of table data

  const FilesDetailTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      horizontalMargin: 0,
      columnSpacing: 10,
      dividerThickness: 0,
      dataRowMaxHeight: 30,
      dataRowMinHeight: 20,
      headingTextStyle: textStyle(
          context: context,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.clip),
      dataTextStyle: textStyle(
          context: context, fontSize: 12, overflow: TextOverflow.clip),
      columns: const [
        DataColumn(label: Text('Files')),
        DataColumn(label: Text('Category')),
        DataColumn(label: Text('#Of File')),
        DataColumn(label: Text('Asking Price')),
        DataColumn(label: Text('Paid Price')),
        DataColumn(label: Text('Total Paid')),
      ],
      rows: data.map((item) => _dataRow(item)).toList(),
    );
  }

  DataRow _dataRow(Map<String, dynamic> item) {
    return DataRow(
      cells: [
        DataCell(Text(item['Files'].toString())),
        DataCell(Text(item['Category'].toString())),
        DataCell(Text(item['#Of File'].toString())),
        DataCell(Text(item['Asking Price'].toString())),
        DataCell(Text(item['Paid Price'].toString())),
        DataCell(Text(item['Total Paid'].toString())),
      ],
    );
  }
}
