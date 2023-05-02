class DownloadResponseDTO {
  final int progress;
  final bool done;
  final bool errorOccurred;
  final String errorMessage;

  DownloadResponseDTO({
    required this.progress,
    this.done = false,
    this.errorOccurred = false,
    this.errorMessage = '',
  });
}
