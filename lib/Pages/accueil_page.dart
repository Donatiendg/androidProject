import 'package:eceee/Widgets/custom_app_bar.dart';
import 'package:eceee/Widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';

import '../game_class.dart';
import '../Widgets/game_card.dart';
import '../bloc_user.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({Key? key}) : super(key: key);
  @override


  Widget build(BuildContext context) {

    final UserBloc userBloc = UserBloc();

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController searchTextController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF1A2025),
      appBar: CustomAppBar(title: 'Accueil', leadingIconPath: '', firstActionIconPath: 'assets/Icones/like.svg', secondActionIconPath: '', appBarId: 1, liked: false, whished: false, ),
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

                  Container(
                    height: screenHeight * 0.28,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: Colors.transparent,
                            )
                        )
                    ),
                    child: Stack(
                      children: [
                        Image.network('https://cdn.dlcompare.com/game_tetiere/upload/gameimage/file/95a1-god_of_war_4.jpeg'),
                        Container(
                          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 10),
                          child: Column(
                              children: [
                                Expanded(child: Container()),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex:3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('God of War',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 23,
                                                fontFamily: 'ProximaNova-Bold'
                                            ),),
                                          const Text('Ultimate Edition',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 23,
                                                fontFamily: 'ProximaNova-Bold'
                                            ),),
                                          const SizedBox(height: 10,),
                                          const Text('Description...............................................',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontFamily: 'ProximaNova-Bold'
                                            ),),
                                          const SizedBox(height: 18),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateColor.resolveWith(
                                                    (states) => const Color(0xFF636AF6),
                                              ),
                                            ),
                                            onPressed: ()  {},
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                              child: Text('En savoir plus',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'ProximaNova-Regular'
                                                ),),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Image.network('https://static-de.gamestop.de/images/products/256191/3max.jpg',
                                          width: 130,),
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
                  Container(
                    height: screenHeight * 0.5,
                    width: screenWidth*0.9,
                    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: FutureBuilder<List<Game>>(
                    future: userBloc.initGames(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        List<Game> games = snapshot.data as List<Game>;
                        return ListView.builder(
                            itemCount: games.length,
                            itemBuilder: (context, index) {
                              final game = games[index];
                              return(
                                  GameCard(game: game)
                              );
                            }
                        );
                      }
                      else{
                        return const Center(child: CircularProgressIndicator());
                      }
                    }
                  )
                ),
              ]
            )
          ],
        ),
    );
  }
}