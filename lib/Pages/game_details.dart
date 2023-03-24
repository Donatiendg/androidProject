import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';


import '../Blocs/bloc_game_details.dart';
import '../Blocs/bloc_user.dart';
import '../Widgets/review_box.dart';
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
  final PageController _controller = PageController(initialPage: 0);

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
            appBar: AppBar(
              title: const Text("Détail du jeu",
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'GoogleSans-Bold'
                ),),
              backgroundColor: const Color(0xFF1A2025),
              elevation: 10,
              leading: IconButton(
                icon: SvgPicture.asset('assets/Icones/back.svg') ,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              actions: [
                IconButton(
                  icon: snapshot.game.liked! ? SvgPicture.asset('assets/Icones/like_full.svg') : SvgPicture.asset('assets/Icones/like.svg'),
                  onPressed: () {
                    if(!snapshot.game.liked!){
                      BlocProvider.of<GameBlocDetails>(context).add(GameLikedEvent());
                    }else{
                      BlocProvider.of<GameBlocDetails>(context).add(GameDislikedEvent());
                    }
                  },
                ),
                IconButton(
                  icon: snapshot.game.wish! ? SvgPicture.asset('assets/Icones/whishlist_full.svg') : SvgPicture.asset('assets/Icones/whishlist.svg'),
                  onPressed: () {
                    if(!snapshot.game.wish!){
                      BlocProvider.of<GameBlocDetails>(context).add(GameWishedEvent());
                    }else{
                      BlocProvider.of<GameBlocDetails>(context).add(GameUnWishedEvent());
                    }
                  },
                ),
              ],
            ),
            backgroundColor: const Color(0xFF1A2025),
            body: Stack(
              children: [
                SvgPicture.asset('assets/Images&SVG/Bg Pattern.svg',
                    width: 1080,
                    height: 1920,
                    fit: BoxFit.fill),
                SingleChildScrollView(
                  child: Expanded(
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
                                child: PageView.builder(
                                  controller: _controller,
                                  itemCount: snapshot.game.screenImage.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Image.network(snapshot.game.screenImage[index]);
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 230, left: 20, right: 20, bottom: 10),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 130,
                                    width: double.infinity,
                                    child: Expanded(
                                      child: Image.network(
                                          snapshot.game.backgroundImage, fit: BoxFit.fill),
                                    ),
                                  ),
                                  SizedBox(
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
                                                  Text(snapshot.game.name, style: const TextStyle(color: Colors.white),),
                                                  Text(snapshot.game.editor, style: const TextStyle(color: Colors.white),)
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
                        const SizedBox(height: 15),
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
                                    backgroundColor: _bouton1Pressed ? const Color(0xFF636AF6) : MaterialStateColor.resolveWith(
                                          (states) => Colors.transparent,
                                    ),
                                    elevation: 0,
                                    side: const BorderSide(
                                        color: Color(0xFF636AF6), width: 2),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)), // Modifier le radius ici
                                    ),
                                    animationDuration: const Duration(milliseconds: 0),
                                  ),

                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12),
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
                                    backgroundColor: _bouton2Pressed ? const Color(0xFF636AF6) :MaterialStateColor.resolveWith(
                                          (states) => Colors.transparent,
                                    ),

                                    elevation: 0,
                                    side: const BorderSide(
                                        color: Color(0xFF636AF6), width: 2),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)), // Modifier le radius ici
                                    ),
                                    animationDuration: const Duration(milliseconds: 0),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    child: Text('AVIS'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),
                        if (_bouton1Pressed)(
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                                child: Html(
                                  data: snapshot.game.desc,
                                  style: {
                                    "body": Style(
                                      fontSize: FontSize(15),
                                      fontFamily: "ProximaNova-Regular",
                                      color: Colors.white,
                                    )
                                  }
                                )
                            )
                        )else
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                  itemCount: snapshot.game.comments.length,
                                  itemBuilder: (context, index) {
                                    final comment = snapshot.game.comments[index]!;
                                    return (
                                        ReviewBox(userName: 'visiteur',
                                            userComment: comment.review,
                                            userGrade: comment.stars)
                                    );
                                  }
                              ),
                            ),
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