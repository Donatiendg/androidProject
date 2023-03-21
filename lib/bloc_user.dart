import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'game_class.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class UserEvent{}

class ConnectionUserEvent extends UserEvent{
  final String mail;
  final String password;

  ConnectionUserEvent(this.mail, this.password);
}

class RegisterUserEvent extends UserEvent{
  final String name;
  final String mail;
  final String password;

  RegisterUserEvent(this.name, this.mail, this.password);
}

class DeconectionUserEvent extends UserEvent{}

class ForgottenUserEvent extends UserEvent{
  final String mail;

  ForgottenUserEvent(this.mail);
}

class RegisterPageEvent extends UserEvent{}

class ForgottenPageEvent extends UserEvent{}

class HomePageEvent extends UserEvent{}

class FetchGamesEvent extends UserEvent{}

class InitGamesEvent extends UserEvent{}

class GameDetailsPageEvent extends UserEvent{
  final Game game;

  GameDetailsPageEvent(this.game);
}

class GameLikedEvent extends UserEvent{
  final Game game;

  GameLikedEvent(this.game);
}

class GameDislikedEvent extends UserEvent{
  final Game game;

  GameDislikedEvent(this.game);
}

class UserState{
  late final Interface userState;
  UserState(this.userState);
}

enum Interface{
  connectionPage,
  registerPage,
  forgottenPage,
  homePage,
  gameDetails,
}

class UserBloc extends Bloc<UserEvent,UserState> {

  final String steamChartsBaseUrl = 'https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/';
  final String steamStoreBaseUrl = 'https://store.steampowered.com/api/appdetails?appids=';

  Interface userState = Interface.connectionPage;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<int> likes = [];
  List<int> wishlist = [];
  late final Game game;

  UserBloc() : super(UserState(Interface.connectionPage)) {
    on<ConnectionUserEvent>(_connectionUser);
    on<RegisterUserEvent>(_registerUser);
    on<DeconectionUserEvent>(_deconectionUser);
    on<ForgottenUserEvent>(_forgottenUser);
    on<RegisterPageEvent>(_registerPage);
    on<ForgottenPageEvent>(_forgottenPage);
    on<HomePageEvent>(_homePage);
    on<FetchGamesEvent>(_fetchGames);
    on<GameDetailsPageEvent>(_gameDetailsPage);
    on<GameLikedEvent>(_gameLiked);
    on<GameDislikedEvent>(_gameDisliked);
  }

