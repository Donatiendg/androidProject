import 'package:eceee/validator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Blocs/bloc_login.dart';
import '../Blocs/bloc_manager.dart';

class ForgottenPage extends StatelessWidget {
  ForgottenPage({Key? key}) : super(key: key);

  TextEditingController emailTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider<UserBloc>(
      create: (_) => UserBloc(),
      child: BlocListener<UserBloc, UserState>(
        listener: (BuildContext context, UserState state) {
          if(state is Success){
            BlocProvider.of<ManagerBloc>(context).add(LogInPageEvent());
          }else if (state is ErrorState){
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, snapshot) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                backgroundColor: Colors.grey[900],
                body: Form(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 80.0),
                        const Text(
                          'Mot de passe oublié',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                              fontFamily: 'GoogleSans-Bold'
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        const Text(
                          'Veuillez saisir votre email \n afin de réinitialiser votre mot de passe',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.265845,
                              color: Colors.white,
                              fontFamily: 'ProximaNova-Regular'
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: emailTextController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20),
                              hintText: 'E-mail',
                              filled: true,
                              fillColor: Color(0xFF1e262c),
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'ProximaNova-Regular',
                                fontSize: 18,
                              )
                          ),
                          validator: (value) =>
                              Validator.validateEmail(email: value),
                        ),
                        const SizedBox(height: 50.0),
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
                            onPressed: () async {
                              BlocProvider.of<UserBloc>(context).add(ForgottenUserEvent(emailTextController.text));
                            },
                            child: const Text('Renvoyer mon mot de passe',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'ProximaNova-Regular'
                              )),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
