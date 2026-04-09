
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loginpage.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  bool isLoading = false;



  Future<void> signUpUser() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Login()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign Up Successful')),
      );

    } on FirebaseAuthException catch (e) {
      setState(() {
        String? error = 'Registration failed';

        if (e.code == 'email-already-in-use') {
          error = 'This email is already registered';
        } else if (e.code == 'invalid-email') {
          error = 'Invalid email format';
        } else if (e.code == 'weak-password') {
          error = 'Password is too weak';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:
          Text(
            error,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
        );

      });

    } finally {
      setState(() => isLoading = false);
    }

  }


  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }


  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }


  String? validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 140,
            ),
            Center(
              child: Container(
                width: 310,
                //height: 620,
                padding: EdgeInsets.all(
                  30,
                ),
                decoration: BoxDecoration(
                  //color: Colors.white,
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

                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back),),

                          SizedBox(width: 10,),

                          Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              //color: Colors.black87,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 35,
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
                          validator: validateEmail,
                          //initialValue: "",
                          decoration: InputDecoration(
                            //label: Text("Email"),
                            prefixIcon: Icon(Icons.email_outlined),
                            filled: true,
                            //fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
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
                        validator: validatePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          filled: true,
                          //fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
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
                        height: 35,
                      ),

                      Text(
                        "Confirm password",
                      ),

                      SizedBox(
                        height: 7,
                      ),

                      TextFormField(
                        controller: confirmPassController,
                        validator: validateConfirmPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          filled: true,
                          //fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
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
                            ? CircularProgressIndicator()
                            : Center(
                          child: ElevatedButton(
                            onPressed: (){
                              signUpUser();
                            },
                            child: Text(
                              "submit",
                              style: TextStyle(
                                //color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
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

