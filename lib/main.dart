import 'package:eceee/Pages/accueil_page.dart';
import 'package:eceee/Pages/register.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Pages/game_details.dart';
import 'bloc_user.dart';
import 'Pages/login_page.dart';
import 'forgotten.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // initialize app binding
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (_) => UserBloc(),
      child: BlocListener<UserBloc, UserState>(
        listener: (BuildContext context, UserState state) {
          if (state.userState == Interface.connectionPage) {
            _navigatorKey.currentState!.pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );

            // Accueil
          } else if(state.userState == Interface.registerPage){
            // Connexion
            _navigatorKey.currentState!.push(
              MaterialPageRoute(
                builder: (context) => RegisterPage(),
              ),
            );
          }else if(state.userState == Interface.forgottenPage){
            // Connexion
            _navigatorKey.currentState!.push(
              MaterialPageRoute(
                builder: (context) => ForgottenPage(),
              ),
            );
          }else if(state.userState == Interface.homePage){
            // Connexion
            BlocProvider.of<UserBloc>(context).add(FetchGamesEvent());
            _navigatorKey.currentState!.pushReplacement(
              MaterialPageRoute(
                builder: (context) => const AccueilPage(),
              ),
            );
          }else if(state.userState == Interface.gameDetails){
            // Connexion
            _navigatorKey.currentState!.push(
              MaterialPageRoute(
                builder: (context) => GameDetails(),
              ),
            );
          }
        },
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoginPage(),
        ),
      ),
    );
  }
}