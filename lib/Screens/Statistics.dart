// @dart=2.9
import 'package:cmp_crew/Services/MenuServices.dart';
import 'package:flutter/material.dart';
import 'package:cmp_crew/Models/CMP.dart';
import 'package:cmp_crew/Models/StatisticCard.dart';
import 'package:provider/provider.dart';

class Statistics extends StatefulWidget {
  final String roomID;

  Statistics({this.roomID});

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  double totalMoney;
  double totalOrdersnum;
  @override
  Widget build(BuildContext context) {
    Map totalOrders= Map<String,double>();
    final cmps = Provider.of<List<CMP>>(context) ?? [];
    if(cmps !=null)
      {
        totalMoney=0;
        totalOrdersnum= 0;
        for(int i=0 ; i< cmps.length ; i++)
          {
            List items = cmps[i].order.keys.toList();
            List Prices = cmps[i].order.values.toList();
            if(items.length> 0) totalOrdersnum++;
            for(int j=0 ; j<items.length;j++)
              {
                if(totalOrders[items[j]]==null)
                  {
                    totalOrders[items[j]]=0.0;
                  }

                totalOrders[items[j]]+=Prices[j][1];
                totalMoney+=Prices[j][0];
              }
          }
        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: totalOrders.length ,
              itemBuilder: (context, index){
                List items = totalOrders.keys.toList();
                List total = totalOrders.values.toList();
                return Card(
                  margin: EdgeInsets.all(8),
                   child: Padding(
                     padding: const EdgeInsets.all(9.0),
                     child: Row(
                       children: [
                         Text(items[index],style: TextStyle(
                             fontWeight: FontWeight.w600,
                             fontSize: 22
                         ),),
                         Spacer(),
                         Text(total[index].toInt().toString(),style: TextStyle(
                             fontWeight: FontWeight.w600,
                             fontSize: 22
                         ),),
                       ],

                     ),
                   ),
                );
              },
            ),
            Card(
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  children: [
                    Text("Total money",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                    ),),
                    Spacer(),
                    Text(totalMoney.toString(),style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                    ),),
                  ],

                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  children: [
                    Text("Total orders",style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                    ),),
                    Spacer(),
                    Text(totalOrdersnum.toInt().toString(),style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                    ),),
                  ],

                ),
              ),
            )
          ],
        );
      }
  }

}
