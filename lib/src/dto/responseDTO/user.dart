class UserResponse {
  Response? response;
  bool? state;

  UserResponse({
    this.response,
    this.state,
  });

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
        response: Response.fromMap(json["response"]),
        state: json["state"],
      );
}

class Response {
  int? id;
  String? error;
  int? state;

  Response({
    this.id,
    this.error,
    this.state,
  });

  factory Response.fromMap(Map<String, dynamic> json) => Response(
        id: json["id"],
        error: json["error"],
        state: json["state"],
      );
}
