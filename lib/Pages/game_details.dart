import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Blocs/bloc_game_details.dart';
import '../Blocs/bloc_login.dart';
import '../Blocs/bloc_user.dart';
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

  @override
  Widget build(BuildContext context) {
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
          );
        }else{
          return const Center(child: CircularProgressIndicator());
        }
      }
      ),
      )
    );
  }
}