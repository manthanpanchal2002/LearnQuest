class ApiEndpoints{
  // Base url
  static const String baseUrl = "https://learnquest-backend.onrender.com/";

  // Authentication endpoints
  static const String signIn = "api/auth/login";
  static const String signUp = "api/auth/signup";
  static const String coursesData = "api/course?page=1";
  static const String allUsers = "api/auth/user";

  // Full url
  static String fullUrl(String endpoints){
    return baseUrl + endpoints;
  }

}