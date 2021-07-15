import 'package:flutter/material.dart';

class StatisticCard extends StatelessWidget {
  final String? txt;
  final int? count;
  StatisticCard({this.txt , this.count});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(txt!),
          Text(count.toString())
        ],
      ),
    );
  }
}
