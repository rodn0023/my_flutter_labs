import 'package:floor/floor.dart';

import 'ShoppingListItem.dart';

@dao
abstract class ShoppingListItemDAO {
  @Query('SELECT * FROM ShoppingListItem')
  Future<List<ShoppingListItem>> findAllShoppingListItems();

  @delete
  Future<void> deleteShoppingListItem(ShoppingListItem shopListItem);

  @insert
  Future<void> insertShoppingListItem(ShoppingListItem shopListItem);

}