abstract class StreamUseCase<Param, Result> {
  Stream<Result> execute({required Param param});
}

abstract class FutureUseCase<Param, Result> {
  Future<Result> execute({required Param param});
}
