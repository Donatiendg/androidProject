import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;

  const SearchBarWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.5),
        color: Color(0xFF1e262c),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'ProximaNova-Regular',
                fontSize: 16,
              ),
              controller: controller,
              decoration: InputDecoration(
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
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search,
            size: 28,
            color: Color(0xFF636AF6)),
          ),
        ],
      ),
    );
  }
}