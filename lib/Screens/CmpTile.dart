import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cmp_crew/Models/CMP.dart';

class CMPTile extends StatelessWidget {
  final CMP? cmp;

  CMPTile({this.cmp});

  @override
  Widget build(BuildContext context) {
    List keys = cmp!.order!.keys.toList();
    List values = cmp!.order!.values.toList();
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 1.3,
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(top: 7, left: 7),
            child: Text(
              cmp!.name!,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 7.0,bottom: 7),
            child: keys.length == 0
                ? Text("No order")
                : Column(
              mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: keys.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Text(keys[index]+" (x"+values[index][1].toInt().toString()+")",
                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                            ),
                          );
                        }),
                    cmp!.change ==-1 ? SizedBox() :
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Text("Change : ${cmp!.change} LE",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)
                            ),
                          ),
                        )
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
