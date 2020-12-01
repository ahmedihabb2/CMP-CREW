import 'package:flutter/material.dart';
import 'package:cmp_crew/Models/CMP.dart';
import 'package:cmp_crew/Models/StatisticCard.dart';
import 'package:provider/provider.dart';
class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {

  @override
  Widget build(BuildContext context) {
    int _fool=0;
    int _ta3meya=0;
    int _8anoog=0;
    int _sawab3=0;
    int _chipsy=0;
    int _cost=0;
    final cmps = Provider.of<List<CMP>>(context) ?? [];
    if(cmps !=null) {
      for(int i=0 ; i<cmps.length ; i++)
        {
          setState(() {
            _fool += cmps[i].meal[0]["Fool"];
            _ta3meya += cmps[i].meal[1]["Ta3meya"];
            if(cmps[i].sawab3 == true)
              {
               _sawab3 +=  cmps[i].meal[2]["Batates"];
              }else{
              _chipsy +=  cmps[i].meal[2]["Batates"];
            }
            cmps[i].meal.length >3 ?_8anoog += cmps[i].meal[3]["8anoog"] :_8anoog +=0;
            _cost += cmps[i].cost;
          });

      }
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(child: Text("Fool:" , style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22
                    ),
                    )
                    ),
                    Text((_fool).toString(),style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                    ),)
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(child: Text("Ta3meya:",style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22
                ),)),
                    Text((_ta3meya).toString(),style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                    ),)
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(child: Text("8anoog:",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                    ),)),
                    Text((_8anoog).toString(),style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                    ),)
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(child:Text("Sawab3:",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                    ),)),
                    Text((_sawab3).toString(),style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                    ),)
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(child:Text("Chipsy:",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                    ),)),
                    Text((_chipsy).toString(),style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                    ),)
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(child: Text("Total Money:",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                    ),)),
                    Text((_cost).toString(),style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                    ),)
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(child: Text("Total orders:",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                    ),)),
                    Text(cmps.length.toString(),style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                    ),)
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
