import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:firebase_core/firebase_core.dart';
import '../class_users/task.dart';
import '../cubit/task_cubit.dart';

class HomeScreenTest extends StatefulWidget {
  late final String email; // Add email parameter
  HomeScreenTest({super.key, required this.email});
  @override
  State<HomeScreenTest> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenTest> {
  List data = [];
  bool isLoading = true;

  getData() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('users').get();
    data.addAll(querySnapshot.docs);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  TextEditingController titleController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({'name': titleController.text})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => TaskCubit(),
      child: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = context.read<TaskCubit>();
          return Scaffold(
            appBar: AppBar(
              title: Text('Appbar'),
            ),
            body: ListView.builder(
              itemBuilder: (buider, i) {

                return Container(


                  height: 80,
                  margin: EdgeInsets.only(top: height * 0.13),
                  decoration: const BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Text('${data[i]['name']}'),
                );
              },
              itemCount: data.length,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                titleController.clear();
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: height * 0.5,
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            const Text(
                              'add task',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            TextFormField(
                              controller: titleController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.edit),
                                hintText: 'title',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     addUser();
                            //     Task newTask = Task(
                            //         title: titleController.text, finish: false);
                            //     cubit.addTask(newTask);
                            //     Navigator.pop(context);
                            //     SnackBar snackBar = const SnackBar(
                            //       content: Text('task added successfully'),
                            //       backgroundColor: Colors.green,
                            //     );
                            //     ScaffoldMessenger.of(context)
                            //         .showSnackBar(snackBar);
                            //   },
                            //   style: ElevatedButton.styleFrom(
                            //     minimumSize: Size(width, height * 0.06),
                            //     backgroundColor: Colors.black,
                            //     foregroundColor: Colors.white,
                            //   ),
                            //   child: const Text('add task'),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              backgroundColor: Colors.black,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
