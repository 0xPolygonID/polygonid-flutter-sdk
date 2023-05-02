class DownloadResponseDTO {
  final List<int> newBytes;
  final bool done;
  final bool errorOccurred;
  final String errorMessage;

  DownloadResponseDTO({
    required this.newBytes,
    this.done = false,
    this.errorOccurred = false,
    this.errorMessage = '',
  });
}
