class OnboardResponse {
  final String? timestamp;
  final String? url;

  OnboardResponse({this.timestamp, this.url});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [OnboardResponse]
  factory OnboardResponse.fromJson(Map<String, dynamic> json) {
    return OnboardResponse(
      timestamp: json['timestamp'],
      url: json['url'],
    );
  }

  Map<String, String> toJson() => {
        'timestamp': timestamp.toString(),
        'url': url.toString(),
      };
}
