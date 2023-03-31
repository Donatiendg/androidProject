import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../Blocs/bloc_login.dart';
import '../Blocs/bloc_manager.dart';
import '../validator.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  bool _isSend = false;
  bool _hasEmailError = false;
  bool _hasPasswordError = false;

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider<UserBloc>(
      create: (_) => UserBloc(),
      child: BlocListener<UserBloc, UserState>(
        listener: (BuildContext context, UserState state) {
          if(state is Success){
            BlocProvider.of<ManagerBloc>(context).add(HomePageEvent(state.user));
          }else if (state is ErrorState){
            if(state.error == "invalid-email"){
              _hasEmailError = true;
              _hasPasswordError = false;
            }else if(state.error == "weak-password"){
              _hasEmailError = false;
              _hasPasswordError = true;
            }else if(state.error == "les mots de passe ne sont pas identiques"){
              _hasEmailError = false;
              _hasPasswordError = true;
            }else if (state.error == "email-already-in-use"){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                  ));
              _hasEmailError = true;
              _hasPasswordError = false;
            }else{
              _hasEmailError = true;
              _hasPasswordError = true;
            }
          }
        }, child: BlocBuilder<UserBloc, UserState>(
        builder: (context, snapshot) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color(0xFF1A2025),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: <Widget>[
                  SvgPicture.asset('assets/Images&SVG/Bg Pattern.svg',
                    width: 1080,
                    height: 1920,
                    fit: BoxFit.fill
                  ),
                  Container(
                  margin:EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: ListView(
                          children: [
                          SizedBox(height: screenHeight * 0.05),

                          const Text(
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
                            child: const Text(
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

                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: nameTextController,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'ProximaNova-Regular',
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 20),
                                      hintText: 'Nom d\'utilisateur',
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFF636AF6)),
                                      ),
                                      filled: true,
                                      fillColor:Color(0xFF1e262c),
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'ProximaNova-Regular',
                                        fontSize: 18,
                                      )
                                  ),
                                  validator: (value) => Validator.validateName(value),
                                ),

                                SizedBox(height: screenHeight * 0.015),
                                //Mail
                                TextFormField(
                                  controller: emailTextController,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'ProximaNova-Regular',
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                                      hintText: 'E-Mail',
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFF636AF6)),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFF1e262c),
                                      hintStyle: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'ProximaNova-Regular',
                                        fontSize: 18,
                                      ),
                                      suffixIcon: _isSend && _hasEmailError
                                          ? const Icon(Icons.error, color: Colors.red)
                                          : null
                                  ),
                                  validator: (value) => Validator.validateEmail(value),
                                ),

                                SizedBox(height: screenHeight * 0.015),
                                //Mot de passe
                                TextFormField(
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'ProximaNova-Regular',
                                    fontSize: 18,
                                  ),
                                  controller: passwordController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                                      hintText: 'Mot de passe',
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFF636AF6)),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFF1e262c),
                                      hintStyle: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'ProximaNova-Regular',
                                        fontSize: 18,
                                      ),
                                      suffixIcon: _isSend && _hasPasswordError
                                          ? const Icon(Icons.error, color: Colors.red)
                                          : null
                                  ),
                                  obscureText: true,
                                  validator: (value) => Validator.validatePassword(value),
                                ),

                                const SizedBox(height:10),
                                //Confirmer mot de passe
                                TextFormField(
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'ProximaNova-Regular',
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                  controller: confirmPasswordController,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                                      hintText: 'Vérification du mot de passe',
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFF636AF6)),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFF1e262c),
                                      hintStyle: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'ProximaNova-Regular',
                                        fontSize: 18,
                                      ),
                                      suffixIcon: _isSend && _hasPasswordError
                                        ? const Icon(Icons.error, color: Colors.red)
                                        : null
                                  ),
                                  obscureText: true,
                                  validator: (value) => Validator.validateConfirmPassword(passwordController.text, value)
                                ),

                                SizedBox(height: screenHeight * 0.15),
                                //S'inscrire
                                SizedBox(
                                    width: double.infinity,
                                    height: 60,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateColor.resolveWith(
                                              (states) => const Color(0xFF636AF6),
                                        ),
                                      ),
                                      onPressed: () async {
                                        _isSend = true;
                                        BlocProvider.of<UserBloc>(context).add(RegisterEvent(nameTextController.text, emailTextController.text, passwordController.text, confirmPasswordController.text));
                                        _formKey.currentState!.validate();
                                      },
                                      child: const Text('S\'inscrire',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'ProximaNova-Regular'
                                        ),),
                                    ),
                                  ),
                                SizedBox(height: screenHeight * 0.015),
                              ],
                            ),
                          ),
                        ],
                        )
                      ),
                    ],
                  ),
                ),
              ]
              ),
            ),
          );
          },
        ),
      ),
    );
  }
}