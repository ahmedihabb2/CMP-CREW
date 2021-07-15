import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmp_crew/Models/CMP.dart';
import 'package:cmp_crew/Screens/CmpTile.dart';
import 'package:provider/provider.dart';
class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final cmps = Provider.of<List<CMP>>(context) ?? [];
    return ListView.builder(
      itemCount: cmps.length,
      itemBuilder: (context,index){
        return CMPTile(cmp: cmps[index]);
      },
    );
  }
}
