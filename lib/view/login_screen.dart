import 'dart:convert';
import 'package:e_commerce_app/provider/user_provider.dart';
import 'package:e_commerce_app/view/HomeScreen.dart';
import 'package:e_commerce_app/view/sign_up.dart';
import 'package:e_commerce_app/widgets/TextFormField.dart';
import 'package:e_commerce_app/widgets/orangeBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_commerce_app/model/users_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

   final TextEditingController mobileController = TextEditingController();
  final TextEditingController passController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Theme.of(context).primaryColorDark,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));


    final height = MediaQuery.of(context).size.height;
    void handleLogin() async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (!userProvider.isLoaded) {
        try {
          await userProvider.fetchUsers();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to load users")),
          );
          return;
        }
      }
      final enteredPhone = mobileController.text.trim();
      final enteredPass = passController.text.trim();

      final user = userProvider.login(enteredPhone, enteredPass);

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid credentials")),
        );
      }
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:  EdgeInsets.only(top: height*.02),
            child: Image(
              image: AssetImage('assets/logo.png'),
              height: height*.30,
            ),
          ),
          SizedBox(
            height: height*.02,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Theme.of(context).primaryColorDark),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: AutofillGroup(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome Back!',
                        style: GoogleFonts.sora(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorLight),
                      ),
                      Text(
                        'Enter your details below',
                        style: GoogleFonts.inter(
                            fontSize: 14, color: Theme.of(context).secondaryHeaderColor),
                      ),
                      ReusableTextFormField(
                        controller: mobileController,
                        autofillHint: AutofillHints.telephoneNumber,
                        hintText: 'Mobile Number',
                      ),
                      ReusableTextFormField(
                        controller: passController,
                        autofillHint: AutofillHints.password,
                        hintText: 'Password',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forget your password?',
                            style: GoogleFonts.sora(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child:  Orangebtn(text: 'Login',onTap: (){
                            handleLogin();
                          },),
                        ),
                      SizedBox(
                        height: height * .1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have account? ',
                            style: GoogleFonts.inter(
                                fontSize: 14, color: Theme.of(context).secondaryHeaderColor),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                              child: Text(' Sign Up',
                                  style: GoogleFonts.sora(
                                    fontSize: 14,
                                    color: Theme.of(context).primaryColorLight,
                                  )))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
