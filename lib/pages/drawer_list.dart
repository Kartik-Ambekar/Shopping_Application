import 'package:flutter/material.dart';

class drawerList extends StatelessWidget {
  List<String> drawerItems = ['Today','This Week', 'This month',];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Expanded(child: ListView.builder(
              itemCount: drawerItems.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(drawerItems[index].toString(),
                                    style: TextStyle(fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),

                                ],
                              ),
                            )

                          ],)
                      ],
                    ),
                  ),
                );
              }),
          )
        ],
      ),
    );
  }
}


