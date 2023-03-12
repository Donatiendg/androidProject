import 'package:flutter/material.dart';

import '../Widgets/passwordCheck.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();

    bool _passwordsMatch = true;

    return Scaffold(
      backgroundColor: Color(0xFF1A2025),
      body: Container(
        margin:EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: ListView(
              children: [
                SizedBox(height: screenHeight * 0.05),
                Text(
                  'Inscription',
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
                //Nom d'utilisateur
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
                      hintText: 'Nom d\'utilisateur',
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
                      return 'Veuillez entrer votre nom d\'utilistaeur';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.015),
                //Mail
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
                      hintText: 'E-Mail',
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
                PasswordFields(),



                SizedBox(height: screenHeight * 0.15),
                //S'inscrire
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
                    child: Text('S\'inscrire',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'ProximaNova-Regular'
                      ),),
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
