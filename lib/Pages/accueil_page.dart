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
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          if(state is GameData){
            final games = state.gameState!.toList();
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
                  SingleChildScrollView(
                    child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: SearchBarWidget(controller: searchTextController,),
                          ),

                          Container(
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                        state.gameState![0].backgroundImage,
                                        fit: BoxFit.fill,
                                      )
                                    ),
                                  ],
                                ),
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
                                                  Text(state.gameState![0].name,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 23,
                                                        fontFamily: 'ProximaNova-Bold'
                                                    ),),
                                                  Text(state.gameState![0].editor,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 23,
                                                        fontFamily: 'ProximaNova-Bold'
                                                    ),),
                                                  const SizedBox(height: 10,),
                                                    SizedBox(
                                                      height: 50,
                                                      child: Text("${state.gameState![0].shortDesc.substring(0,100)}...",
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
                                                          BlocProvider.of<UserBloc>(context).add(GameDetailsPageEvent(state.gameState![0]));
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
                                                        child: Image.network(state.gameState![0].frontImage,
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
                          ),
                          Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: games.length,
                                  itemBuilder: (context, index) {
                                    final game = games[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: (GameCard(game: game)),
                                    );
                                  }
                              ),
                            ],
                          )
                            ]
                          ),
                  )
                ]
              )
            );
          }else if(state is ErrorData){
            return Column(
              children: [
                Expanded(
                    child: Container(
                      color: const Color(0xFF1A2025),
                      child: Column(
                        children: [
                          Text(state.error),
                          ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<GameBloc>(context).add(UpdateGames());
                              },
                              child: const Text("Cliquer pour recharger la page")
                          ),
                        ]
                      ),
                    )
                ),
              ],
            );
          }
          else{
            return Column(
              children: [
                Expanded(
                    child: Container(
                      color:const Color(0xFF1A2025),
                      child: const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF636AF6),
                          )
                      ),
                    )
                ),
              ],
            );
          }
        }
      ),
    );
  }
}