import 'package:eceee/Pages/register.dart';
import 'package:eceee/Widgets/CustomAppBar.dart';
import 'package:eceee/Widgets/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<int> fetchMostPlayedGames() async {
  final response = await http.get(Uri.parse('https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final appid = data['response']['ranks'][0]['appid'];
    return appid as int;
  } else {
    return 0;
  }
}

Future<String> fetchMostPlayedGamesImage() async {
  final response2 = await http.get(Uri.parse('https://store.steampowered.com/api/appdetails?appids=730'));
  if (response2.statusCode == 200) {
    final data = jsonDecode(response2.body);
    String MostPlayedGameImage = data['730']['success']['data']['name'];
    return MostPlayedGameImage;
  }else{
    return '';
  }
}




class AccueilPage extends StatelessWidget {
  const AccueilPage({Key? key}) : super(key: key);
  @override


  Widget build(BuildContext context) {


    print(fetchMostPlayedGames());

    Function nothin(){
      return nothin();
    }
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController searchTextController = TextEditingController();


    return Scaffold(
      backgroundColor: Color(0xFF1A2025),
      appBar: CustomAppBar(title: 'Accueil', leadingIconPath: '', firstActionIconPath: 'assets/Icones/like.svg', secondActionIconPath: '', appBarId: 1, liked: false, whished: false, ),
      body: Stack(
          children: <Widget> [
            SvgPicture.asset('assets/Images&SVG/Bg Pattern.svg',
                width: 1080,
                height: 1920,
                fit: BoxFit.fill),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: SearchBarWidget(controller: searchTextController,),
                  ),

                  Container(
                    height: screenHeight * 0.28,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.transparent,
                        )
                      )
                    ),
                    child: Stack(
                      children: [
                        Image.network('https://cdn.dlcompare.com/game_tetiere/upload/gameimage/file/95a1-god_of_war_4.jpeg'),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 10),
                          child: Column(
                            children: [
                              Expanded(child: Container()),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex:3,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('God of War',
                                        style: TextStyle(
                                            color: Colors.white,
                                          fontSize: 23,
                                          fontFamily: 'ProximaNova-Bold'
                                        ),),
                                        Text('Ultimate Edition',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 23,
                                              fontFamily: 'ProximaNova-Bold'
                                          ),),
                                        SizedBox(height: 10,),
                                        Text('Description...............................................',
                                          style: TextStyle(
                                            color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'ProximaNova-Bold'
                                          ),),
                                        SizedBox(height: 18),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateColor.resolveWith(
                                                  (states) => const Color(0xFF636AF6),
                                            ),
                                          ),
                                          onPressed: ()  {},
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                            child: const Text('En savoir plus',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'ProximaNova-Regular'
                                              ),),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Image.network('https://static-de.gamestop.de/images/products/256191/3max.jpg',
                                        width: 130,),
                                    ),
                                  ),

                              ],
                            ),
                    ]
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

            ),
          ]
      ),

    );
  }
}