import 'package:flutter/material.dart';
import 'package:horoscope_app/model/menu_item_model.dart';

class MenuItems {
  static const List<MenuItem1> itemFirst = [
    itemSearch,
    itemLogout,
  ];

  static const itemSearch = const MenuItem1("Search Sign", Icons.list);
  static const itemLogout = const MenuItem1("Log Out", Icons.logout);


}
