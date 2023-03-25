import 'package:eceee/Widgets/review_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Blocs/bloc_user.dart';
import '../game_class.dart';

class Test extends StatefulWidget {


  const Test({super.key,
  });

  @override
  _TestState createState() => _TestState();
}



class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          children: [
            SizedBox(height: 200,),
            ReviewBox(userName: 'Pablo', userComment: 'Sah le jeu est nul', userGrade: 4,)

          ],
        ),
      ),
    );
  }
}
