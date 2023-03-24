import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';


import '../Blocs/bloc_game_details.dart';
import '../Blocs/bloc_login.dart';
import '../Blocs/bloc_user.dart';
import '../Widgets/custom_app_bar.dart';
import '../game_class.dart';



class GameDetails extends StatefulWidget {
  final Game game;

  const GameDetails({super.key,
    required this.game,
  });

  @override
  _GameDetailsState createState() => _GameDetailsState();
}

class _GameDetailsState extends State<GameDetails>{

  bool _bouton1Pressed = true;
  bool _bouton2Pressed = false;


  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider<GameBlocDetails>(
      create: (_) => GameBlocDetails(widget.game, BlocProvider.of<UserBloc>(context).user!),
        child: BlocListener<GameBlocDetails, GameDetailsState>(
        listener: (BuildContext context, GameDetailsState state) {
          if(state is SuccessUpdate){

          }else if (state is DetailsError){
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
    }, child: BlocBuilder<GameBlocDetails, GameDetailsState>(
      builder: (context, snapshot) {
        if(snapshot is Data){
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Détail du jeu',
              appBarId: 3,
              liked: false,
              whished: false,
            ),
            backgroundColor: const Color(0xFF1A2025),
            body: Stack(
              children: [
                SvgPicture.asset('assets/Images&SVG/Bg Pattern.svg',
                    width: 1080,
                    height: 1920,
                    fit: BoxFit.fill),
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              color: Colors.black,
                              width: double.infinity,
                              height: 300,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Image.network(snapshot.game.frontImage),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 230, left: 20, right: 20, bottom: 10),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 130,
                                    width: double.infinity,
                                    child: Expanded(
                                      child: Image.network(
                                          snapshot.game.backgroundImage, fit: BoxFit.fill),
                                    ),
                                  ),
                                  Container(
                                    height: 130,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Container(
                                            color: Colors.red,
                                            width: 80,
                                            height: 100,
                                            child: Image.network(
                                                snapshot.game.frontImage),
                                          ),
                                        ),
                                        Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(snapshot.game.name, style: TextStyle(color: Colors.white),),
                                                  Text(snapshot.game.editor, style: TextStyle(color: Colors.white),)
                                                ],
                                              ),
                                            ))
                                      ],
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _bouton1Pressed = true;
                                      _bouton2Pressed = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _bouton1Pressed ? Color(0xFF636AF6) : MaterialStateColor.resolveWith(
                                          (states) => Colors.transparent,
                                    ),
                                    elevation: 0,
                                    side: BorderSide(
                                        color: Color(0xFF636AF6), width: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)), // Modifier le radius ici
                                    ),
                                    animationDuration: Duration(milliseconds: 0),
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    child: Text('DESCRIPTION'),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _bouton1Pressed = false;
                                      _bouton2Pressed = true;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _bouton2Pressed ? Color(0xFF636AF6) :MaterialStateColor.resolveWith(
                                          (states) => Colors.transparent,
                                    ),

                                    elevation: 0,
                                    side: BorderSide(
                                        color: Color(0xFF636AF6), width: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)), // Modifier le radius ici
                                    ),
                                    animationDuration: Duration(milliseconds: 0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    child: Text('AVIS'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        if (_bouton1Pressed)(
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                                child: Text(snapshot.game.desc, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'ProximaNova-Regular'),)
                            )
                        )else(
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                              child: Text("AVIS", style: TextStyle(color: Colors.white, fontSize: 40),),
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );/*Scaffold(
            appBar: AppBar(
              title: Text(snapshot.game.name),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      snapshot.game.liked! ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                      size: 50,
                    ),
                    onPressed: () {
                      if(!snapshot.game.liked!){
                        BlocProvider.of<GameBlocDetails>(context).add(GameLikedEvent());
                      }else{
                        BlocProvider.of<GameBlocDetails>(context).add(GameDislikedEvent());
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text('Wish'),
                    onPressed: () {
                    },
                  ),
                ],
              ),
            ),
          );*/
        }else{
          return const Center(child: CircularProgressIndicator());
        }
      }
      ),
      )
    );
  }
}