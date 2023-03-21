import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiManager {
  static const String steamChartsBaseUrl = 'https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/';
  static const String steamStoreBaseUrl = 'https://store.steampowered.com/api/appdetails?appids=';
  static Map<int, Game> games = {};

  static Future<void> fetchGames() async {
    final response = await http.get(Uri.parse(steamChartsBaseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);


      final gamesList = data['response']['ranks'];

      for (final game in gamesList) {
        final gameId = game['appid'] as int;
        await fetchGameDetails(gameId);

      }
    } else {
      throw Exception('Failed to fetch games from API');
    }
  }

  static Future<void> fetchGameDetails(int gameId) async {
    try{
      final response = await http.get(Uri.parse('$steamStoreBaseUrl$gameId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if(data != null){
          final gameData = data[gameId.toString()] as Map<String, dynamic>;
          final gameName = gameData['data']['name'] as String;
          final gamePrice = gameData['data']['price_overview'] != null ? gameData['data']['price_overview']['final_formatted'] as String : 'Free to play';
          final gameShortDesc = gameData['data']['short_description'] as String;
          final gameDesc = gameData['data']['detailed_description'] as String;
          final gameImgUrl = gameData['data']['header_image'] as String;
          final game = Game(1,0,gameName, gamePrice, gameShortDesc, gameDesc, gameImgUrl);
          games[gameId] = game;
          print(game);
        }
      } else {
        throw Exception('Failed to fetch game data from API');
      }
    }catch(e){
      print(e);
    }
  }
}

class Game {
  final String name;
  final String price;
  final String shortDesc;
  final String desc;
  final String imgUrl;
  final int id;
  final int rank;

  Game(this.id, this.rank, this.name, this.price, this.shortDesc, this.desc, this.imgUrl);

  @override
  String toString() {
    return 'Game{name: $name, id: $id, rank: $rank, price: $price, imageUrl: $imgUrl}';
  }
}