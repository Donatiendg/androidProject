import 'package:eceee/Pages/register.dart';
import 'package:eceee/Widgets/custom_app_bar.dart';
import 'package:eceee/Widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Widgets/custom_app_bar.dart';

class iLiked extends StatelessWidget {
  const iLiked({Key? key}) : super(key: key);
  @override


  Widget build(BuildContext context) {

    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: Color(0xFF1A2025),
      appBar: CustomAppBar(title: 'Mes likes', leadingIconPath: '', firstActionIconPath: 'assets/Icones/close.svg', secondActionIconPath: '', appBarId: 1, liked: false, whished: false, ),
      body: Stack(
          children: <Widget> [
            SvgPicture.asset('assets/Images&SVG/Bg Pattern.svg',
                width: 1080,
                height: 1920,
                fit: BoxFit.fill),

            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(child: ListView(
                    children: [

                      SizedBox(height: screenHeight * 0.3),


                      SvgPicture.asset(
                    'assets/Icones/empty_likes.svg',
                    width: 120,
                    height: 120,
                  ),

                      SizedBox(height: screenHeight * 0.10),

                      const Text(
                        'Vous n\'avez pas liké de contenu.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontFamily: 'GoogleSans-Bold'
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      const Text(
                        'Cliquez sur le coeur pour en rajouter.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontFamily: 'GoogleSans-Bold'
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.015),

                    ],
                  )
                  ),
                ],
              ),
            ),

          ]
      ),

    );
  }
}