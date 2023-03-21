import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_bloc/flutter_bloc.dart';

import 'backend.dart';

abstract class GameEvent{}

class GameInitEvent extends GameEvent{}

class GameState{
  late final List<Game>? gameState;
  GameState(this.gameState);
}

class GameBloc extends Bloc<GameEvent, GameState> {
  static const String steamChartsBaseUrl = 'https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/';
  static const String steamStoreBaseUrl = 'https://store.steampowered.com/api/appdetails?appids=';

  List<Game> games = [];

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  GameBloc() : super(GameState(null)) {
    on<GameInitEvent>(fetchGames);
  }

  Future<void> fetchGames(event, emit) async {
    final response = await http.get(Uri.parse(steamChartsBaseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final gamesList = data['response']['ranks'];

      for (final game in gamesList) {
        final gameId = game['appid'] as int;

        Game? theGame = await fetchGameDetails(gameId);
        /*games.add(theGame);
        try {
          await db.collection("games").doc(gameId.toString()).set({
            "name": theGame.name,
            "price": theGame.price,
            "shortDesc": theGame.shortDesc,
            "desc": theGame.desc,
            "imgUrl": theGame.imgUrl
          });
          emit(GameState(games));
        } catch (e) {
          print("Une erreur est survenue lors de l'enregistrement. Veuillez réessayer plus tard : $e");
        }*/
      }
    } else {
      throw Exception('Failed to fetch games from API');
    }
  }

  Future<Game?> fetchGameDetails(int gameId) async {
    try{
      final response = await http.get(Uri.parse('$steamStoreBaseUrl$gameId'));
      if (response.statusCode == 200) {

        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final gameData = data[gameId.toString()] as Map<String, dynamic>;
        final gameName = gameData['data']['name'] as String;
        final gamePrice = gameData['data']['price_overview'] != null ? gameData['data']['price_overview']['final_formatted'] as String : 'Free to play';
        final gameShortDesc = gameData['data']['short_description'] as String;
        final gameDesc = gameData['data']['detailed_description'] as String;
        final gameImgUrl = gameData['data']['header_image'] as String;
        //final game = Game(gameName, gamePrice, gameShortDesc, gameDesc, gameImgUrl);

        //games.add(game);
        //print(game);
        //return game;
      } else {
        throw Exception('Failed to fetch game data from API');
      }
    }catch(e){
      throw Exception(e);
    }
  }
}