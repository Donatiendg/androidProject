import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../game_class.dart';

abstract class GameDetailsEvent{}

class LoadingDetailsEvent extends GameDetailsEvent{}

class GameInitEvent extends GameDetailsEvent{}

class GameLikedEvent extends GameDetailsEvent{}

class GameDislikedEvent extends GameDetailsEvent{}

class GameWishedEvent extends GameDetailsEvent{}

class GameUnWishedEvent extends GameDetailsEvent{}

abstract class GameDetailsState{}

class Data extends GameDetailsState{
  late final Game game;
  Data(this.game);
}

class GameLoading extends GameDetailsState{}

class GameLiked extends GameDetailsState{}

class GameDisliked extends GameDetailsState{}

class SuccessUpdate extends GameDetailsState{}

class DetailsError extends GameDetailsState{
  final String error;
  DetailsError(this.error);
}

class GameBlocDetails extends Bloc<GameDetailsEvent, GameDetailsState> {

  Game _game;
  final User user;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final databaseReference = FirebaseDatabase.instance.reference();

  List<int> likes = [];
  List<int> wishlist = [];

  GameBlocDetails(this._game, this.user) : super(GameLoading()){
    on<LoadingDetailsEvent>(_loading);
    on<GameInitEvent>(_gameInit);
    on<GameLikedEvent>(_gameLiked);
    on<GameDislikedEvent>(_gameDisliked);
    on<GameWishedEvent>(_gameWished);
    on<GameUnWishedEvent>(_gameUnWished);
    add(GameInitEvent());
  }

  Future<void> _loading(event, emit) async {
    emit(GameLoading());
  }

  Future<void> _gameInit(event, emit) async {
    emit(GameLoading());
    await databaseReference.child('users').child(user.uid).once().then(
            (value) {
              if(value.snapshot.value != null){
                final data = value.snapshot.value as Map<dynamic, dynamic>;
                String jsonData = json.encode(data);
                Map<String, dynamic> userData = json.decode(jsonData);
                if(userData["likes"] != null){
                  userData["likes"].forEach((doc) {
                  int entier = doc;
                  likes.add(entier);
                  });
                }
                if(userData["wishlist"] != null){
                  userData["wishlist"].forEach((doc) {
                    int entier = doc;
                    wishlist.add(entier);
                  });
                }

                bool like = likes.contains(_game.id);
                bool wish = wishlist.contains(_game.id);

                _game = Game(_game.id, _game.rank, _game.name, _game.editor, _game.price,
                    _game.shortDesc, _game.desc, _game.backgroundImage, _game.frontImage,
                    liked: like, wish: wish);

                emit(Data(_game));
              }else{
                _game = Game(_game.id, _game.rank, _game.name, _game.editor, _game.price,
                    _game.shortDesc, _game.desc, _game.backgroundImage, _game.frontImage,
                    liked: false, wish: false);

                emit(Data(_game));
              }
        }
    ).catchError((e) => print(e.toString()));//emit(DetailsError(e.toString())));
  }

  Future<void> _gameLiked(event, emit) async {
    likes.add(_game.id);

    await databaseReference.child('users').child(user.uid).set({
      "ID": user.email,
      "wishlist": wishlist,
      "likes": likes,
    });
    _game.liked = true;
    emit(SuccessUpdate());
    emit(Data(_game));
  }

  Future<void> _gameDisliked(event, emit) async {
    likes.remove(_game.id);

    await databaseReference.child('users').child(user.uid).set({
      "ID": user.email,
      "wishlist": wishlist,
      "likes": likes,
    });

    _game.liked = false;
    emit(SuccessUpdate());
    emit(Data(_game));
  }

  Future<void> _gameWished(event, emit) async {
    wishlist.add(_game.id);

    await databaseReference.child('users').child(user.uid).set({
      "ID": user.email,
      "wishlist": wishlist,
      "likes": likes,
    });
    _game.wish = true;
    emit(SuccessUpdate());
    emit(Data(_game));
  }

  Future<void> _gameUnWished(event, emit) async {
    wishlist.remove(_game.id);

    await databaseReference.child('users').child(user.uid).set({
      "ID": user.email,
      "wishlist": wishlist,
      "likes": likes,
    });

    _game.wish = false;
    emit(SuccessUpdate());
    emit(Data(_game));
  }
}