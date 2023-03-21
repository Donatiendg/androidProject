import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PasswordFields extends StatefulWidget {
  const PasswordFields({super.key});

  @override
  _PasswordFieldsState createState() => _PasswordFieldsState();
}

class _PasswordFieldsState extends State<PasswordFields> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _passwordsMatch = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'ProximaNova-Regular',
            fontSize: 18,
          ),
          controller: _passwordController,
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer un mot de passe';
            }
            return null;
          },
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
          controller: _confirmPasswordController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            hintText: 'Vérification du mot de passe',
            filled: true,
              errorText: _passwordsMatch ? null : "Mot de passe différent",
            fillColor: const Color(0xFF1e262c),
            hintStyle: const TextStyle(
              color: Colors.white,
              fontFamily: 'ProximaNova-Regular',
              fontSize: 18,
            ),
            suffixIcon: _passwordsMatch ? null : SvgPicture.asset('assets/Icones/warning.svg'),
            suffixIconConstraints: const BoxConstraints(
              maxHeight: 50,
              maxWidth: 50,
            )
          ),
          obscureText: true,
          onChanged: (value) {
            setState(() {
              _passwordsMatch = value == _passwordController.text;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer un mot de passe';
            }
            return null;
          },
        ),
      ],
    );
  }
}