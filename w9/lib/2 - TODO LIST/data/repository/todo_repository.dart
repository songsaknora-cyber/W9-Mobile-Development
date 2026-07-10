import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dto/todo_dto.dart';
import 'repository_exception.dart';

class TodoRepository {
  static final global = TodoRepository(); // unique instance

  static const String _baseUrl = "";

  Future<List<Todo>> getTodos() async {
    //  TODO
    //  Adapt the code to handle firebase data fetch
    //

    return Future.delayed(Duration(seconds: 1), () {
      return fakeTodos;

      //  TODO
      // Ensure the message is displayed on the UI if error occured
      //throw RepositoryException("No wifi !");
    });
  }

  Future<void> updateCompleted(String todoId, bool completed) async {
    //  TODO
    //  Adapt the code to handle firebase data fetch
    //
    int index = fakeTodos.indexWhere((e) => e.id == todoId);
    fakeTodos[index] = fakeTodos[index].copyWith(completed);

    return Future.delayed(Duration(microseconds: 1), () => true);
  }
}
