import 'package:eceee/Pages/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF1A2025),
      body: Stack(
        children: <Widget> [
          SvgPicture.asset('assets/Images&SVG/Bg Pattern.svg',
              width: 1080,
              height: 1920,
              fit: BoxFit.fill),
          Container(
          margin:EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: ListView(
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  Text(
                    'Bienvenue !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.white,
                        fontFamily: 'GoogleSans-Bold'
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  SizedBox(
                    width: screenWidth * 0.5,
                    child: Text(
                      'Veuillez vous connecter ou créer un nouveau compte pour utiliser l\'application.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15.265845,
                          color: Colors.white,
                          fontFamily: 'ProximaNova-Regular'
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),
                  //Email
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ProximaNova-Regular',
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        hintText: 'E-mail',
                        filled: true,
                        fillColor:Color(0xFF1e262c),
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: 'ProximaNova-Regular',
                          fontSize: 18,
                        )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre adresse e-mail';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: screenHeight * 0.015),
                  //Mot de passe
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ProximaNova-Regular',
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                    obscureText: true,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        hintText: 'Mot de passe',
                        filled: true,
                        fillColor: Color(0xFF1e262c),
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: 'ProximaNova-Regular',
                          fontSize: 18,
                        )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre mot de passe';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: screenHeight * 0.15),
                  //Se connecter
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Color(0xFF636AF6),
                        ),
                      ),
                      onPressed: () {
                        //if (_formKey.currentState!.validate()) {
                        // Process login request here
                        //}
                      },
                      child: Text('Se connecter',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'ProximaNova-Regular'
                        ),),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.015),
                  //Créer un nouveau compte
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.transparent,
                        ),
                        elevation: MaterialStateProperty.all(0),
                        side: MaterialStateProperty.resolveWith<BorderSide?>(
                              (states) {
                            if (states.contains(MaterialState.pressed)) {
                              return BorderSide(color: Color(0xFF636AF6), width: 2);
                            } else {
                              return BorderSide(color: Color(0xFF636AF6), width: 2);
                            }
                          },
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterPage()),
                        );
                      },
                      child: Text('Créer un nouveau compte',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'ProximaNova-Regular'
                          )),
                    ),
                  ),

                ],
              )
              ),
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.015 ),
                child: GestureDetector(
                  onTap: () {
                    // Handle forgot password here
                  },
                  child: Text(
                    'Mot de passe oublié',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "ProximaNova-Regular",
                      color: Colors.white60,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
    ]
      ),

    );
  }
}