import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../Blocs/bloc_login.dart';
import '../Blocs/bloc_manager.dart';
import '../validator.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  bool _isSend = false;
  bool _hasEmailError = false;
  bool _hasPasswordError = false;

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

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
          }else if(state.error == "wrong-password"){
            _hasEmailError = false;
            _hasPasswordError = true;
          }else{
            _hasEmailError = true;
            _hasPasswordError = true;
          }
        }
      }, child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: const Color(0xFF1A2025),
              body: Stack(
                  children: <Widget>[
                    SvgPicture.asset('assets/Images&SVG/Bg Pattern.svg',
                      width: 1080,
                      height: 1920,
                      fit: BoxFit.fill
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: ListView(
                            children: [
                              SizedBox(height: screenHeight * 0.05),

                              const Text(
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
                                          focusedBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(color: Color(0xFF636AF6)),
                                          ),
                                          hintText: 'E-mail',
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
                                      controller: passwordTextController,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'ProximaNova-Regular',
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(
                                              vertical: 20),
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
                                      validator: (value) =>
                                          Validator.validatePassword(value),
                                    ),

                                    SizedBox(height: screenHeight * 0.15),
                                    //Se connecter
                                    SizedBox(
                                      width: double.infinity,
                                      height: 60,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateColor
                                              .resolveWith(
                                                (states) => const Color(0xFF636AF6),
                                          ),
                                        ),
                                        onPressed: () {
                                          _isSend = true;
                                          BlocProvider.of<UserBloc>(context).add(
                                                LogInEvent(emailTextController.text,
                                                    passwordTextController.text));
                                          _formKey.currentState!.validate();
                                        },
                                        child: const Text('Se connecter',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'ProximaNova-Regular'
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                    side: MaterialStateProperty.resolveWith<
                                        BorderSide?>(
                                          (states) {
                                        if (states.contains(MaterialState.pressed)) {
                                          return const BorderSide(
                                              color: Color(0xFF636AF6), width: 2);
                                        } else {
                                          return const BorderSide(
                                              color: Color(0xFF636AF6), width: 2);
                                        }
                                      },
                                    ),
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<ManagerBloc>(context).add(
                                        RegisterPageEvent());
                                  },
                                  child: const Text('Créer un nouveau compte',
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
                            padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                            child: GestureDetector(
                              onTap: () {
                                BlocProvider.of<ManagerBloc>(context).add(
                                    ForgottenPageEvent());
                              },
                              child: const Text(
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