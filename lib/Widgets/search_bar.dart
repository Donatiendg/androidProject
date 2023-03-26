import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Blocs/bloc_game.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;

  const SearchBarWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.5),
        color: const Color(0xFF1e262c),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'ProximaNova-Regular',
                fontSize: 16,
              ),
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Rechercher un jeu...",
                border: InputBorder.none,
                  filled: true,
                  fillColor: Color(0xFF1e262c),
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'ProximaNova-Regular',
                    fontSize: 16,
                  )
              ),
              onChanged: (value) {
                BlocProvider.of<GameBloc>(context).add(FindGames(controller));
              }
            ),
          ),
          IconButton(
            onPressed: () {
              BlocProvider.of<GameBloc>(context).add(FindGames(controller));
            },
            icon: const Icon(Icons.search,
              size: 28,
              color: Color(0xFF636AF6)
            ),
          ),
        ],
      ),
    );
  }
}