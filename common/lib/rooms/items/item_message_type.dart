enum ItemMessageType {
  create;

  String get encoded {
    switch (this) {
      case ItemMessageType.create:
        return 'ItemMessageType.create';
    }
  }
}
