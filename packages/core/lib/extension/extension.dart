extension ParseEnumToString<T  extends dynamic> on T {
  String rawValue() {
    return this.toString().split('.').last;
  }
}

