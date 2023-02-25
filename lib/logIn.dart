import 'package:eceee/register.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

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
                'Bienvenue !',
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
                'Veuillez vous connecter ou créer un nouveau compte pour utiliser l\'application',
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
              const SizedBox(height: 16.0),
              TextFormField(
                textAlign: TextAlign.center,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Mot de passe',
                  filled: true,
                  fillColor: Colors.grey,
                  hintStyle: TextStyle(
                    color: Colors.white,
                  )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre mot de passe';
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
                child: const Text('Se connecter'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
                child: const Text('Créer un nouveau compte'),
              ),
              const Expanded(child: Spacer()),
              GestureDetector(
                onTap: () {
                  // Handle forgot password here
                },
                child: const Text(
                  'Mot de passe oublié',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white60,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
