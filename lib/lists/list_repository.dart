// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dart_frog_tutorial/hash_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'list_repository.g.dart';

@visibleForTesting
//data source  -in-memory cache
Map<String, TaskList> listDb = {};

@JsonSerializable()
class TaskList extends Equatable {
  final String id;
  final String name;
  const TaskList({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];

  //deserialization
  factory TaskList.fromJson(Map<String, dynamic> json) => _$TaskListFromJson(json);

  //serialization
  Map<String, dynamic> toJson() => _$TaskListToJson(this);

  TaskList copyWith({
    String? id,
    String? name,
  }) {
    return TaskList(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}


class TaskListRepository {
  ///check in the internal dart source for alist with the given [id]
  Future<TaskList?> listById(String id) async {
    return listDb[id];
  }

  //get all the list for data source
  Map<String, dynamic> getAllList() {
    final formattedList = <String, dynamic>{};
    if (listDb.isNotEmpty) {
      listDb.forEach(
        (String id) {
          final currentList = listDb[id];
          formattedList[id] = currentList?.toJson();
        } as void Function(String key, TaskList value),
      );
    }

    return formattedList;
  }

  //create a new list with a given [name]

  String createList({required String name}) {
    //dynamically generates the id
    final id = name.hashValue;

    //create a new TaskList object and pass our two parameters
    final list = TaskList(id: id, name: name);

    //add a anew Tasklist object to our data source
    listDb[id] = list;

    return id;
  }

  ///Delete the tasklist object with the given id
  void deleteList(String id) {
    listDb.remove(id);
  }

  //update list operation
  Future<void> updateList({required String id, required String name}) async {
    final currentList = listDb[id];
    if (currentList == null) {
      return Future.error(Exception('List not found'));
    }
    final list = TaskList(id: id, name: name);
    listDb[id] = list;
  }
}
