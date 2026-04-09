class Cart {
  static List<Map<String, dynamic>> _items = [];

  static void addItem(Map<String, dynamic> item) {
    _items.add(item);
  }
  static void clearItems() {
    _items.clear();
  }
  static List<Map<String, dynamic>> getItems() {
    return _items;
  }
}
