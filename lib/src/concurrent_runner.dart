import 'dart:async';

typedef Future<T> ConcurrentAction<T>();

class ConcurrentRunner<T> {
  final int _limit;
  final List<ConcurrentAction<T>> actions;

  int _currentActions = 0;

  ConcurrentRunner(
    int limit,
    List<ConcurrentAction<T>> actions,
  )   : _limit = limit > actions.length ? actions.length : limit,
        this.actions = List.from(actions.reversed);

  Future<List<T>> run() {
    final completer = Completer<List<T>>();

    _run(completer, List(actions.length));

    return completer.future;
  }

  void _run(Completer<List<T>> completer, List<T> results) {
    if (completer.isCompleted) return;
    if (actions.isEmpty && _currentActions == 0)
      return completer.complete(results.reversed.toList());

    for (; _currentActions < _limit && actions.isNotEmpty; _currentActions++) {
      _callAction().then((result) {
        results[result.key] = result.value;
        _currentActions--;
        _run(completer, results);
      }).catchError((error) {
        if (!completer.isCompleted) completer.completeError(error);
      });
    }
  }

  Future<MapEntry<int, T>> _callAction() {
    final action = actions.removeLast();
    final index = actions.length;

    return action().then((result) => MapEntry(index, result));
  }
}
