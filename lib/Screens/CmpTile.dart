import 'package:flutter/material.dart';
import 'package:cmp_crew/Models/CMP.dart';

class CMPTile extends StatelessWidget {
  final CMP cmp;
  CMPTile({this.cmp});
  @override
  Widget build(BuildContext context) {
    String chiporsawab3 = cmp.sawab3 ? "Sawab3" : "Chipsy";
    final int fool =cmp.meal[0]["Fool"];
    final int ta3meya =cmp.meal[1]["Ta3meya"];
    final int batats = cmp.meal[2]["Batates"];
    final int b8anoog = cmp.meal.length >3 ?cmp.meal[3]["8anoog"]:0;
    final  int cost = cmp.cost;
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(top: 7 ,left: 7),
            child: Text(cmp.name , style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16
            ),),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Text("Fool: "+fool.toString()+
                "    Ta3meya: "+ta3meya.toString()+
                "    "+chiporsawab3+": "+batats.toString() +
                "    8anoog: "+b8anoog.toString() +
                "    Cost: "+cost.toString()
            ,
            style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
