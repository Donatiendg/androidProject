import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../Blocs/bloc_game_card.dart';
import '../Blocs/bloc_user.dart';
import '../game_class.dart';

class Review_box extends StatefulWidget {
  final String userName;
  final int userGrade;
  final String userComment;

  const Review_box({super.key,
    required this.userName,
    required this.userComment,
    required this.userGrade
  });

  @override
  _Review_boxState createState() => _Review_boxState();
}

class _Review_boxState extends State<Review_box> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFF1E262C), borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text(widget.userName, style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: '', decoration: TextDecoration.underline),),
                Expanded(child: Container()),
                for (int j = 5; j - widget.userGrade > 0; j--)
                  SvgPicture.asset(
                    'assets/Icones/star_empty.svg',
                    width: 15,
                    height: 15,
                  ),
                for (int i = 0; i < widget.userGrade; i++)
                  SvgPicture.asset(
                    'assets/Icones/star.svg',
                    width: 15,
                    height: 15,
                  ),
              ],
            ),
            SizedBox(height: 10,),
            Align(
                alignment: Alignment.topLeft,
                  child: Text(widget.userComment, style: TextStyle(color: Colors.white),)),

          ],
        ),
      ),
    );
  }
}
