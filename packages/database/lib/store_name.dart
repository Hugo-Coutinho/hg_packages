enum StoreName {
  fruit
}

extension ParseToString on StoreName {
  String toShortString() {
    return this.toString().split('.').last;
  }
}