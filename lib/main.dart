import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/pages/1.home_page.dart';
import 'package:untitled/pages/2.login_page.dart';
import 'package:untitled/pages/cart_provider.dart';
void main() {
  runApp(Hey());

}

class Hey extends StatelessWidget {
  const Hey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
        create: (_) => CartProvider(),
      child: Builder(builder:(BuildContext context){
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            //home: Homepage(),
            themeMode: ThemeMode.light,
            theme: ThemeData(primarySwatch: Colors.deepPurple),
        darkTheme: ThemeData(
        brightness: Brightness.dark,
        ),
        initialRoute: "home",
        routes: {

          "home":(context) => HomePage(),
        
        });

      }),


    );
  }
}
