import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc_user.dart';
import '../game_class.dart';


class GameDetails extends StatelessWidget{

  bool liked = false;

  GameDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      future:  BlocProvider.of<UserBloc>(context).getGameDetails(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          Game game = snapshot.data as Game;
          return Scaffold(
              appBar: AppBar(
                title: Text(game.name),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        liked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                        size: 50,
                      ),
                      onPressed: () {
                        if(liked){
                          BlocProvider.of<UserBloc>(context).add(GameLikedEvent(game));
                        }else{
                          BlocProvider.of<UserBloc>(context).add(GameDislikedEvent(game));
                        }
                        if(liked) {
                          liked = false;
                        } else {
                          liked = true;
                        }
                        print("liked: $liked");
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      child: const Text('Wish'),
                      onPressed: () {
                        print("liked: $liked");
                      },
                    ),
                  ],
                ),
              ),
          );
        } else{
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}