  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:mhtask/class_users/task.dart';
  import 'package:mhtask/cubit/task_cubit.dart';

  class HomeScreen extends StatelessWidget {
    final String email; // Add email parameter
    HomeScreen({super.key, required this.email}); // Modify constructor

    TextEditingController titleController = TextEditingController();

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

              body: Stack(
                children: [
                  Container(
                    height: height,
                    width: width,
                    color: Colors.black,
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.07),
                      child:  Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                        'Welcome, $email',//Get the email info from login screen and appear it on the top
                        style: TextStyle(color: Colors.white,
                        fontSize: 20),
                      ), // Display email in app bar
                          SizedBox(width: 20,),
                          Text(
                        'To do app',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ]),
                  ),),
                  Container(
                    width: width,
                    height: height,
                    margin: EdgeInsets.only(top: height * 0.13),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: ListView.separated(
                      itemCount: cubit.tasks.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Transform.scale(
                                scale: 1.5,
                                child: Checkbox(
                                  value: cubit.tasks[index].finish,
                                  onChanged: (value) {
                                    cubit.changeStateTask(value!, index);
                                  },
                                  activeColor: Colors.green,
                                  shape: const CircleBorder(),
                                ),
                              ),
                              SizedBox(width: width * 0.05),
                              Text(
                                cubit.tasks[index].title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  decoration: cubit.tasks[index].finish == true
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  cubit.deleteTask(index);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    ),
                  ),
                ],
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
                              ElevatedButton(
                                onPressed: () {
                                  Task newTask = Task(
                                      title: titleController.text, finish: false);
                                  cubit.addTask(newTask);
                                  Navigator.pop(context);
                                  SnackBar snackBar = const SnackBar(
                                    content: Text('task added successfully'),
                                    backgroundColor: Colors.green,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(width, height * 0.06),
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('add task'),
                              ),
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