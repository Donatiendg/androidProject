import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReviewBox extends StatefulWidget {
  final String userName;
  final int userGrade;
  final String userComment;

  const ReviewBox({super.key,
    required this.userName,
    required this.userComment,
    required this.userGrade
  });

  @override
  _ReviewBoxState createState() => _ReviewBoxState();
}

class _ReviewBoxState extends State<ReviewBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFF1E262C),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(widget.userName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: '',
                        decoration: TextDecoration.underline),
                  ),
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
              const SizedBox(height: 10,),
              Align(
                  alignment: Alignment.topLeft,
                    child: Text(
                      widget.userComment,
                      style: const TextStyle(
                          color: Colors.white
                      ),
                    )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
