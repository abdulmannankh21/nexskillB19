import 'package:flutter/material.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/nexskill.png",width: 200,),
              const Row(
                children: [
                  Text("Name ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red,width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Your Name",
                        icon: Icon(Icons.person_outlined,color: Colors.black,),
                          ),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text("Age ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red,width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Your Age",
                        icon: Icon(Icons.calculate,color: Colors.black,),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text("Email ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red,width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Your Email",
                        icon: Icon(Icons.email_outlined,color: Colors.black,),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text("Password ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red,width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Your Password",
                        icon: Icon(Icons.password_rounded,color: Colors.black,),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text("Confirm password ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red,width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Your Confirm Password",
                        icon: Icon(Icons.password_rounded,color: Colors.black,),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
