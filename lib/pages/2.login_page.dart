import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/pages/1.home_page.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);


  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  static Future<User?>loginUsingEmailPassword({required String email,required String password,required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    }on FirebaseAuthException catch(e){
      if (e.code == "user-not-found"){
        print("No User found for that email");
      }
    }
    return user;
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const Text("Shop Name",style: TextStyle(color: Colors.black,fontSize: 28.0,fontWeight: FontWeight.bold,
          ),
          ),
      const Text("Login here!",style: TextStyle(color: Colors.black,fontSize: 40.0,fontWeight: FontWeight.bold,
          ),

    ),
      const SizedBox(
            height: 44.0,
          ),
      Card(
        child: TextField(
          controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration:const InputDecoration(
                hintText: "user Email",
                prefixIcon: Icon(Icons.mail,color:Colors.black),
              ),
            ),
      ),
      const SizedBox(
            height: 26.0,
          ),
     Card(
       child: TextField(
          controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "User Password",
                prefixIcon: Icon(Icons.lock,color: Colors.black),


              ),
            ),
     ),
      const SizedBox(
            height: 12.0,
          ),
      const  Text("Forgot Password?",style: TextStyle (color: Colors.blue,fontSize:10),
          ),
      const SizedBox(
            height: 88.0,
          ),
          Container(
            width: double.infinity,
            child: RawMaterialButton(
              fillColor: const Color(0xFF388E3C),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              onPressed:() async {
                User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                print(user);
                if(user != null){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));

              }
                else{
                  print("bruh");
                }
              },
              child: const Text("Login",
              style:TextStyle(color: Colors.white,fontSize: 18.0
              ),
          ),
          ),
          ),
        ],
      ),
      
    );
  }
}
