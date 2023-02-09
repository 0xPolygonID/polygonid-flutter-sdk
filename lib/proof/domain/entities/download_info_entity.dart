class DownloadInfo {
  final bool completed;
  final int contentLength;
  final int downloaded;

  DownloadInfo({
    required this.contentLength,
    required this.downloaded,
    this.completed = false,
  });
}
