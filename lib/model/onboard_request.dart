class OnboardRequest {
  final String? verificationReference;
  final String? userReference;
  final String? locale;
  final String? callbackUrl;

  OnboardRequest(
      {this.verificationReference,
      this.userReference,
      this.locale,
      this.callbackUrl});

  /// Creates an instance from the given json
  ///
  /// @param [Map<String, dynamic>] json
  /// @returns [OnboardRequest]
  factory OnboardRequest.fromJson(Map<String, dynamic> json) {
    return OnboardRequest(
      verificationReference: json['verificationReference'],
      userReference: json['userReference'],
      locale: json['locale'],
      callbackUrl: json['callbackUrl'],
    );
  }

  Map<String, String> toJson() => {
        'verificationReference': verificationReference.toString(),
        'userReference': userReference.toString(),
        'locale': locale.toString(),
        'callbackUrl': callbackUrl.toString(),
      };
}
