import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String leadingIconPath;
  final String firstActionIconPath;
  final String secondActionIconPath;
  final int appBarId;
  final bool liked;
  final bool whished;

  CustomAppBar({
    required this.title,
    required this.leadingIconPath,
    required this.firstActionIconPath,
    required this.secondActionIconPath,
    required this.appBarId,
    required this.liked,
    required this.whished,

  });

  @override
  Widget build(BuildContext context) {
    if (appBarId == 1){
      return AppBar(
        title: Text(title,
          style: TextStyle(
              fontSize: 22,
              fontFamily: 'GoogleSans-Bold'
          ),),
        backgroundColor: Color(0xFF1A2025),
        elevation: 6,
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/Icones/like.svg'),
            onPressed: null,
          ),
          IconButton(
            icon: SvgPicture.asset('assets/Icones/whishlist.svg'),
            onPressed: null,
          ),
        ],
      );
    }else if (appBarId == 2){
      return AppBar(
        title: Text(title,
        style: TextStyle(
          fontSize: 22,
          fontFamily: 'GoogleSans-Bold'
        ),),
        backgroundColor: Color(0xFF1A2025),
        elevation: 10,
        leading: IconButton(
          icon: SvgPicture.asset('assets/Icones/close.svg'),
          onPressed: null,
        ),
      );
    }else if (appBarId == 3){
      return AppBar(
        title: Text(title,
          style: TextStyle(
              fontSize: 22,
              fontFamily: 'GoogleSans-Bold'
          ),),
        backgroundColor: Color(0xFF1A2025),
        elevation: 10,
        leading: IconButton(
          icon: SvgPicture.asset('assets/Icones/back.svg') ,
          onPressed: null,
        ),
        actions: [
          IconButton(
            icon: liked ? SvgPicture.asset('assets/Icones/like_full.svg') : SvgPicture.asset('assets/Icones/like.svg'),
            onPressed: null,
          ),
          IconButton(
            icon: whished ? SvgPicture.asset('assets/Icones/whishlist_full.svg') : SvgPicture.asset('assets/Icones/whishlist.svg'),
            onPressed: null,
          ),
        ],
      );
    }else{
      return AppBar();
    }

  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}