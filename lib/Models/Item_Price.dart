import 'package:flutter/material.dart';
class ItemPriceModel extends StatelessWidget {
  TextEditingController Item = new TextEditingController();
  TextEditingController Price = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(top: 15 , left:10 ,right: 10),
            child: TextFormField(
              controller: Item,
              decoration: InputDecoration(
                labelText: "Item",
                hintStyle: TextStyle(color: Colors.grey[600]),
                fillColor: Colors.grey[100],
                filled: true,
                contentPadding: EdgeInsets.all(12.0),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.grey[300]!, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 15 , right: 10),
            child: TextFormField(
              controller: Price,
            keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Price",
                hintStyle: TextStyle(color: Colors.grey[600]),
                fillColor: Colors.grey[100],
                filled: true,
                contentPadding: EdgeInsets.all(12.0),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.grey[300]!, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
