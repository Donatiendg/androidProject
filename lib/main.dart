import 'package:eceee/Pages/accueil_page.dart';
import 'package:eceee/Pages/register.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Pages/game_details.dart';
import 'Blocs/bloc_user.dart';
import 'Pages/iLikedThese.dart';
import 'Pages/iWishedThese.dart';
import 'Pages/login_page.dart';
import 'Pages/forgotten.dart';

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
      child: BlocListener<UserBloc, StateUser>(
        listener: (BuildContext context, StateUser state) {
          if(state is UserState){
            if (state.userState == Interface.connectionPage) {
              _navigatorKey.currentState!.pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()),
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
              _navigatorKey.currentState!.pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const AccueilPage(),
                ),
              );
            }else if(state.userState == Interface.likePage){
              // Connexion
              _navigatorKey.currentState!.push(
                MaterialPageRoute(
                  builder: (context) => const ILiked(),
                ),
              );
            }else if(state.userState == Interface.wishPage){
              // Connexion
              _navigatorKey.currentState!.push(
                MaterialPageRoute(
                  builder: (context) => const IWished(),
                ),
              );
            }
          }else if(state is UserGameState){
            // Connexion
            _navigatorKey.currentState!.push(
              MaterialPageRoute(
                builder: (context) => GameDetails(game: state.game!),
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