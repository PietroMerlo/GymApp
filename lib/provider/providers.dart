import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/models/photoItem.dart';
import 'package:uitest/models/todoList.dart';
import 'package:uitest/models/todoitem.dart';
import 'package:uitest/models/userProfile.dart';
import 'package:http/http.dart' as http;

final greetingProvider = Provider((ref) {
  debugPrint("building greeting provider");
  return "Hello World!";
});

final counterProvider = StateProvider((ref) {
  debugPrint("building counter provider");
  return 123;
});

//state notifier è un oggetto di tipo todolist e internamente espone una lista di todoItem
final todoItemProvider =
    StateNotifierProvider<todoList, List<todoItem>>((ref) => todoList([]));

final currentToDoItemProvider = Provider<todoItem>(
  (ref) => throw UnimplementedError(),
);

final itemCounterProvider = Provider((ref) {
  debugPrint("building itemCounterProvider");
  return ref.watch(todoItemProvider).length;
});

final specificToDoItemProvider = Provider.family<todoItem, String>(
  (ref, id) {
    debugPrint("rebuilding specific provider for $id");
    return ref
        .watch(todoItemProvider)
        .where((element) => element.id == id)
        .single;
  },
);

final userProfileProvider = StateNotifierProvider<UserProfile, UserData?>(
  (ref) => UserProfile(null),
);

final galleryProvider = FutureProvider((ref) async {
  debugPrint("building galleryProvider");
  final response =
      await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
  debugPrint("got http");
  if (response.statusCode != 200) {
    throw Exception("Something went wrong");
  }

  List<dynamic> rawPhotoList = jsonDecode(response.body);
  var photoList = rawPhotoList
      .cast<Map<String, dynamic>>()
      .map((e) => photoItem.fromJson(e))
      .toList();
  photoList.shuffle();
  return photoList;
});

final selectedTodoItemProvider = StateProvider<String?>(
  (ref) => null,
);
