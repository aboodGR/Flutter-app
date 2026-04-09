import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signuppage.dart';
import 'Homepage.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;


  Future<void> loginUser() async {
    if (!formKey.currentState!.validate()) return;
    setState(() {
      isLoading = true;

    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Home(Email: emailController.text)),
      );
    } on FirebaseAuthException {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:
        Text(
          'Invalid Username or Password',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 180,
            ),
            Center(
              child: Container(
                width: 310,
                //height: 510,
                padding: EdgeInsets.all(
                  30,
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                        30,
                      ),
                      bottom: Radius.circular(
                          30
                      ),
                    )
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          //color: Colors.black87,
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      Text(
                        "Email",
                      ),

                      SizedBox(
                        height: 7,
                      ),

                      SizedBox(
                        //width: 200,
                        child: TextFormField(
                          controller: emailController,
                          validator: (value){
                            if(value == null || value.isEmpty || !value.contains("@"))
                            {
                              return "please enter a valid email !";
                            }
                            return null;
                          },
                          //initialValue: "",
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            filled: true,
                            //fillColor: Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width: 3,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 3,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 6,
                              ),
                            ),

                          ),
                        ),

                      ),

                      SizedBox(
                        height: 35,
                      ),

                      Text(
                        "Password",
                      ),


                      SizedBox(
                        height: 7,
                      ),

                      TextFormField(
                        controller: passwordController,
                        validator: (value){
                          if(value == null || value.isEmpty || value.length < 8) {
                            return "Invalid password!";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          filled: true,
                          //fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 3,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 3,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                              width: 6,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 45,
                      ),


                      Center(
                        child: isLoading
                            ?CircularProgressIndicator()
                            :ElevatedButton(
                          onPressed: (){
                            loginUser();
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),


                      SizedBox(
                        height: 45,
                      ),

                      Row(
                         children: [
                           Text(
                             "Don't have an account?",
                           ),

                           SizedBox(
                             width: 5,
                           ),

                           InkWell(
                             onTap: (){
                               Navigator.push(context, MaterialPageRoute(
                                   builder: (context) => SignUp()
                               ));
                             },
                             child: Text(
                               "Sign up",
                               style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 16,
                                 color: Theme.of(context).colorScheme.secondary,
                               ),
                             ),
                           ),
                         ],
                       ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}