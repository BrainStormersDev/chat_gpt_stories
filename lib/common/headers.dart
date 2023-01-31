




const String OPEN_AI_KEY = "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";
// const String OPEN_AI_KEY = "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";
const String baseURL = "https://api.openai.com/v1";
String endPoint(String endPoint) => "$baseURL/$endPoint";





Map<String, String> headerBearerOption(String token) => {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

enum ApiState { loading, success, error, notFound }
