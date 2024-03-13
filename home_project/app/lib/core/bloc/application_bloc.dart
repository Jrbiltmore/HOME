import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class ApplicationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class ApplicationState extends Equatable {
  @override
  List<Object> get props => [];
}

class ApplicationInitialState extends ApplicationState {}

class ApplicationLoadingState extends ApplicationState {}

class ApplicationLoadedState extends ApplicationState {
  final String data;
  ApplicationLoadedState({required this.data});

  @override
  List<Object> get props => [data];
}

class ApplicationErrorState extends ApplicationState {
  final String message;
  ApplicationErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(ApplicationInitialState()) {
    on<ApplicationEvent>((event, emit) {
      // TODO: Implement event handling
    });
  }
}