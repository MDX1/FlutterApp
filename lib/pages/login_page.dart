import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'forgot_pw_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //icon
                Icon(
                  Icons.verified_outlined,
                  size: 100,
                ),
                //Hello
                Text(
                  'Conectare',
                  style: GoogleFonts.bebasNeue(fontSize: 52),
                ),
                SizedBox(height: 20),

                // email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                // forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ForgotPasswordPage();
                                },
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 2),
                // signIn
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Conecteza-te',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                        color: Colors.deepPurple,
                        textColor: Colors.white,
                        onPressed: signIn),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25),
                //   child: GestureDetector(
                //     onTap: signIn,
                //     child: Container(
                //       padding: EdgeInsets.all(25),
                //       decoration: BoxDecoration(color: Colors.deepPurple,
                //       borderRadius: BorderRadius.circular(12)),
                //       child: Center(
                //         child: Text(
                //           'Conecteaza-te',
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontWeight: FontWeight.bold,
                //             fontSize: 18
                //             ),
                //           ),
                //       ),

                //     ),
                //   ),
                // ),
                SizedBox(height: 10),

                // Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Nu esti inregistrat? ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: Text(
                        'Fa-ti cont acum',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
