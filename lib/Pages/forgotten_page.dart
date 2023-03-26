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
    return BlocProvider<TrueUserBloc>(
      create: (_) => TrueUserBloc(),
      child: BlocListener<TrueUserBloc, TrueUserState>(
        listener: (BuildContext context, TrueUserState state) {
          if(state is Success){
            BlocProvider.of<ManagerBloc>(context).add(LogInPageEvent());
          }else if (state is ErrorState){
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<TrueUserBloc, TrueUserState>(
          builder: (context, snapshot) {
            return Scaffold(
              backgroundColor: Colors.grey[900],
              body: Form(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 80.0),
                      const Text(
                        'Mot de passe oublié',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'GoogleSans'
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      const Text(
                        'Veuillez saisir votre email',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontFamily: 'Proxima'
                        ),
                      ),
                      const Text(
                        'afin de réinitialiser votre mot de passe',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontFamily: 'Proxima'
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: emailTextController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            hintText: 'E-mail',
                            filled: true,
                            fillColor: Colors.grey,
                            hintStyle: TextStyle(
                              color: Colors.white,
                            )
                        ),
                        validator: (value) =>
                            Validator.validateEmail(email: value),
                      ),
                      const SizedBox(height: 50.0),
                      ElevatedButton(
                        onPressed: () async {
                          BlocProvider.of<TrueUserBloc>(context).add(ForgottenUserEvent(emailTextController.text));
                        },
                        child: const Text('Renvoyer mon mot de passe'),
                      ),
                      const Spacer(),
                    ],
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
