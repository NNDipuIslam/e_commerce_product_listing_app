
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}
class OfflineFailure extends Failure {
  const OfflineFailure(String message) : super(message);
}
