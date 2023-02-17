import 'package:flutter/material.dart';

class headerdrawer extends StatelessWidget {
  const headerdrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[700],
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
           ),
          Text("CASHIER DETAILS",style: TextStyle(color:Colors.white, fontSize:20),),


        ],
      ),
    );
  }
}

    