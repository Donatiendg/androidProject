import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../game_class.dart';

abstract class ManagerEvent{}

class LogInPageEvent extends ManagerEvent{}

class RegisterPageEvent extends ManagerEvent{}

class ForgottenPageEvent extends ManagerEvent{}

class HomePageEvent extends ManagerEvent{
  final User? user;
  HomePageEvent(this.user);
}

class LikePageEvent extends ManagerEvent{}

class WishPageEvent extends ManagerEvent{}

class GameDetailsPageEvent extends ManagerEvent{
  final Game game;
  GameDetailsPageEvent(this.game);
}

abstract class MangerUser{}

class PageState extends MangerUser{
  final Interface userState;
  final User? user;
  PageState(this.userState, this.user);
}

class UserGameState extends MangerUser{
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
  likePage,
  wishPage,
}

class ManagerBloc extends Bloc<ManagerEvent,MangerUser> {

  Interface userState = Interface.connectionPage;
  User? user;

  ManagerBloc() : super(PageState(Interface.connectionPage, null)) {
    on<LogInPageEvent>(_logInPage);
    on<RegisterPageEvent>(_registerPage);
    on<ForgottenPageEvent>(_forgottenPage);
    on<HomePageEvent>(_homePage);
    on<GameDetailsPageEvent>(_gameDetailsPage);
    on<LikePageEvent>(_likePage);
    on<WishPageEvent>(_wishPage);
  }

  Future<void> _logInPage(event, emit) async {
    userState = Interface.connectionPage;
    emit(PageState(userState, null));
  }

  Future<void> _registerPage(event, emit) async {
    userState = Interface.registerPage;
    emit(PageState(userState, null));
  }

  Future<void> _forgottenPage(event, emit) async {
    userState = Interface.forgottenPage;
    emit(PageState(userState, null));
  }

  Future<void> _homePage(event, emit) async {
    userState = Interface.homePage;
    user = event.user;
    emit(PageState(userState, event.user));
  }

  Future<void> _gameDetailsPage(event, emit) async {
    userState = Interface.gameDetails;
    emit(UserGameState(userState, event.game));
  }

  Future<void> _likePage(event, emit) async {
    userState = Interface.likePage;
    emit(PageState(userState, null));
  }

  Future<void> _wishPage(event, emit) async {
    userState = Interface.wishPage;
    emit(PageState(userState, null));
  }
}