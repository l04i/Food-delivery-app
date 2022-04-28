

class ResponseModel {
  bool? _isSuccess;
  String? _message;

  ResponseModel({
    required isSuccess,
    required message,
  }){
   _isSuccess = isSuccess;
   _message= message;
  }

  bool get isSuccess => _isSuccess!;
  String get message => _message!;

 

  factory ResponseModel.fromJson(Map<String, dynamic> map) {
    return ResponseModel(
      isSuccess: map['isSuccess'],
      message: map['message'],
    );
  }

}