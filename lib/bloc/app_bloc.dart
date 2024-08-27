import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_quest/api/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learn_quest/bloc/app_event.dart';
import 'package:learn_quest/bloc/app_state.dart';
import 'package:learn_quest/dataModels/coursesModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

// =================================================== sign-up class ===================================================
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());
    try {
      await signUpUser(
        firstName: event.firstName,
        lastName: event.lastName,
        username: event.username,
        email: event.email,
        password: event.password,
        isInstructor: false,
      );
      emit(SignUpSuccess());
    } catch (error) {
      if (error.toString().contains('User with email already exists')) {
        emit(SignUpFailure(
            error.toString(), 'User with this email already exist!'));
      } else {
        emit(SignUpFailure(
            error.toString(), 'Something wents wrong. Please try again'));
      }
    }
  }

  Future<void> signUpUser({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
    required bool isInstructor,
  }) async {
    final signUpUrl = Uri.parse(ApiEndpoints.fullUrl(ApiEndpoints.signUp));
    final loginUrl = Uri.parse(ApiEndpoints.fullUrl(ApiEndpoints.signIn));

    try {
      // Sign-up user
      final signUpResponse = await http.post(
        signUpUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode(<String, dynamic>{
          'first_name': firstName,
          'last_name': lastName,
          'username': username,
          'email': email,
          'password': password,
          'is_instructor': isInstructor,
        }),
      );

      // Login user
      final loginResponse = await http.post(
        loginUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'password': password,
        }),
      );

      // Get sensitive details
      final String? accessToken =
          json.decode(loginResponse.body)['access_token'];
      final String? tokenType = json.decode(loginResponse.body)['token_type'];

      if (signUpResponse.statusCode == 201 && loginResponse.statusCode == 200) {
        // Save user data to shared preferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userAccessToken', accessToken.toString());
        prefs.setString('accessTokenType', tokenType.toString());
        prefs.setString('userFirstName', firstName.toString());
        prefs.setString('userLastName', lastName.toString());
        prefs.setString('userEmail', email.toString());
        prefs.setString('userProfileChar', firstName[0].toUpperCase());
      } else if (signUpResponse.statusCode == 403) {
        final errorData = json.decode(signUpResponse.body);
        if (errorData['detail'] == 'User with email already exists') {
          throw Exception('User with email already exists');
        }
      } else {
        throw Exception(
            'Failed to sign up. Status code: ${signUpResponse.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }
}

// =================================================== login class ===================================================
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      await loginUser(
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccess());
    } catch (error) {
      if (error.toString().contains('Incorrect email or password')) {
        emit(LoginFailure(error.toString(), 'Incorrect email or password'));
      } else {
        emit(LoginFailure(
            error.toString(), 'Something wents wrong. Please try again'));
      }
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(ApiEndpoints.fullUrl(ApiEndpoints.signIn));

    try {
      // Login user
      final loginResponse = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'password': password,
        }),
      );

      // Get sensitive details
      final String? accessToken =
          json.decode(loginResponse.body)['access_token'];
      final String? tokenType = json.decode(loginResponse.body)['token_type'];

      // Get user's details
      final allUserDetailsResponse = await http.get(
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
        Uri.parse(
          ApiEndpoints.fullUrl(ApiEndpoints.allUsers),
        ),
      );
      final String? authUserFirstName =
          json.decode(allUserDetailsResponse.body)['first_name'];
      final String? authUserLastName =
          json.decode(allUserDetailsResponse.body)['last_name'];

      if (loginResponse.statusCode == 200 &&
          allUserDetailsResponse.statusCode == 200) {
        // Save user data to shared preferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userAccessToken', accessToken.toString());
        prefs.setString('accessTokenType', tokenType.toString());
        prefs.setString('userEmail', email.toString());
        prefs.setString('userFirstName', authUserFirstName.toString());
        prefs.setString('userLastName', authUserLastName.toString());
        prefs.setString('userProfileChar', authUserFirstName![0].toUpperCase());
      } else if (loginResponse.statusCode == 401) {
        final errorData = json.decode(loginResponse.body);

        if (errorData['detail'] == 'Incorrect email or password') {
          throw Exception('Incorrect email or password');
        }
      } else {
        throw Exception(
            'Failed to login. Status code: ${loginResponse.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}

// =================================================== Fetch courses ===================================================
class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesBloc() : super(InitialState()) {
    on<FetchCourses>((event, emit) async {
      emit(LoadingState());
      try {
        final courses = await fetchCoursesData();
        emit(SuccessState(courses));
      } catch (e) {
        if (e.toString().contains('Failed to load courses')) {
          emit(ErrorState(
              e.toString(), "Server failure. Please try again later"));
        } else {
          emit(ErrorState(e.toString(),
              "Maybe you're offline! Please check you internet/wifi"));
        }
      }
    });
  }

  Future<List<CoursesModel>> fetchCoursesData() async {
    try {
      final response = await http
          .get(Uri.parse(ApiEndpoints.fullUrl(ApiEndpoints.coursesData)));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData
            .map((courseJson) => CoursesModel.fromJson(courseJson))
            .toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
