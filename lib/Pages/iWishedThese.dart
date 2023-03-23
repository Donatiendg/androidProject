import 'package:eceee/Widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../Blocs/bloc_like_wish.dart';
import '../Blocs/bloc_user.dart';
import '../Widgets/game_card.dart';

class IWished extends StatelessWidget {
  const IWished({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider<GameListBloc>(
        create: (_) => GameListBloc(BlocProvider.of<UserBloc>(context).user!, false),
        child: BlocBuilder<GameListBloc, GameListState>(
          builder: (context, snapshot) {
            if (snapshot is GameListData) {
              return Scaffold(
                  backgroundColor: const Color(0xFF1A2025),
                  appBar: const CustomAppBar(
                      title: 'Mes likes', appBarId: 2, liked: false, whished: false),
                  body:Container(
                      height: screenHeight * 0.5,
                      width: screenWidth*0.9,
                      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      child: ListView.builder(
                          itemCount: snapshot.gameState?.length,
                          itemBuilder: (context, index) {
                            final game = snapshot.gameState?[index];
                            if(game != null) {
                              return (
                                  GameCard(game: game)
                              );
                            }
                            return null;
                          }
                      )
                  )
              );
            }else if(snapshot is LoadingList){
              return const Center(child: CircularProgressIndicator());
            } else{
              return Scaffold(
            backgroundColor: const Color(0xFF1A2025),
            appBar: const CustomAppBar(title: 'Ma liste de souhaits', appBarId: 2, liked: false, whished: false),
            body: Stack(
              children: <Widget> [
                SvgPicture.asset('assets/Images&SVG/Bg Pattern.svg',
                    width: 1080,
                    height: 1920,
                    fit: BoxFit.fill),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(child: ListView(
                        children: [

                          SizedBox(height: screenHeight * 0.3),

                          SvgPicture.asset(
                            'assets/Icones/empty_whishlist.svg',
                            width: 120,
                            height: 120,
                          ),

                          SizedBox(height: screenHeight * 0.10),

                          const Text(
                            'Vous n\'avez encore pas liké de contenu.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontFamily: 'GoogleSans-Bold'
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.02),

                          const Text(
                            'Cliquez sur l\'étoile pour en rajouter.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontFamily: 'GoogleSans-Bold'
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