  Future<void> _connectionUser(event, emit) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: event.mail,
        password: event.password,
      );
      final DocumentSnapshot snapshot = await db.collection("users").doc(auth.currentUser?.uid).get();
      final snapshotData = snapshot.data() as Map<String, dynamic>;

      final bufferlikes = snapshotData['likes'] as List<dynamic>;
      final bufferwhishes = snapshotData['wishlist'] as List<dynamic>;
      likes = bufferlikes.map((item) => item is int ? item : int.parse(item)).toList();
      wishlist = bufferwhishes.map((item) => item is int ? item : int.parse(item)).toList();

      userState = Interface.homePage;
      emit(UserState(userState));
    } catch (e) {
      throw Exception("Une erreur est survenue lors de l'authentification. Veuillez réessayer plus tard. $e");
    }
  }

  Future<void> _registerUser(event, emit) async {
    try {
      final UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: event.mail,
        password: event.password,
      );
      await db.collection("users").doc(userCredential.user?.uid).set({
        "ID": userCredential.user?.email,
        "wishlist": [],
        "likes": [],
      });
      userState = Interface.connectionPage;
      emit(UserState(userState));
    } catch (e) {
      throw Exception("Une erreur est survenue lors de l'enregistrement. Veuillez réessayer plus tard : $e");
    }
  }

  Future<void> _deconectionUser(event, emit) async {
    auth.signOut();
    userState = Interface.connectionPage;
    emit(UserState(userState));
  }

  Future<void> _forgottenUser(event, emit) async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.sendPasswordResetEmail(email: event.mail);
    } catch (e) {
      throw Exception("Une erreur est survenue lors de l'envoie du mail. Veuillez réessayer plus tard.");
    }
    userState = Interface.connectionPage;
    emit(UserState(userState));
  }

  Future<void> _registerPage(event, emit) async {
    userState = Interface.registerPage;
    emit(UserState(userState));
  }

  Future<void> _forgottenPage(event, emit) async {
    userState = Interface.forgottenPage;
    emit(UserState(userState));
  }

  Future<void> _homePage(event, emit) async {
    userState = Interface.homePage;
    emit(UserState(userState));
  }

  Future<void> _fetchGames(event, emit) async {
    final response = await http.get(Uri.parse(steamChartsBaseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final gamesList = data['response']['ranks'];

      for (final game in gamesList) {
        final gameId = game['appid'] as int;
        final gameRank = game['rank'] as int;


        Game theGame = await fetchGameDetails(gameId, gameRank);
        if(theGame != null){
          await db.collection("games").doc(gameRank.toString()).set({
            "id": gameId,
            "rank": gameRank,
            "name": theGame.name,
            "editor": theGame.editor,
            "price": theGame.price,
            "shortDesc": theGame.shortDesc,
            "desc": theGame.desc,
            "imgUrl": theGame.backgroundImage
          });
        }
      }
    } else {
      throw Exception('Failed to fetch games from API');
    }
  }

  Future<void> _gameDetailsPage(event, emit) async {

    bool like = likes.contains(event.game.id);
    bool wishe = wishlist.contains(event.game.id);

    game = Game(event.game.id, event.game.rank, event.game.name, event.game.editor, event.game.price,
        event.game.shortDesc, event.game.desc, event.game.backgroundImage, event.game.frontImage,
        liked: like, wish: wishe);

    userState = Interface.gameDetails;
    emit(UserState(userState));
  }

  Future<void> _gameLiked(event, emit) async {
    likes.add(event.game.id);
    await db.collection("users").doc(auth.currentUser?.uid).set({
      "ID": auth.currentUser?.email,
      "wishlist": wishlist,
      "likes": likes,
    });
  }

  Future<void> _gameDisliked(event, emit) async {
    likes.remove(event.game.id);
    await db.collection("users").doc(auth.currentUser?.uid).set({
      "ID": auth.currentUser?.email,
      "wishlist": wishlist,
      "likes": likes,
    });
  }

  Future<Game> getGameDetails() async {
    Game buffer = game;
    bool like = false;
    return game;
  }

  Future<Game> fetchGameDetails(int gameId, int gamerank) async {
    try{
      final response = await http.get(Uri.parse('$steamStoreBaseUrl$gameId'));
      if (response.statusCode == 200) {

        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final gameData = data[gameId.toString()] as Map<String, dynamic>;
        final gameName = gameData['data']['name'];
        final gamePrice = gameData['data']['price_overview'] != null ? gameData['data']['price_overview']['final_formatted'] as String : 'Free to play';
        final gameShortDesc = gameData['data']['short_description'];
        final gameDesc = gameData['data']['detailed_description'];
        final gameImgUrl = gameData['data']['background'];
        final gameEditor = gameData['data']['publishers'][0];

        final Game game = Game(gameId, gamerank, gameName, gameEditor, gamePrice, gameShortDesc, gameDesc, gameImgUrl, gameImgUrl);

        return game;
      } else {
        throw Exception('Failed to fetch a game data from API');
      }
    }catch(e){
      throw Exception('Failed to fetch a game data from API $e');
    }
  }

  Future<List<Game>> initGames() async {

    final games = await db.collection("games").get();

    List<Game> game = [];

    games.docs.forEach((element) {
      final el = element.data();
      game.add(Game(el["id"], el["rank"], el["name"], el["editor"],el["price"], el["shortDesc"], el["desc"], el["imgUrl"], el["imgUrl"]));
    });

    return game;
  }
}