
// const String kOPEN_AI_KEY = "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";
// const String OPEN_AI_KEY = "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";
const String baseURLOpen = "https://api.openai.com/v1";
String endPoint(String endPoint) => "$baseURLOpen/$endPoint";





Map<String, String> headerBearerOption(String token) => {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

enum ApiState { loading, success, error, notFound }
