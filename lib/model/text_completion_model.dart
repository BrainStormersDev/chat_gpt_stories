//
//
//
// class TextCompletionModel {
//   final num created;
//   final List<TextCompletionData> choices;
//   TextCompletionModel({required this.created, required this.choices});
//
//   factory TextCompletionModel.fromJson(Map<String, dynamic> json) {
//     final textCompletionItems = json['choices'] as List;
//     List<TextCompletionData> choices = textCompletionItems
//         .map((singleItem) => TextCompletionData.fromJson(singleItem))
//         .toList();
//
//     return TextCompletionModel(
//       choices: choices,
//       created: json['created'],
//     );
//   }
// }
//
//
// class TextCompletionData{
//   final String text;
//   final num index;
//   final String finish_reason;
//
//   TextCompletionData({required this.text,required this.index,required this.finish_reason});
//
//
//   factory TextCompletionData.fromJson(Map<String,dynamic> json){
//
//     return TextCompletionData(
//       text: json['text'],
//       index: json['index'],
//       finish_reason: json['finish_reason'],
//     );
//   }
// }
// To parse this JSON data, do
//
//     final textCompletionModel = textCompletionModelFromJson(jsonString);

import 'dart:convert';

TextCompletionModel textCompletionModelFromJson(String str) => TextCompletionModel.fromJson(json.decode(str));

String textCompletionModelToJson(TextCompletionModel data) => json.encode(data.toJson());

class TextCompletionModel {
  String? id;
  String? object;
  int? created;
  String? model;
  List<Choice>? choices;
  Usage? usage;
  dynamic systemFingerprint;

  TextCompletionModel({
    this.id,
    this.object,
    this.created,
    this.model,
    this.choices,
    this.usage,
    this.systemFingerprint,
  });

  factory TextCompletionModel.fromJson(Map<String, dynamic> json) => TextCompletionModel(
    id: json["id"],
    object: json["object"],
    created: json["created"],
    model: json["model"],
    choices: json["choices"] == null ? [] : List<Choice>.from(json["choices"]!.map((x) => Choice.fromJson(x))),
    usage: json["usage"] == null ? null : Usage.fromJson(json["usage"]),
    systemFingerprint: json["system_fingerprint"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "created": created,
    "model": model,
    "choices": choices == null ? [] : List<dynamic>.from(choices!.map((x) => x.toJson())),
    "usage": usage?.toJson(),
    "system_fingerprint": systemFingerprint,
  };
}

class Choice {
  int? index;
  Message? message;
  dynamic logprobs;
  String? finishReason;

  Choice({
    this.index,
    this.message,
    this.logprobs,
    this.finishReason,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
    index: json["index"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    logprobs: json["logprobs"],
    finishReason: json["finish_reason"],
  );

  Map<String, dynamic> toJson() => {
    "index": index,
    "message": message?.toJson(),
    "logprobs": logprobs,
    "finish_reason": finishReason,
  };
}

class Message {
  String? role;
  String? title;
  String? content;

  Message({
    this.role,
    this.content,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    role: json["role"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "role": role,
    "content": content,
  };
}

class Usage {
  int? promptTokens;
  int? completionTokens;
  int? totalTokens;

  Usage({
    this.promptTokens,
    this.completionTokens,
    this.totalTokens,
  });

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
    promptTokens: json["prompt_tokens"],
    completionTokens: json["completion_tokens"],
    totalTokens: json["total_tokens"],
  );

  Map<String, dynamic> toJson() => {
    "prompt_tokens": promptTokens,
    "completion_tokens": completionTokens,
    "total_tokens": totalTokens,
  };
}
