import 'package:eceee/Widgets/search_bar.dart';
import 'package:eceee/game_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';

import '../Blocs/bloc_manager.dart';
import '../Widgets/game_card.dart';
import '../Blocs/bloc_game.dart';

class AccueilPage extends StatelessWidget {
  AccueilPage({Key? key}) : super(key: key);

  TextEditingController searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider<GameBloc>(
        create: (_) => GameBloc(),
        child: BlocBuilder<GameBloc, GameState>(builder: (context, state) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: const Color(0xFF1A2025),
              appBar: AppBar(
                title: const Text(
                  "Accueil",
                  style: TextStyle(fontSize: 22, fontFamily: 'GoogleSans-Bold'),
                ),
                backgroundColor: const Color(0xFF1A2025),
                elevation: 6,
                actions: [
                  IconButton(
                    icon: SvgPicture.asset('assets/Icones/like.svg'),
                    onPressed: () {
                      BlocProvider.of<ManagerBloc>(context).add(LikePageEvent());
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset('assets/Icones/whishlist.svg'),
                    onPressed: () {
                      BlocProvider.of<ManagerBloc>(context).add(WishPageEvent());
                    },
                  ),
                ],
              ),
              body: Stack(children: <Widget>[
                SvgPicture.asset('assets/Images&SVG/Bg Pattern.svg',
                    width: 1080, height: 1920, fit: BoxFit.fill),
                SingleChildScrollView(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: SearchBarWidget(
                        controller: searchTextController,
                      ),
                    ),
                    if (state is GameData)
                      Column(
                        children: [
                          if (searchTextController.text.isEmpty)
                            (Container(
                              height: screenHeight * 0.28,
                              child: Stack(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Image.network(
                                        state.gameState![0].backgroundImage,
                                        fit: BoxFit.fill,
                                      )),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        bottom: 20,
                                        top: 10),
                                    child: Column(children: [
                                      Expanded(child: Container()),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  state.gameState![0].name,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 23,
                                                      fontFamily:
                                                          'ProximaNova-Bold'),
                                                ),
                                                Text(
                                                  state.gameState![0].editor,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 23,
                                                      fontFamily:
                                                          'ProximaNova-Bold'),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  height: 50,
                                                  child: Text(
                                                    "${state.gameState![0].shortDesc.substring(0, 100)}...",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'ProximaNova-Bold'),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateColor
                                                                .resolveWith(
                                                          (states) =>
                                                              const Color(
                                                                  0xFF636AF6),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                            ManagerBloc>(
                                                                context)
                                                            .add(GameDetailsPageEvent(
                                                                state.gameState![
                                                                    0]));
                                                      },
                                                      child: const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20,
                                                                vertical: 10),
                                                        child: Text(
                                                          'En savoir plus',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'ProximaNova-Regular'),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Container()),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Image.network(
                                                        state.gameState![0]
                                                            .frontImage,
                                                        width: 130,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  )
                                ],
                              ),
                            )),
                          Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: searchTextController.text.isEmpty
                                      ? state.gameState!.toList().length - 1
                                      : state.gameState!.toList().length,
                                  itemBuilder: (context, index) {
                                    final game = searchTextController
                                            .text.isEmpty
                                        ? state.gameState!.toList()[index + 1]
                                        : state.gameState!.toList()[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: (GameCard(game: game)),
                                    );
                                  }),
                            ],
                          )
                        ],
                      )
                    else if (state is ErrorData)
                      Container(
                        height: screenHeight,
                        width: screenWidth,
                        child: Stack(
                          children: [
                            Container(
                              color: Color(0xFF1A2025),
                            ),
                            SvgPicture.asset('assets/Images&SVG/Bg Pattern.svg',
                                width: 1080, height: 1920, fit: BoxFit.fill),
                            Center(
                                child: Column(
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  state.error,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                      fontSize: 30),
                                ),
                                SizedBox(height: 40),
                              ],
                            ))
                          ],
                        ),
                      )
                    else
                      Container(
                        height: screenHeight,
                        width: screenWidth,
                        child: Column(
                          children: [
                            Expanded(
                                child: Container(
                              color: const Color(0xFF1A2025),
                              child: const Center(
                                  child: CircularProgressIndicator(
                                color: Color(0xFF636AF6),
                              )),
                            )),
                          ],
                        ),
                      ),
                  ]),
                )
              ]));
        }));
  }
}
