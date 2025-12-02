import 'package:flutter/material.dart';
import '../styles/app_styles.dart';

Widget seccioTitol(String titol) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(titol, style: AppStyles.sectionTitle),
    );
  }

  Widget creaTaula(List<List<String>> dades) {
    return Table(
      border: TableBorder.all(color: Colors.red),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
      },
      children: dades.map((fila) {
        bool isHeader = fila[1].isEmpty;
        return TableRow(
          decoration: BoxDecoration(
            color: isHeader ? Colors.grey.shade300 : null,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                fila[0],
                style: isHeader ? AppStyles.tableHeader : AppStyles.tableCell,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                fila[1],
                style: AppStyles.tableCell,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }