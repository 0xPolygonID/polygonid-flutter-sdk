enum DownloadInfoType { onDone, onError, onProgress }

abstract class DownloadInfo {
  final DownloadInfoType downloadInfoType;

  //TODO refactor to sealed class as soon as we update to dart 3
  const DownloadInfo._(this.downloadInfoType);

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
  }) : super._(DownloadInfoType.onDone);

  Map<String, dynamic> toJson() => {
        'downloadInfoType': downloadInfoType.name,
        'contentLength': contentLength,
        'downloaded': downloaded,
      };
}

class DownloadInfoOnError extends DownloadInfo {
  final String errorMessage;

  const DownloadInfoOnError({
    required this.errorMessage,
  }) : super._(DownloadInfoType.onError);

  Map<String, dynamic> toJson() => {
        'downloadInfoType': downloadInfoType.name,
        'errorMessage': errorMessage,
      };
}

class DownloadInfoOnProgress extends DownloadInfo {
  final int contentLength;
  final int downloaded;

  const DownloadInfoOnProgress({
    required this.contentLength,
    required this.downloaded,
  }) : super._(DownloadInfoType.onProgress);

  Map<String, dynamic> toJson() => {
        'downloadInfoType': downloadInfoType.name,
        'contentLength': contentLength,
        'downloaded': downloaded,
      };
}
