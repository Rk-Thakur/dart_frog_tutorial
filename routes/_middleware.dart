import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_tutorial/items/item_respository.dart';
import 'package:dart_frog_tutorial/lists/list_repository.dart';

Handler middleware(Handler handler) {
  // return handler.use(requestLogger())
  // .use(provider<String>((context) => 'Dart Frog Tutorial 2020'));

  return handler
      .use(requestLogger())
      .use(
        provider<TaskListRepository>(
          (context) => TaskListRepository(),
        ),
      )
      .use(
        provider<TaskItemRepository>(
          (context) => TaskItemRepository(),
        ),
      );
}
