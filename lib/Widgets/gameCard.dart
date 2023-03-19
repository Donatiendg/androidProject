import 'package:flutter/material.dart';

class GameCard extends StatefulWidget {
  final String gameName;
  final String editorName;
  final String backgroundImage;
  final double price;
  final String gameImage;

  GameCard({
    required this.gameName,
    required this.editorName,
    required this.backgroundImage,
    required this.price,
    required this.gameImage,
  });

  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.dstATop),
                child: Image.network(widget.backgroundImage, fit: BoxFit.fill,),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50)
            ),
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Image.network(widget.gameImage, width: 110),
                  ),

                  Container(
                    child: Expanded(
                      child: Column(
                        children: [
                          Text(widget.gameName),
                          Text(widget.editorName),
                          Text("Prix :" + widget.price.toString())
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                      color: Color(0xFF636AF6),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => const Color(0xFF636AF6),
                            ),
                          ),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
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
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
