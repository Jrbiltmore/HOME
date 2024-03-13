import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// Events
abstract class SocialLoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GoogleLoginRequested extends SocialLoginEvent {}

class FacebookLoginRequested extends SocialLoginEvent {}

// States
abstract class SocialLoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SocialLoginInitial extends SocialLoginState {}

class SocialLoginLoading extends SocialLoginState {}

class SocialLoginSuccess extends SocialLoginState {
  final String token;
  SocialLoginSuccess({required this.token});

  @override
  List<Object?> get props => [token];
}

class SocialLoginFailure extends SocialLoginState {
  final String error;
  SocialLoginFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

// Bloc
class SocialLoginBloc extends Bloc<SocialLoginEvent, SocialLoginState> {
  SocialLoginBloc() : super(SocialLoginInitial()) {
    on<GoogleLoginRequested>(_onGoogleLoginRequested);
    on<FacebookLoginRequested>(_onFacebookLoginRequested);
  }

  Future<void> _onGoogleLoginRequested(GoogleLoginRequested event, Emitter<SocialLoginState> emit) async {
    try {
      emit(SocialLoginLoading());
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Typically, you would now authenticate the Google user with your backend, 
      // using googleUser.idToken or googleUser.authentication
      // For demonstration, assume a token is returned upon successful backend authentication
      emit(SocialLoginSuccess(token: "fake_google_token"));
    } catch (error) {
      emit(SocialLoginFailure(error: error.toString()));
    }
  }

  Future<void> _onFacebookLoginRequested(FacebookLoginRequested event, Emitter<SocialLoginState> emit) async {
    try {
      emit(SocialLoginLoading());
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        // Similar to Google, authenticate with your backend using accessToken.token
        emit(SocialLoginSuccess(token: "fake_facebook_token"));
      } else {
        emit(SocialLoginFailure(error: "Facebook login failed"));
      }
    } catch (error) {
      emit(SocialLoginFailure(error: error.toString()));
    }
  }
}