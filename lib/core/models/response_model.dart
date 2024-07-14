import 'package:equatable/equatable.dart';

class ResponseModel<T> extends Equatable {
  final String status;
  final String code;
  final String message;
  final String? oauthToken;
  final T? list;

  const ResponseModel({
    required this.status,
    required this.message,
    this.oauthToken,
    this.list,
    required this.code,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      status: json['status'],
      message: json['message'],
      oauthToken: json['oauthToken'],
      code: json['code'],
      list: json['list'] ?? [],
    );
  }

  @override
  List<Object> get props => [
        status,
        message,
        code,
      ];
}
