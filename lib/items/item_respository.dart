// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dart_frog_tutorial/hash_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'item_respository.g.dart';

@visibleForTesting
//data source  -in-memory cache
Map<String, TaskItem> itemDb = {};

@JsonSerializable()
class TaskItem extends Equatable {
  final String id;
  final String name;

  //list id of where the item belongs
  final String listId;

  //item's description
  final String description;

  //item's status
  final bool status;
  const TaskItem({
    required this.id,
    required this.name,
    required this.listId,
    required this.description,
    required this.status,
  });

  @override
  List<Object?> get props => [id, name];

  //deserialization
  factory TaskItem.fromJson(Map<String, dynamic> json) => _$TaskItemFromJson(json);

  //serialization
  Map<String, dynamic> toJson() => _$TaskItemToJson(this);

  TaskItem copyWith({
    String? id,
    String? name,
    String? listId,
    String? description,
    bool? status,
  }) {
    return TaskItem(
      id: id ?? this.id,
      name: name ?? this.name,
      listId: listId ?? this.listId,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }
}

class TaskItemRepository {
  ///check in the internal dart source an item with the given [id]
  Future<TaskItem?> itemById(String id) async {
    return itemDb[id];
  }

  //get all the list for data source
  Map<String, dynamic> getAllList() {
    final formattedList = <String, dynamic>{};
    if (itemDb.isNotEmpty) {
      itemDb.forEach(
        (String id) {
          final currentList = itemDb[id];
          formattedList[id] = currentList?.toJson();
        } as void Function(String key, TaskItem value),
      );
    }

    return formattedList;
  }

  //create a new item with a given information

  String createItem({
    required String name,
    required String listId,
    required String description,
    required bool status,
  }) {
    //dynamically generates the id
    final id = name.hashValue;

    //create a new TaskList object and pass our two parameters
    final item = TaskItem(
      id: id,
      name: name,
      listId: listId,
      description: description,
      status: status,
    );

    //add a anew Tasklist object to our data source
    itemDb[id] = item;

    return id;
  }

  ///Delete the item  object with the given id
  void deleteItem(String id) {
    itemDb.remove(id);
  }

  //update list operation
  Future<void> updateItem({
    required String id,
    required String name,
    required String listId,
    required String description,
    required bool status,
  }) async {
    final currentList = itemDb[id];
    if (currentList == null) {
      return Future.error(Exception('Item not found'));
    }
    final task = TaskItem(
      id: id,
      name: name,
      listId: listId,
      description: description,
      status: status,
    );
    itemDb[id] = task;
  }
}
