import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../game_class.dart';

abstract class GameDetailsEvent{}

class LoadingDetailsEvent extends GameDetailsEvent{}

class GameInitEvent extends GameDetailsEvent{}

class GameLikedEvent extends GameDetailsEvent{}

class GameDislikedEvent extends GameDetailsEvent{}

abstract class GameDetailsState{}

class Data extends GameDetailsState{
  late final Game game;
  Data(this.game);
}

class GameLoading extends GameDetailsState{}

class GameLiked extends GameDetailsState{}

class GameDisliked extends GameDetailsState{}

class Success extends GameDetailsState{}

class GameBlocDetails extends Bloc<GameDetailsEvent, GameDetailsState> {

  Game _game;
  final User user;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<int> likes = [];
  List<int> wishlist = [];

  GameBlocDetails(this._game, this.user) : super(GameLoading()){
    on<LoadingDetailsEvent>(_loading);
    on<GameInitEvent>(_gameInit);
    on<GameLikedEvent>(_gameLiked);
    on<GameDislikedEvent>(_gameDisliked);
    add(GameInitEvent());
  }

  Future<void> _loading(event, emit) async {
    emit(GameLoading());
  }

  Future<void> _gameInit(event, emit) async {
    emit(GameLoading());
    final snapshot =  db.collection("users").doc(user.uid);
    await snapshot.get().then((DocumentSnapshot doc){
      final data = doc.data() as Map<String, dynamic>;
      data["likes"].forEach((doc) {
        int entier = doc;
        likes.add(entier);
      });
      data["wishlist"].forEach((doc) {
        int entier = doc;
        wishlist.add(entier);
      });

      bool like = likes.contains(_game.id);
      bool wish = likes.contains(_game.id);
      _game = Game(_game.id, _game.rank, _game.name, _game.editor, _game.price,
          _game.shortDesc, _game.desc, _game.backgroundImage, _game.frontImage,
          liked: like, wish: wish);

      emit(Data(_game));
    },
      onError: (e) => emit(Error()),
    );
  }

  Future<void> _gameLiked(event, emit) async {
    likes.add(_game.id);
    await db.collection("users").doc(user.uid).set({
      "ID": user.email,
      "wishlist": wishlist,
      "likes": likes,
    });
    _game.liked = true;
    emit(Data(_game));
  }

  Future<void> _gameDisliked(event, emit) async {
    likes.remove(_game.id);
    await db.collection("users").doc(user.uid).set({
      "ID": user.email,
      "wishlist": wishlist,
      "likes": likes,
    });
    _game.liked = false;
    emit(Data(_game));
  }
}