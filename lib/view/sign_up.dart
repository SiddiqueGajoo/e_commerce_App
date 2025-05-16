import 'package:e_commerce_app/view/login_screen.dart';
import 'package:e_commerce_app/widgets/TextFormField.dart';
import 'package:e_commerce_app/widgets/orangeBtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Theme.of(context).primaryColorDark,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    TextEditingController mobileController = TextEditingController();
    TextEditingController passController = TextEditingController();
    TextEditingController confirmPassController = TextEditingController();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.only(top: height*.01),
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
                  padding:  EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started',
                        style: GoogleFonts.sora(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColorLight),
                      ),
                      Text(
                        'Enter your details below',
                        style:
                        GoogleFonts.inter(fontSize: 14, color: Theme.of(context).secondaryHeaderColor),
                      ),
                      ReusableTextFormField(controller: mobileController, hintText: 'Mobile Number',),
                      ReusableTextFormField(controller: passController, hintText: 'Password',suffixIcon: Icon(Icons.remove_red_eye_outlined),),
                      ReusableTextFormField(controller: confirmPassController, hintText: 'Confirm Password',suffixIcon: Icon(Icons.remove_red_eye_outlined),),

                      Padding(
                        padding: EdgeInsets.only(top: height*.02,left: 10,right: 10,bottom: height*.01),
                        child: Orangebtn(text: 'Sign Up',onTap: (){
                          Navigator.pop(context);
                        },)
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Divider(indent: 30,
                              color: Theme.of(context).secondaryHeaderColor)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text("Or Continue with", style: TextStyle(color: Theme.of(context).primaryColorLight)),
                          ),
                          Expanded(child: Divider(endIndent: 30,color: Theme.of(context).secondaryHeaderColor)),
                        ],
                      ),
                      SizedBox(height: height*.01,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: height*.07,
                            width: width*.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Theme.of(context).secondaryHeaderColor,
                              ),

                            ),
                            child: Center(
                                child: Image(image: NetworkImage('https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-1024.png'))
                            ),
                          ),
                          SizedBox(width: width*.03,),
                          Container(
                            height: height*.07,
                            width: width*.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Theme.of(context).secondaryHeaderColor,
                              ),

                            ),
                            child: Center(
                                child: Image(image: NetworkImage('https://cdn4.iconfinder.com/data/icons/iconsimple-logotypes/512/apple-1024.png'),height: 30,width: 30,)
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have account? ',
                              style: GoogleFonts.inter(
                                  fontSize: 14, color: Theme.of(context).secondaryHeaderColor),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Text(' Sign in',
                                  style: GoogleFonts.sora(
                                    fontSize: 14,
                                    color: Theme.of(context).primaryColorLight,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class IconContainer extends StatelessWidget {
  final iconLink,imgheight,imgwidth;
  const IconContainer({required this.iconLink,this.imgheight,this.imgwidth,super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height*.07,
      width: width*.04,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).secondaryHeaderColor,
        ),

      ),
      child: Center(
          child: Image(image: NetworkImage(iconLink),height: imgheight,width: imgwidth,)
      ),
    );
  }
}
