sealed class LoadException implements Exception {
  const LoadException();
}

final class NetworkLoadException extends LoadException {
  const NetworkLoadException();
}

final class ServerLoadException extends LoadException {
  const ServerLoadException();
}