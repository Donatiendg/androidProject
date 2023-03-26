import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../game_class.dart';

abstract class GameEvent{}

class FetchGamesEvent extends GameEvent{}

class InitGamesBDD extends GameEvent{}

class LoadGames extends GameEvent{}

class FindGames extends GameEvent{
  final TextEditingController searchController;
  FindGames(this.searchController);
}

abstract class GameState{}

class GameData extends GameState{
  final List<Game>? gameState;
  GameData(this.gameState);
}

class RefreshData extends GameState{}

class Loading extends GameState{}

class ErrorData extends GameState{
  final String error;
  ErrorData(this.error);
}

class GameBloc extends Bloc<GameEvent, GameState> {
  static const String steamChartsBaseUrl = 'https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/';
  static const String steamStoreBaseUrl = 'https://store.steampowered.com/api/appdetails?appids=';
  static const String steamStoreComments = 'https://store.steampowered.com/appreviews/';

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final List<Game> _game = [];

  GameBloc() : super(Loading()){
    on<InitGamesBDD>(_fetchGames);
    on<LoadGames>(_initGames);
    on<FindGames>(_findGames);
    add(LoadGames());
    add(InitGamesBDD());
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

      List<Map<String, dynamic>> commentData = [];

      for (var comment in theGame.comments) {
        if(comment != null) {
          commentData.add({
            'review': comment.review,
            'stars': comment.stars,
          });
        }
      }

      await db.collection("games").doc(gameRank.toString()).set({
          "id": gameId,
          "rank": gameRank,
          "name": theGame.name,
          "editor": theGame.editor,
          "price": theGame.price,
          "shortDesc": theGame.shortDesc,
          "desc": theGame.desc,
          "imgBack": theGame.backgroundImage,
          "imgHeader": theGame.frontImage,
          "imgScreen": theGame.screenImage,
          "comments": commentData,
        });
      }
    } else {
      throw Exception('Failed to fetch games from API');
    }
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
        final gameBackground = gameData['data']['background'];
        final gameHeaders = gameData['data']['header_image'];
        final gameEditor = gameData['data']['publishers'][0];

        final screenShots = gameData['data']['screenshots'];
        final List<String> gameScreenShot = [];

        for(final screenshot in screenShots){
          gameScreenShot.add(screenshot['path_full']);
        }

        List<Commentaires?> comments = await fetchComments(gameId);

        final Game game = Game(gameId, gamerank, gameName, gameEditor, gamePrice, gameShortDesc,
            gameDesc, gameBackground, gameHeaders, gameScreenShot, comments);

        return game;
      } else {
        throw Exception('Failed to fetch a game data from API');
      }
    }catch(e){
      throw Exception(e);
    }
  }

  Future<List<Commentaires?>> fetchComments(int gameId) async {
    try{
      final response = await http.get(Uri.parse('$steamStoreComments$gameId?json=1'));
      if (response.statusCode == 200) {
        final List<Commentaires?> comments = [];

        final data = jsonDecode(response.body) as Map<String, dynamic>;

        for(final comment in data['reviews']){
          comments.add(Commentaires(comment['review'], comment['voted_up'] == true ? 5 : 0));
        }
        return comments;
      } else {
        throw Exception('Failed to fetch a game data from API');
      }
    }catch(e){
      throw Exception(e);
    }
  }

  Future<void> _initGames(event, emit) async {
    emit(Loading());
    final games = await db.collection("games").get();

    for (var element in games.docs) {
      final el = element.data();
      List<String> screenshots = [];
      if(el["imgScreen"] != null){
        for(final screenshot in el["imgScreen"]){
          screenshots.add(screenshot);
        }
      }
      List<Commentaires> comments = [];
      if(el["comments"] != null){
        for(final comment in el["comments"]){
          comments.add(Commentaires(comment["review"], comment["stars"]));
        }
      }
      _game.add(Game(el["id"], el["rank"], el["name"], el["editor"],
          el["price"], el["shortDesc"], el["desc"], el["imgBack"], el["imgHeader"], screenshots, comments));
    }

    _game.sort((a,b) => a.rank.compareTo(b.rank));

    if(_game.isEmpty){
      emit(Loading());
      add(LoadGames());
    }else{
      emit(GameData(_game));
    }
  }

  Future<void> _findGames (event, emit) async{
    final List<Game> gameflitred = _game.where((game) =>
        game.name.toLowerCase().contains(event.searchController.text.toLowerCase())).toList();
    if(gameflitred.isNotEmpty){
      emit(GameData(gameflitred));
    }else{
      emit(ErrorData("Aucun jeux trouvé"));
    }
  }
}