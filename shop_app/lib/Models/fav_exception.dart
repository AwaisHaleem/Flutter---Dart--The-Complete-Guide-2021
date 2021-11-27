class favEception implements Exception {
  final String message;

  favEception({required this.message});

  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}
