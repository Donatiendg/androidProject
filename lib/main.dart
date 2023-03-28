import 'package:eceee/Pages/accueil_page.dart';
import 'package:eceee/Pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Pages/game_details_page.dart';
import 'Blocs/bloc_manager.dart';
import 'Pages/like_page.dart';
import 'Pages/wish_page.dart';
import 'Pages/login_page.dart';
import 'Pages/forgotten_page.dart';

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
    return BlocProvider<ManagerBloc>(
      create: (_) => ManagerBloc(),
      child: BlocListener<ManagerBloc, MangerUser>(
        listener: (BuildContext context, MangerUser state) {
          if(state is PageState){
            if (state.userState == Interface.connectionPage) {
              _navigatorKey.currentState!.pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            }
            else if(state.userState == Interface.registerPage){
              _navigatorKey.currentState!.push(
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                ),
              );
            }
            else if(state.userState == Interface.forgottenPage){
              _navigatorKey.currentState!.push(
                MaterialPageRoute(
                  builder: (context) => ForgottenPage(),
                ),
              );
            }
            else if(state.userState == Interface.homePage){
              _navigatorKey.currentState!.pushReplacement(
                MaterialPageRoute(
                  builder: (context) => AccueilPage(),
                ),
              );
            }
            else if(state.userState == Interface.likePage){
              _navigatorKey.currentState!.push(
                MaterialPageRoute(
                  builder: (context) => ILiked(),
                ),
              );
            }
            else if(state.userState == Interface.wishPage){
              _navigatorKey.currentState!.push(
                MaterialPageRoute(
                  builder: (context) => const IWished(),
                ),
              );
            }
          }else if(state is UserGameState){
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