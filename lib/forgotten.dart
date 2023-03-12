import 'package:eceee/logIn.dart';
import 'package:flutter/material.dart';

class ForgottenPage extends StatelessWidget {
  const ForgottenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre adresse e-mail';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50.0),
              ElevatedButton(
                onPressed: () {
                  //if (_formKey.currentState!.validate()) {
                  // Process login request here
                  //}
                },
                child: const Text('Renvoyer mon mot de passe'),
              ),

              const Expanded(child: Spacer()),

            ],
          ),
        ),
      ),
    );
  }
}
