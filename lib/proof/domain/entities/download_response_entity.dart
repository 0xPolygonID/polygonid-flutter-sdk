class DownloadResponseEntity {
  final List<int> newBytes;
  final bool done;
  final bool errorOccurred;
  final String errorMessage;

  DownloadResponseEntity({
    required this.newBytes,
    this.done = false,
    this.errorOccurred = false,
    this.errorMessage = '',
  });
}
