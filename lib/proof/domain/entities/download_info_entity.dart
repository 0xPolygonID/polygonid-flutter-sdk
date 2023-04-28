class DownloadInfo {
  final bool completed;
  final int contentLength;
  final int downloaded;
  final bool errorOccurred;
  final String errorMessage;

  DownloadInfo({
    required this.contentLength,
    required this.downloaded,
    this.completed = false,
    this.errorOccurred = false,
    this.errorMessage = '',
  });

  factory DownloadInfo.fromJson(Map<String, dynamic> json) {
    return DownloadInfo(
      contentLength: json['contentLength'],
      downloaded: json['downloaded'],
      completed: json['completed'],
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'contentLength': contentLength,
        'downloaded': downloaded,
        'completed': completed,
      };
}
