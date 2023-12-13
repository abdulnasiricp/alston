class UploadPhotoResponse {
  int success;
  String message;
  dynamic data;

  UploadPhotoResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UploadPhotoResponse.fromJson(Map<String, dynamic> json) {
    return UploadPhotoResponse(
      success: json['success'],
      message: json['message'],
      data: json[
          'data'], 
    );
  }
}
