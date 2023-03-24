import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../Blocs/bloc_user.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int appBarId;
  final bool liked;
  final bool whished;

  const CustomAppBar({super.key,
    required this.title,
    required this.appBarId,
    required this.liked,
    required this.whished,
  });

  @override
  Widget build(BuildContext context) {
    if (appBarId == 1){
      return AppBar(
        title: Text(title,
          style: const TextStyle(
              fontSize: 22,
              fontFamily: 'GoogleSans-Bold'
          ),),
        backgroundColor: const Color(0xFF1A2025),
        elevation: 6,
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/Icones/like.svg'),
            onPressed: () {
              BlocProvider.of<UserBloc>(context).add(LikePageEvent());
            },
          ),
          IconButton(
            icon: SvgPicture.asset('assets/Icones/whishlist.svg'),
            onPressed: () {
              BlocProvider.of<UserBloc>(context).add(WishPageEvent());
            },
          ),
        ],
      );
    }else if (appBarId == 2){
      return AppBar(
        title: Text(title,
          style: const TextStyle(
            fontSize: 22,
            fontFamily: 'GoogleSans-Bold'
          )
        ),
        backgroundColor: const Color(0xFF1A2025),
        elevation: 10,
        leading: IconButton(
          icon: SvgPicture.asset('assets/Icones/close.svg'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }else if (appBarId == 3){
      return AppBar(
        title: Text(title,
          style: const TextStyle(
              fontSize: 22,
              fontFamily: 'GoogleSans-Bold'
          ),),
        backgroundColor: const Color(0xFF1A2025),
        elevation: 10,
        leading: IconButton(
          icon: SvgPicture.asset('assets/Icones/back.svg') ,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: liked ? SvgPicture.asset('assets/Icones/like_full.svg') : SvgPicture.asset('assets/Icones/like.svg'),
            onPressed: () {

            },
          ),
          IconButton(
            icon: whished ? SvgPicture.asset('assets/Icones/whishlist_full.svg') : SvgPicture.asset('assets/Icones/whishlist.svg'),
            onPressed: () {
            },
          ),
        ],
      );
    }else{
      return AppBar();
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}