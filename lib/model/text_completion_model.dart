


class TextCompletionModel {
  final num created;
  final List<TextCompletionData> choices;




  // {
  // "error": {
  // "message": "Incorrect API key provided: sk-cYSKi***************************************Pjaz. You can find your API key at https://platform.openai.com/account/api-keys.",
  // "type": "invalid_request_error",
  // "param": null,
  // "code": "invalid_api_key"
  // }
  // }

  TextCompletionModel({required this.created, required this.choices});

  factory TextCompletionModel.fromJson(Map<String, dynamic> json) {
    final textCompletionItems = json['choices'] as List;
    List<TextCompletionData> choices = textCompletionItems
        .map((singleItem) => TextCompletionData.fromJson(singleItem))
        .toList();

    return TextCompletionModel(
      choices: choices,
      created: json['created'],
    );
  }
}


class TextCompletionData{
  final String text;
  final num index;
  final String finish_reason;

  TextCompletionData({required this.text,required this.index,required this.finish_reason});


  factory TextCompletionData.fromJson(Map<String,dynamic> json){

    return TextCompletionData(
      text: json['text'],
      index: json['index'],
      finish_reason: json['finish_reason'],
    );
  }
}