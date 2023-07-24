class HabitoResponse<Data> {
  Data? data;
  int statusCode;
  String? message;
  String? error;

  bool get hasError => error != null || message != null;

  HabitoResponse({
    required this.statusCode,
    this.data,
    this.message,
    this.error,
  });
}
