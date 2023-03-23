import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../game_class.dart';

abstract class GameListEvent{}

class FetchGamesEvent extends GameListEvent{}

class LoadGames extends GameListEvent{}

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

  List<int> likes = [];
  List<int> whishes = [];

  GameListBloc(this.user, this.isLike) : super(LoadingList()){
    on<LoadGames>(_initListGames);
    add(LoadGames());
  }

  Future<void> _initListGames(event, emit) async {
    emit(LoadingList());

    final snapshot =  db.collection("users").doc(user.uid);
    await snapshot.get().then((DocumentSnapshot doc){
      final data = doc.data() as Map<String, dynamic>;
      data["likes"].forEach((doc) {
        int entier = doc;
        likes.add(entier);
      });
      data["wishlist"].forEach((doc) {
        int entier = doc;
        whishes.add(entier);
      });
      }, onError: (e) => emit(Error()),
    );

    final games = await db.collection("games").get();

    List<Game> game = [];

    if(isLike){
      for (var element in games.docs) {
        final el = element.data();
        if(likes.contains(el["id"])){
          game.add(Game(el["id"], el["rank"], el["name"], el["editor"],
              el["price"], el["shortDesc"], el["desc"], el["imgUrl"], el["imgUrl"]));
        }
      }
    }else{
      for (var element in games.docs) {
        final el = element.data();
        if(whishes.contains(el["id"])){
          game.add(Game(el["id"], el["rank"], el["name"], el["editor"],
              el["price"], el["shortDesc"], el["desc"], el["imgUrl"], el["imgUrl"]));
        }
      }
    }

    if(game.isEmpty){
      emit(NoData());
    }else{
      emit(GameListData(game));
    }
  }
}