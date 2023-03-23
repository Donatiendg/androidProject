import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../game_class.dart';

abstract class UserEvent{}

class RegisterPageEvent extends UserEvent{}

class ForgottenPageEvent extends UserEvent{}

class HomePageEvent extends UserEvent{
  final User? user;
  HomePageEvent(this.user);
}

class GameDetailsPageEvent extends UserEvent{
  final Game game;
  GameDetailsPageEvent(this.game);
}

abstract class StateUser{}

class UserState extends StateUser{
  final Interface userState;
  final User? user;
  UserState(this.userState, this.user);
}

class UserGameState extends StateUser{
  final Interface userState;
  final Game? game;
  UserGameState(this.userState, this.game);
}

enum Interface{
  connectionPage,
  registerPage,
  forgottenPage,
  homePage,
  gameDetails,
}

class UserBloc extends Bloc<UserEvent,StateUser> {

  Interface userState = Interface.connectionPage;
  User? user;

  UserBloc() : super(UserState(Interface.connectionPage, null)) {
    on<RegisterPageEvent>(_registerPage);
    on<ForgottenPageEvent>(_forgottenPage);
    on<HomePageEvent>(_homePage);
    on<GameDetailsPageEvent>(_gameDetailsPage);
  }

  Future<void> _registerPage(event, emit) async {
    userState = Interface.registerPage;
    emit(UserState(userState, null));
  }

  Future<void> _forgottenPage(event, emit) async {
    userState = Interface.forgottenPage;
    emit(UserState(userState, null));
  }

  Future<void> _homePage(event, emit) async {
    userState = Interface.homePage;
    user = event.user;
    emit(UserState(userState, event.user));
  }

  Future<void> _gameDetailsPage(event, emit) async {
    userState = Interface.gameDetails;
    emit(UserGameState(userState, event.game));
  }
}