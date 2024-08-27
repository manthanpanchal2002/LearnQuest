// =================================================== sign-up ===================================================
abstract class SignUpEvent {}

class SignUpSubmitted extends SignUpEvent {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;
  final bool isInstructor;

  SignUpSubmitted({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password,
    required this.isInstructor,
  });
}

// =================================================== login ===================================================
abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted({required this.email, required this.password});
}

// =================================================== Fetch courses ===================================================
abstract class CoursesEvent{}

class FetchCourses extends CoursesEvent{}