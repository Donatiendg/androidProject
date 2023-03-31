import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Blocs/bloc_game_card.dart';
import '../Blocs/bloc_manager.dart';
import '../game_class.dart';

class GameCard extends StatefulWidget {
  final Game game;

  const GameCard({super.key, required this.game});

  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameBlocCard>(
      create: (_) => GameBlocCard(),
      child: BlocBuilder<GameBlocCard, GameCardState>(
        builder: (context, snapshot) {
          if (snapshot is GameCardLoading) {
            const Center(child: CircularProgressIndicator());
          }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: SizedBox(
                height: 100,
                child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(widget.game.backgroundImage, fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                            child: Container(
                              height: 90,
                                width: 100,
                                child: Image.network(widget.game.frontImage, width: 90, fit: BoxFit.cover)),
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.game.name.length >= 20
                                      ? widget.game.name.substring(0, 20) + "..."
                                      : widget.game.name,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'ProximaNova-Regular',
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  widget.game.editor.length >= 15
                                      ? "${widget.game.editor.substring(0, 15)}..."
                                      : widget.game.editor,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'ProximaNova-Regular',
                                    fontSize: 15,
                                  ),
                                ),
                                RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'ProximaNova-Regular',
                                      fontSize: 15,
                                    ),
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: 'Prix',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      const TextSpan(text: ' : '),
                                      TextSpan(
                                        text: widget.game.price.length >= 15
                                            ? "${widget.game.price.substring(0, 15)}..."
                                            : widget.game.price,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                              color: Color(0xFF636AF6),
                            ),
                            child: Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateColor.resolveWith(
                                            (states) => const Color(0xFF636AF6),
                                      ),
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<ManagerBloc>(context).add(GameDetailsPageEvent(widget.game));
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Center(
                                        child: Text(
                                          'En savoir\nplus',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'ProximaNova-Regular',
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ),
                          )
                        ],
                      ),
                  )
                ],
              )
              ),
            );
        }
      ),
    );
  }
}
