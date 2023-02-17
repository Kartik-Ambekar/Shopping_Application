import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/pages/cart_provider.dart';
import 'package:untitled/pages/cart_screen.dart';

class orderPage extends StatelessWidget {
  List<String> orderItems = ['Today','This Week', 'This month',];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The lassai Shop"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
            child: Center(
              child: Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return Text(value.getcounter().toString(),
                        style: TextStyle(color: Colors.white));
                  },
                ),
                animationDuration: Duration(milliseconds: 300),
                child: Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ),
          SizedBox(width: 20.0,)
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
              itemCount: orderItems.length,
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
                                  Text(orderItems[index].toString(),
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
