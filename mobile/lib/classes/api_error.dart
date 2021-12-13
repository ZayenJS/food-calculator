class ApiError {
  String message;
  String? type;
  String? field;

  ApiError({required this.message, this.type, this.field});
}
