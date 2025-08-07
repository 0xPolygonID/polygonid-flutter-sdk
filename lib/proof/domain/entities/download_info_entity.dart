enum DownloadInfoType { onDone, onError, onProgress }

sealed class DownloadInfo {
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

  Map<String, dynamic> toJson() => {
        'contentLength': contentLength,
        'downloaded': downloaded,
        'downloadInfoType': 'onDone',
      };
}

class DownloadInfoOnError extends DownloadInfo {
  final String errorMessage;

  const DownloadInfoOnError({
    required this.errorMessage,
  }) : super._();

  Map<String, dynamic> toJson() => {
        'errorMessage': errorMessage,
        'downloadInfoType': 'onError',
      };
}

class DownloadInfoOnProgress extends DownloadInfo {
  final int contentLength;
  final int downloaded;

  const DownloadInfoOnProgress({
    required this.contentLength,
    required this.downloaded,
  }) : super._();

  Map<String, dynamic> toJson() => {
        'contentLength': contentLength,
        'downloaded': downloaded,
        'downloadInfoType': 'onProgress',
      };
}
