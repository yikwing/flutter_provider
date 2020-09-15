enum Status {
  pay,
  wait,
  done,
}

extension ParseToString on Status {
  String get value {
    switch (this.toString().split('.').last) {
      case "pay":
        return "pay ===== ";
      case "wait":
        return "wait ===== ";
      case "done":
        return "done ===== ";
      default:
        throw UnsupportedError("no found");
    }
  }
}
