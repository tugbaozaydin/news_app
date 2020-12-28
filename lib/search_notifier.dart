import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';

class SearchNotifier extends ChangeNotifier {
  List<RssItem> list = [];

  void addSearch(List<RssItem> value) {
    this.list = value;
  }

  List<RssItem> getSearch() {
    return list;
  }

 List<RssItem> search(String searchQuery) {
    List<RssItem> _filteredList = list
        .where((RssItem item) => item.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    list=_filteredList;
    notifyListeners();
  }

  void removeSearch() {
    list.clear();
    notifyListeners();
  }
}
