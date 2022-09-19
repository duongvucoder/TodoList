import 'package:flutter_bloc/flutter_bloc.dart';

class TodoListCubit extends Cubit<TodoListBloc> {
  TodoListCubit() : super(TodoListInitState());

  List<Todolist> toDoList = [];

  void createdTodo(String content) {
    if (content.isNotEmpty) {
      toDoList.add(
        Todolist(
          content: content,
          dateTime: DateTime.now().toString(),
          isSeleted: false,
        ),
      );
    }
    emit(TodoListInitState());
  }

  void removeTodo(Todolist toDo) {
    toDoList.remove(toDo);
    emit(
      TodoListInitState(),
    );
  }

  void choose(Todolist toDo) {
    toDo.isSeleted = !toDo.isSeleted;
    emit(
      TodoListInitState(),
    );
  }
}

class TodoListBloc {}

class TodoListInitState extends TodoListBloc {}

class Todolist {
  bool isSeleted;
  String content;
  final String dateTime;

  Todolist(
      {required this.isSeleted, required this.content, required this.dateTime});
}
