import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

    // text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (passwrodConfirmed() == true){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(), 
        password: _passwordController.text.trim()
      );
    }
  }

  bool passwrodConfirmed(){
    if(_passwordController.text.trim() == _confirmpasswordController.text.trim()){
      return true;
    } else return false;
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
              Icons.verified,
              size: 100,
            ),
            //Hello
            Text('Inregistrare',
            style: GoogleFonts.bebasNeue(
              fontSize: 52
            ),
            ),
            SizedBox(height: 20),
          
            // email textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12)
                ),
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
                  borderRadius: BorderRadius.circular(12)
                ),
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
            SizedBox(height: 10),

            //confirm password textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    controller: _confirmpasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Confirm Password',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
        
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
                    child: Text('Inregistreaza-te',
                    style: 
                      TextStyle(
                        color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25
                      ),
                    ),
                  ),
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                  onPressed: signUp),
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
                Text('Esti inregistrat? ',style: TextStyle(fontWeight: FontWeight.bold),),
                GestureDetector( 
                  onTap: widget.showLoginPage,
                  child: Text('Conecteaza-te',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],),
        ),
      ),
      ),
    );
  }
}