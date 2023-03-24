import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../game_class.dart';

abstract class GameListEvent{}

class FetchGamesEvent extends GameListEvent{}

class LoadGames extends GameListEvent{}

class OnListen extends GameListEvent{}

abstract class GameListState{}

class GameListData extends GameListState{
  final List<Game>? gameState;
  GameListData(this.gameState);
}

class LoadingList extends GameListState{}

class NoData extends GameListState{}

class GameListBloc extends Bloc<GameListEvent, GameListState> {
  final User user;
  final bool isLike;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final databaseReference = FirebaseDatabase.instance.reference();

  GameListBloc(this.user, this.isLike) : super(LoadingList()){
    on<LoadGames>(_initListGames);
    on<OnListen>(_listenBDD);
    add(OnListen());
  }

  Future<void> _initListGames(event, emit) async {
    emit(LoadingList());
    List<Game> game = [];
    final games = await db.collection("games").get();

    await databaseReference.child('users').child(user.uid).once().then(
      (value) {
        if(value.snapshot.value != null){
          final data = value.snapshot.value as Map<dynamic, dynamic>;
          String jsonData = json.encode(data);
          Map<String, dynamic> userData = json.decode(jsonData);

          if(isLike){
            List<int> like = [];
            if(userData["likes"] != null){
              userData["likes"].forEach((doc) {
                int entier = doc;
                like.add(entier);
              });
            }
            for (var element in games.docs) {
              final el = element.data();
              List<String> screenshots = [];
              if(el["imgScreen"] != null){
                for(final screenshot in el["imgScreen"]){
                  screenshots.add(screenshot);
                }
              }
              List<Commentaires?> comments = [];
              if(el["comments"] != null){
                for(final comment in el["comments"]){
                  final String review = comment['review'];
                  final int stars = comment['stars'];
                  comments.add(Commentaires(review, stars));
                }
              }
              if(like.contains(el["id"])){
                game.add(Game(el["id"], el["rank"], el["name"], el["editor"],
                    el["price"], el["shortDesc"], el["desc"], el["imgBack"], el["imgHeader"], screenshots, comments));
              }
            }
          }else{
            List<int> wish = [];

            if(userData["wishlist"] != null){
              userData["wishlist"].forEach((doc) {
                int entier = doc;
                wish.add(entier);
              });
            }
            for (var element in games.docs) {
              final el = element.data();
              List<String> screenshots = [];
              if(el["imgScreen"] != null){
                for(final screenshot in el["imgScreen"]){
                  screenshots.add(screenshot);
                }
              }
              List<Commentaires?> comments = [];
              if(el["comments"] != null){
                for(final comment in el["comments"]){
                  final String review = comment['review'];
                  final int stars = comment['stars'];
                  comments.add(Commentaires(review, stars));
                }
              }
              if(wish.contains(el["id"])){
                game.add(Game(el["id"], el["rank"], el["name"], el["editor"],
                    el["price"], el["shortDesc"], el["desc"], el["imgBack"], el["imgHeader"], screenshots, comments));
              }
            }
          }
          emit(GameListData(game));
        }
      }
    ).catchError((e) => print(e.toString()));//em

    if(game.isEmpty){
      emit(NoData());
    }else{
      emit(GameListData(game));
    }
  }

  Future<void> _listenBDD (event, emit) async {
    final databaseReference = FirebaseDatabase.instance.reference();
    String id = user.uid;

    databaseReference.child('users/$id').onValue.listen(
          (event) {
        add(LoadGames());
      }
    );
    add(LoadGames());
  }
}