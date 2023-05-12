class DownloadResponseDTO {
  final int progress;
  final int total;
  final bool done;
  final bool errorOccurred;
  final String errorMessage;

  DownloadResponseDTO({
    required this.progress,
    required this.total,
    this.done = false,
    this.errorOccurred = false,
    this.errorMessage = '',
  });
}
