import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/models/todoitem.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class todoList extends StateNotifier<List<todoItem>> {
  todoList(super.state);

  //metodo per aggiungere un nuovo item
  //crea l'item da aggiungere e lo aggiunge allo stato con setState
  void addItem(String title, String? description) {
    String titlenum = "$title # ${state.length + 1}";
    final newItem = todoItem(_uuid.v4(), titlenum, false, description);

    debugPrint("adding item: $newItem");

    state = [...state, newItem];
  }

  void zorro() {
    state = [];
  }

  void setDone(String id, bool done) {
    state = [
      for (final todoItem in state)
        if (todoItem.id == id) todoItem.withDone(done) else todoItem
    ];
  }

  void setDescription(String id, String description) {
    state = [
      for (final todoItem in state)
        if (todoItem.id == id)
          todoItem.withDescription(description)
        else
          todoItem
    ];
  }

  void setTitle(String id, String title) {
    state = [
      for (final todoItem in state)
        if (todoItem.id == id) todoItem.withTitle(title) else todoItem
    ];
  }

  void remove(String id) {
    state = state.where((element) => element.id != id).toList();
  }
}
