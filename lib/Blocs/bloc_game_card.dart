import 'package:flutter_bloc/flutter_bloc.dart';

import '../game_class.dart';

class GameCardEvent{
  final Game game;
  GameCardEvent(this.game);
}

abstract class GameCardState{}

class GameCardLoading extends GameCardState{}

class Loading extends GameCardState{}

class GameBlocCard extends Bloc<GameCardEvent, GameCardState> {

  GameBlocCard() : super(GameCardLoading());
}