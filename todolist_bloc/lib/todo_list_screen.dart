import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_bloc/module/todo_list_bloc.dart';

class TodolistPage extends StatefulWidget {
  const TodolistPage({Key? key}) : super(key: key);

  @override
  State<TodolistPage> createState() => _TodolistPageState();
}

class _TodolistPageState extends State<TodolistPage> {
  TextEditingController controller = TextEditingController();
  final TodoListCubit _todoCubit = TodoListCubit();
  Todolist? selected;

  @override
  void dispose() {
    _todoCubit.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade300,
        centerTitle: false,
        title: const Text(
          'TodoList',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  _todoCubit.createdTodo(controller.text);
                  controller.clear();
                },
                icon: const Icon(
                  Icons.add_circle,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (selected != null && selected!.isSeleted) {
                    _todoCubit.removeTodo(selected!);
                  }
                },
                icon: const Icon(Icons.remove_circle),
              ),
              const SizedBox(
                width: 16,
              )
            ],
          )
        ],
      ),
      body: BlocBuilder(
        bloc: _todoCubit,
        builder: ((context, state) {
          return Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Please enter something you need to do',
                    hintStyle: TextStyle(overflow: TextOverflow.visible),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _todoCubit.toDoList.length,
                    itemBuilder: ((context, index) {
                      final todo = _todoCubit.toDoList[index];
                      return buildItem(todo);
                    }),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget buildItem(Todolist toDo) {
    return GestureDetector(
      onTap: (() {
        selected = toDo;
        _todoCubit.choose(toDo);
      }),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color:
              !toDo.isSeleted ? Colors.grey.shade200 : Colors.yellow.shade200,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(toDo.content),
            Text(toDo.dateTime),
          ],
        ),
      ),
    );
  }
}
