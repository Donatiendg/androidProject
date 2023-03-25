import 'package:eceee/Widgets/custom_app_bar.dart';
import 'package:eceee/Widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';

import '../Blocs/bloc_user.dart';
import '../Widgets/game_card.dart';
import '../Blocs/bloc_game.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({Key? key}) : super(key: key);
  @override


  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController searchTextController = TextEditingController();

    return BlocProvider<GameBloc>(
      create: (_) => GameBloc(),
      child: BlocListener<GameBloc, GameState>(
        listener: (BuildContext context, GameState state) {

      }, child: BlocBuilder<GameBloc, GameState>(
          builder: (context, snapshot) {
          if(snapshot is GameData){
            final games = snapshot.gameState!.toList();
            games.removeAt(0);
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: const Color(0xFF1A2025),
              appBar: AppBar(
                title: const Text("Accueil",
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'GoogleSans-Bold'
                  ),
                ),
                backgroundColor: const Color(0xFF1A2025),
                elevation: 6,
                actions: [
                  IconButton(
                    icon: SvgPicture.asset('assets/Icones/like.svg'),
                    onPressed: () {
                      BlocProvider.of<UserBloc>(context).add(LikePageEvent());
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset('assets/Icones/whishlist.svg'),
                    onPressed: () {
                      BlocProvider.of<UserBloc>(context).add(WishPageEvent());
                    },
                  ),
                ],
              ),
              body: Stack(
                children: <Widget> [
                  SvgPicture.asset('assets/Images&SVG/Bg Pattern.svg',
                      width: 1080,
                      height: 1920,
                      fit: BoxFit.fill),
                  Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: SearchBarWidget(controller: searchTextController,),
                        ),

                        SizedBox(
                            height: screenHeight * 0.8,
                            child: ListView.builder(
                                itemCount: games.length,
                                itemBuilder: (context, index) {
                                  final game = games[index];
                                  if (index == 0){
                                    return Container(
                                      height: screenHeight * 0.28,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                color: Colors.black54,
                                              )
                                          )
                                      ),
                                      child: Stack(
                                        children: [
                                          Expanded(child: Image.network(snapshot.gameState![0].backgroundImage, fit: BoxFit.fill,)),
                                          Container(
                                            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 10),
                                            child: Column(
                                                children: [
                                                  Expanded(child: Container()),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(snapshot.gameState![0].name,
                                                              style: const TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 23,
                                                                  fontFamily: 'ProximaNova-Bold'
                                                              ),),
                                                            Text(snapshot.gameState![0].editor,
                                                              style: const TextStyle(
                                                                  color: Colors.white,
                                                                  fontSize: 23,
                                                                  fontFamily: 'ProximaNova-Bold'
                                                              ),),
                                                            const SizedBox(height: 10,),
                                                              Container(
                                                                height: 50,
                                                                child: Text(snapshot.gameState![0].shortDesc.substring(0,100) + "...",
                                                                  style: const TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 14,
                                                                      fontFamily: 'ProximaNova-Bold'
                                                                  ),),
                                                              ),
                                                            Row(
                                                              children: [
                                                                ElevatedButton(
                                                                  style: ButtonStyle(
                                                                    backgroundColor: MaterialStateColor.resolveWith(
                                                                          (states) => const Color(0xFF636AF6),
                                                                    ),
                                                                  ),
                                                                  onPressed: ()  {
                                                                    BlocProvider.of<UserBloc>(context).add(GameDetailsPageEvent(snapshot.gameState![0]));
                                                                  },
                                                                  child: const Padding(
                                                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                                    child: Text('En savoir plus',
                                                                      style: TextStyle(
                                                                          fontSize: 18,
                                                                          fontFamily: 'ProximaNova-Regular'
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(child: Container()),
                                                                Align(
                                                                  alignment: Alignment.bottomRight,
                                                                  child: Image.network(snapshot.gameState![0].frontImage,
                                                                    width: 130,),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ]
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }else {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: (GameCard(game: game)),
                                    );
                                  }
                                }
                            )
                        )
                      ]
                  )
                ],
              ),
            );
          }else{
            return Expanded(
                child: Container(
                  color:const Color(0xFF1A2025),
                  child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF636AF6),
                      )
                  ),
                )
            );
          }
          }
        ),
      )
    );
  }
}