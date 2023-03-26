import 'package:eceee/Widgets/custom_app_bar.dart';
import 'package:eceee/Widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';

import '../Blocs/bloc_manager.dart';
import '../game_class.dart';
import '../Widgets/game_card.dart';


class InfoGamePresentation1 extends StatefulWidget {

  const InfoGamePresentation1({
    super.key,
  });

  @override
  _InfoGamePresentation1State createState() => _InfoGamePresentation1State();
}

class _InfoGamePresentation1State extends State<InfoGamePresentation1> {
  @override

  bool _bouton1Pressed = true;
  bool _bouton2Pressed = false;
  Widget build(BuildContext context) {

    final ManagerBloc userBloc = ManagerBloc();

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController searchTextController = TextEditingController();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Détail du jeu',
        appBarId: 3,
        liked: false,
        whished: false,
      ),
      backgroundColor: const Color(0xFF1A2025),
      body: Stack(
        children: [
          SvgPicture.asset('assets/Images&SVG/Bg Pattern.svg',
              width: 1080,
              height: 1920,
              fit: BoxFit.fill),
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        color: Colors.black,
                        width: double.infinity,
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Image.network('https://sp-ao.shortpixel.ai/client/to_auto,q_glossy,ret_img,w_1024,h_576/https://www.suomiesports.fi/wp-content/uploads/2020/11/csgo_kuva2-1024x576.jpg'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 230, left: 20, right: 20, bottom: 10),
                        child: Stack(
                          children: [
                            Container(
                              height: 130,
                              width: double.infinity,
                              child: Expanded(
                                child: Image.network(
                                    'https://img.nrj.fr/FbDNfFYC51G4Bd8lOBk0fFkrt5A=/0x450/smart/medias%2Fnrjgames%2F2018%2F12%2Fcs-go-comment-etre-performant.jpeg', fit: BoxFit.fill),
                              ),
                            ),
                            Container(
                              height: 130,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Container(
                                      color: Colors.red,
                                      child: Image.network(
                                          'https://pic.clubic.com/v1/images/1779144/raw.webp?fit=smartCrop&width=1332&height=850&hash=46e44f77fe89721a168045fa72199f3f1b587243'),
                                      width: 80,
                                      height: 100,
                                    ),
                                  ),
                                  Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('name', style: TextStyle(color: Colors.white),),
                                            Text('editor', style: TextStyle(color: Colors.white),)
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _bouton1Pressed = true;
                                _bouton2Pressed = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _bouton1Pressed ? Color(0xFF636AF6) : MaterialStateColor.resolveWith(
                                    (states) => Colors.transparent,
                              ),
                              elevation: 0,
                                side: BorderSide(
                                    color: Color(0xFF636AF6), width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)), // Modifier le radius ici
                              ),
                              animationDuration: Duration(milliseconds: 0),
                            ),

                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text('DESCRIPTION'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _bouton1Pressed = false;
                                _bouton2Pressed = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _bouton2Pressed ? Color(0xFF636AF6) :MaterialStateColor.resolveWith(
                                    (states) => Colors.transparent,
                              ),

                              elevation: 0,
                              side: BorderSide(
                                  color: Color(0xFF636AF6), width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)), // Modifier le radius ici
                              ),
                              animationDuration: Duration(milliseconds: 0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text('AVIS'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  if (_bouton1Pressed)(
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                        child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi. Proin porttitor, orci nec nonummy molestie, enim est eleifend mi, non fermentum diam nisl sit amet erat. Duis semper. Duis arcu massa, scelerisque vitae, consequat in, pretium a, enim. Pellentesque congue. Ut in risus volutpat libero pharetra tempor. Cras vestibulum bibendum augue. Praesent egestas leo in pede. Praesent blandit odio eu enim. Pellentesque sed dui ut augue blandit sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aliquam nibh. Mauris ac mauris sed pede pellentesque fermentum. Maecenas adipiscing ante non diam sodales hendrerit.", style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'ProximaNova-Regular'),)
                      )
                  )else(
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                    child: Text("AVIS", style: TextStyle(color: Colors.white, fontSize: 40),),
                  )
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
}
}
