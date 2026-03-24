
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'ShoppingListItemDAO.dart';
import 'ShoppingListItem.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ShoppingListItem])
abstract class AppDatabase extends FloorDatabase {
  ShoppingListItemDAO get shoppingListItemDAO;
}