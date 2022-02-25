Future<T> asyncMinTime<T>(
  Future<T> future, [
  int timeMillis = 1000,
]) async {
  final fetchTime = DateTime.now();
  final response = await future;

  // Delay loading false if fetch less than forceLoadMillis
  final doneTime = DateTime.now();
  final Duration diffDuration = doneTime.difference(fetchTime);
  final int diffMillis = diffDuration.inMilliseconds;

  if (diffMillis < timeMillis) {
    final delay = Duration(milliseconds: timeMillis - diffMillis);
    await Future.delayed(delay);
  }
  return response;
}
