import 'package:eceee/Widgets/custom_app_bar.dart';
import 'package:eceee/Widgets/game_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../Blocs/bloc_manager.dart';
import '../Blocs/bloc_like_wish.dart';

class ILiked extends StatelessWidget{
  const ILiked({super.key});

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider<GameListBloc>(
        create: (_) => GameListBloc(BlocProvider.of<ManagerBloc>(context).user!, true),
         child: BlocBuilder<GameListBloc, GameListState>(
             builder: (context, snapshot) {
                if (snapshot is GameListData) {
                  return Scaffold(
                    backgroundColor: const Color(0xFF1A2025),
                    appBar: const CustomAppBar(title: 'Mes likes', appBarId: 2, liked: false, whished: false),
                    body: Container(
                      width: screenWidth*0.9,
                      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      child: ListView.builder(
                          itemCount: snapshot.gameState?.length,
                          itemBuilder: (context, index) {
                            final game = snapshot.gameState![index];
                            return (GameCard(game: game));
                          }
                      )
                    )
                  );
                }else if(snapshot is LoadingList){
                  return const Center(child: CircularProgressIndicator());
                } else{
                  return Scaffold(
                    backgroundColor: const Color(0xFF1A2025),
                    appBar: const CustomAppBar(
                        title: 'Mes likes', appBarId: 2, liked: false, whished: false),
                    body: Stack(
                        children: <Widget>[
                          SvgPicture.asset('assets/Images&SVG/Bg Pattern.svg',
                              width: 1080,
                              height: 1920,
                              fit: BoxFit.fill),

                          Container(
                            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                    child: ListView(
                                  children: [
                                    SizedBox(height: screenHeight * 0.3),

                                    SvgPicture.asset(
                                      'assets/Icones/empty_likes.svg',
                                      width: 120,
                                      height: 120,
                                    ),

                                    SizedBox(height: screenHeight * 0.10),

                                    const Text(
                                      'Vous n\'avez pas liké de contenu.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                          fontFamily: 'ProximaNova-Regular'
                                      ),
                                    ),

                                    SizedBox(height: screenHeight * 0.02),

                                    const Text(
                                      'Cliquez sur le coeur pour en rajouter.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                          fontFamily: 'ProximaNova-Regular'
                                      ),
                                    ),

                                    SizedBox(height: screenHeight * 0.015),
                                  ],
                                )
                                ),
                              ],
                            ),
                          ),

                        ]
                    ),
                  );
                }
            }
         )
    );
  }
}