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
}
