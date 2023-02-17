import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/pages/bill_Page.dart';
import 'package:untitled/pages/cart_model.dart';
import 'package:untitled/pages/cart_provider.dart';
import 'package:untitled/pages/database_helper.dart';
import 'file_handle_api.dart';
import 'bill_Page.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}


class _CartScreenState extends State<CartScreen> {

  DBHelper? dbHelper= DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
          centerTitle: true,
          actions: [
            Center(
              child:Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value , child){
                    return Text(value.getcounter().toString(),style: TextStyle(color: Colors.white));
                  },

                ),
                animationDuration: Duration(milliseconds: 300),
                child:Icon(Icons.shopping_cart_outlined),
              ),),
            SizedBox(width: 20.0,)

          ],
        ),
        body: Column(
          children: [
            FutureBuilder(
                future: cart.getData(),
                builder: (context , AsyncSnapshot<List<Cart>> snapshot) {

                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty){
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Cart is Empty'),
                          ],
                        )
                      );
                    };

                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
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
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(snapshot.data![index].productName.toString(),
                                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                                    ),
                                                    InkWell(
                                                        onTap: (){
                                                          dbHelper!.delete(snapshot.data![index].id!);
                                                          cart.removeCounter();
                                                          cart.removeTotalPrice(double.parse(snapshot.data![index].productPrice.toString()));
                                                        },
                                                        child: Icon(Icons.delete))
                                                  ],
                                                ),
                                                //SizedBox(height: 5,),
                                                //Text(snapshot.data![index].productName.toString(),
                                                  //style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                                //),
                                                SizedBox(height: 5,),
                                                Text('₹' + snapshot.data![index].productPrice.toString(),
                                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(height: 5,),
                                                Align(
                                                  //alignment: Alignment.centerRight,
                                                  child: InkWell(
                                                    onTap: () {

                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius: BorderRadius
                                                              .circular(300)
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            InkWell(
                                                                onTap:(){
                                                                  int quantity = snapshot.data![index].quantity! ;
                                                                  int price = snapshot.data![index].initialPrice!;
                                                                  quantity--;
                                                                  int? newprice = price * quantity ;
                                                                  if(quantity > 0){
                                                                    dbHelper!.updateQuantity(
                                                                        Cart(
                                                                          id: snapshot.data![index].id,
                                                                          productId: snapshot.data![index].productId.toString(),
                                                                          productName: snapshot.data![index].productName!,
                                                                          initialPrice: snapshot.data![index].initialPrice!,
                                                                          productPrice: newprice,
                                                                          quantity: quantity,)
                                                                    ).then((value){
                                                                      newprice=0;
                                                                      quantity=0;
                                                                      cart.removeTotalPrice(double.parse(snapshot.data![index].initialPrice!.toString()));
                                                                    }).onError((error, stackTrace){
                                                                      print(error.toString());

                                                                    });

                                                                  }



                                                      },
                                                                child: Icon(Icons.remove,color:Colors.white)),
                                                            Text(snapshot.data![index].quantity.toString(),style: TextStyle(color: Colors.white)),
                                                            InkWell(
                                                                onTap: (){
                                                                  int quantity = snapshot.data![index].quantity! ;
                                                                  int price = snapshot.data![index].initialPrice!;
                                                                  quantity++;
                                                                  int? newprice = price * quantity ;

                                                                  dbHelper!.updateQuantity(
                                                                      Cart(
                                                                          id: snapshot.data![index].id,
                                                                          productId: snapshot.data![index].productId.toString(),
                                                                          productName: snapshot.data![index].productName!,
                                                                          initialPrice: snapshot.data![index].initialPrice!,
                                                                          productPrice: newprice,
                                                                          quantity: quantity,)
                                                                  ).then((value){
                                                                    newprice=0;
                                                                    quantity=0;
                                                                    cart.addTotalPrice(double.parse(snapshot.data![index].initialPrice!.toString()));
                                                                  }).onError((error, stackTrace){
                                                                    print(error.toString());

                                                                  });
                                                            },
                                                                child: Icon(Icons.add,color:Colors.white))

                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )

                                              ],
                                            ),
                                          )

                                        ],)
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  return Text('');
                  }),
            Consumer<CartProvider>(builder: (context , value, child){
              return Visibility(
                visible: value.getTotalPrice().toStringAsFixed(2)=='0.00'? false:true,
                child: Column(
                  children: [
                    ReusableWidget(title: 'Sub Total', value: r'₹'+value.getTotalPrice().toStringAsFixed(2),)
                  ],
                ),
              );
            }),
            SizedBox(
              height: 12.0
            ),
            Consumer<CartProvider>(builder: (context,value,child){
              return Visibility(
                  visible: value.getTotalPrice().toStringAsFixed(2)=='0.00'? false:true,
                  child: Container(
                    width: double.infinity,
                    child: RawMaterialButton(
                      fillColor: const Color(0xFF388E3C),
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),

                      onPressed:() async {
                        final pdfFile = await billPage.generate();

                        FileHandleApi.openFile(pdfFile);

                      },


                      child: const Text("Generate Invoive",
                        style:TextStyle(color: Colors.white,fontSize: 18.0
                        ),
                      ),
                    ),
                  ),
              );
            })
          ],
        ),
    );

  }
}
class ReusableWidget extends StatelessWidget {
  final String title,value;
  const ReusableWidget({required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.subtitle2,),
          Text(value.toString(), style: Theme.of(context).textTheme.subtitle2,)
        ],
      ),
    );
  }
}