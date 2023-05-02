abstract class DownloadInfo {
  //TODO refactor to sealed class as soon as we update to dart 3
  const DownloadInfo._();

  factory DownloadInfo.onDone({
    required int contentLength,
    required int downloaded,
  }) = DownloadInfoOnDone;

  factory DownloadInfo.onError({
    required String errorMessage,
  }) = DownloadInfoOnError;

  factory DownloadInfo.onProgress({
    required int contentLength,
    required int downloaded,
  }) = DownloadInfoOnProgress;
}

class DownloadInfoOnDone extends DownloadInfo {
  final int contentLength;
  final int downloaded;

  const DownloadInfoOnDone({
    required this.contentLength,
    required this.downloaded,
  }) : super._();
}

class DownloadInfoOnError extends DownloadInfo {
  final String errorMessage;

  const DownloadInfoOnError({
    required this.errorMessage,
  }) : super._();
}

class DownloadInfoOnProgress extends DownloadInfo {
  final int contentLength;
  final int downloaded;

  const DownloadInfoOnProgress({
    required this.contentLength,
    required this.downloaded,
  }) : super._();
}
