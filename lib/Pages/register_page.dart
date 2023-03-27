import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../Blocs/bloc_login.dart';
import '../Blocs/bloc_manager.dart';
import '../validator.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider<TrueUserBloc>(
      create: (_) => TrueUserBloc(),
      child: BlocListener<TrueUserBloc, TrueUserState>(
        listener: (BuildContext context, TrueUserState state) {
          if(state is Success){
            BlocProvider.of<ManagerBloc>(context).add(HomePageEvent(state.user));
          }else if (state is ErrorState){
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ));
          }
        }, child: BlocBuilder<TrueUserBloc, TrueUserState>(
        builder: (context, snapshot) {
          return Scaffold(
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
                                    filled: true,
                                    fillColor:Color(0xFF1e262c),
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'ProximaNova-Regular',
                                      fontSize: 18,
                                    )
                                ),
                                validator: (value) => Validator.validateName(name: value),
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
                                decoration: const InputDecoration(
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
                                validator: (value) => Validator.validateEmail(email: value),
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
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                                    hintText: 'Mot de passe',
                                    filled: true,
                                    fillColor:Color(0xFF1e262c),
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'ProximaNova-Regular',
                                      fontSize: 18,
                                    )
                                ),
                                obscureText: true,
                                validator: (value) => Validator.validatePassword(password: value),
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
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                                    hintText: 'Vérification du mot de passe',
                                    filled: true,
                                    fillColor: Color(0xFF1e262c),
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'ProximaNova-Regular',
                                      fontSize: 18,
                                    ),
                                    suffixIconConstraints: BoxConstraints(
                                      maxHeight: 50,
                                      maxWidth: 50,
                                    )
                                ),
                                obscureText: true,
                                validator: (value) => Validator.validateConfirmPassword(password: passwordController.text, confirmPassword: value)
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
                                      if(_formKey.currentState!.validate()){
                                        BlocProvider.of<TrueUserBloc>(context).add(RegisterEvent(nameTextController.text, emailTextController.text, passwordController.text));
                                      }
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
          );
          },
        ),
      ),
    );
  }
}