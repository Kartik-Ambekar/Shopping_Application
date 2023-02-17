import 'package:badges/badges.dart';
//import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/pages/cart_model.dart';
import 'package:untitled/pages/cart_provider.dart';
import 'package:untitled/pages/cart_screen.dart';
import 'package:untitled/pages/database_helper.dart';
import 'package:untitled/pages/drawer_list.dart';
import 'package:untitled/pages/orders.dart';
import 'header_drawer.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatelessWidget {

  DBHelper? dbHelper = DBHelper();
  List<String> productName = ['Product_1' , 'Product_2' , 'Product_3' , 'Product_4' , 'Product_5' , 'Product_6','Product_7',] ;
  List<int> productRate = [10, 20 , 30 , 40 , 50, 60 , 70 ] ;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("The Lassi Shop"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> CartScreen()));
            },
            child: Center(
              child:Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value , child){
                    return Text(value.getcounter().toString(),style: TextStyle(color: Colors.white));
                  },

                ),
                animationDuration: Duration(milliseconds: 300),
                child:Icon(Icons.shopping_cart_outlined),
            ),),
          ),
          SizedBox(width: 20.0,)

        ],
      ),
      body:Column(
        children: [
          Expanded(child: ListView.builder(
              itemCount:productName.length,
              itemBuilder: (context,index){
            return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        children: [
                          Text(productName[index].toString(),
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5,),
                          Text('₹'+productRate[index].toString(),
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height:5,),
                          Align(
                            //alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: (){
                                print(index);
                                print(index);
                                print(productName[index].toString());
                                print( productRate[index].toString());
                                print( productRate[index]);
                                print('1');

                                dbHelper!.insert(
                                  Cart(
                                      id: index,
                                      productId: index.toString(),
                                      productName: productName[index].toString(),
                                      initialPrice: productRate[index],
                                      productPrice: productRate[index],
                                      quantity: 1,)
                                  ).then((value){
                                    cart.addTotalPrice(double.parse(productRate[index].toString()));
                                    cart.addCounter();

                                  }).onError((error ,stackTrace){
                                    print(error.toString());
                                  });
                              },
                              child: Container(
                                height: 35,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                child: Center(
                                  child:Text('Add to cart',style: TextStyle(color: Colors.white),)
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                    )

                ],              )
    ],
              ),
            ),
            );
    }),
          ),

        ],
        
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                headerdrawer(),
                //drawerList(),

              ],


          ),

          ),
        ),

      ),
    );
  }

  }



