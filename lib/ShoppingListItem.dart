import 'package:floor/floor.dart';

@entity
class ShoppingListItem {
  @primaryKey
  final int id;

  final String name;

  final int quantity;

  ShoppingListItem(this.id, this.name, this.quantity) {
    if(id >= ID) {
      ID = id + 1;
    }
  }

  static int ID = 1;

}