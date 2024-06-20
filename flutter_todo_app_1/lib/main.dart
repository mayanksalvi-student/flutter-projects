import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: ToDoApp()),
    );
  }
}

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  final TextEditingController _controller = TextEditingController();
  final List<String> todoData = ['mayank', 'salvi'];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool updateBtn = false;
  late int updateIndex;

  void _editButtonPress(int index) {
    updateIndex = index;
    setState(() {
      updateBtn = true;
    });
    _controller.text = todoData[index];
  }

  void _deleteButtonPress(int index) {
    setState(() {
      todoData.removeAt(index);
      _showSnackbar(msg: 'Item Deleted', bgColor: Colors.red);
    });
  }

  void _addItem() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        todoData.add(_controller.text);
        _controller.clear();
        _showSnackbar(msg: 'New Item Added', bgColor: Colors.green);
      });
    }
  }

  void _updateItem() {
    if (_controller.text.isNotEmpty) {
      updateBtn = false;
      setState(() {
        todoData[updateIndex] = _controller.text;
        _controller.clear();
        _showSnackbar(msg: 'Item Updated');
      });
    }
  }

  void _showSnackbar({required String msg, Color bgColor = Colors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bgColor,
        content: Text(
          msg,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ToDo App')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Todo...',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                    width: 60,
                    height: 60,
                    child: updateBtn
                        ? IconButton(
                            onPressed: () {
                              _updateItem();
                            },
                            icon: const Icon(
                              Icons.update,
                              size: 40,
                              color: Colors.white,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              _addItem();
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: todoData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(todoData[index]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              _editButtonPress(index);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              _deleteButtonPress(index);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
