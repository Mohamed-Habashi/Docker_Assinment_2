import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:docker/cubit/cubit.dart';
import 'package:docker/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../shared/components/components.dart';

var idController = TextEditingController();
var nameController = TextEditingController();
var emailController = TextEditingController();
var genderController = TextEditingController();
var ageController = TextEditingController();
var updateIdController = TextEditingController();
var updateNameController = TextEditingController();
var updateEmailController = TextEditingController();
var updateGenderController = TextEditingController();
var updateAgeController = TextEditingController();

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = MainCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: cubit.va.isEmpty
                  ? const Center(
                      child: Text(
                        'NO DATA TO SHOW',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ConditionalBuilder(
                      condition: cubit.dockerModel != null,
                      builder: (context) => ListView.separated(
                          itemBuilder: (context, index) =>
                              view(cubit.va[index], context),
                          separatorBuilder: (context, index) => Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                          itemCount: cubit.va.length),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Add Task'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              defaultFormField(
                                controller: idController,
                                obscure: false,
                                keyboardType: TextInputType.number,
                                label: 'id',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                controller: nameController,
                                obscure: false,
                                keyboardType: TextInputType.text,
                                label: 'name',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                controller: emailController,
                                obscure: false,
                                keyboardType: TextInputType.text,
                                label: 'email',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                controller: genderController,
                                obscure: false,
                                keyboardType: TextInputType.text,
                                label: 'gender',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                controller: ageController,
                                obscure: false,
                                keyboardType: TextInputType.number,
                                label: 'age',
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                if (idController.text.isEmpty ||
                                    nameController.text.isEmpty ||
                                    emailController.text.isEmpty ||
                                    genderController.text.isEmpty ||
                                    ageController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: 'All data Must be not empty',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 5,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  cubit.addData(
                                    id: idController.text,
                                    name: nameController.text,
                                    email: emailController.text,
                                    gender: genderController.text,
                                    age: ageController.text,
                                  );
                                  idController.clear();
                                  nameController.clear();
                                  emailController.clear();
                                  genderController.clear();
                                  ageController.clear();
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text('Add')),
                          TextButton(
                              onPressed: () {
                                idController.clear();
                                nameController.clear();
                                emailController.clear();
                                genderController.clear();
                                ageController.clear();
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cancel',
                              )),
                        ],
                      );
                    });
              },
              tooltip: 'Add',
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}

Widget view(model, context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CircleAvatar(
                radius: 40,
                child: Text(
                  'Id:${model['id']}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name:${model['name']}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Email:${model['email']}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Gender:${model['gender']}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Age:${model['age']}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Add Task'),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultFormField(
                                controller: updateIdController,
                                obscure: false,
                                keyboardType: TextInputType.number,
                                label: '${model['id']}',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                controller: updateNameController,
                                obscure: false,
                                keyboardType: TextInputType.text,
                                label: '${model['name']}',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                controller: updateEmailController,
                                obscure: false,
                                keyboardType: TextInputType.text,
                                label: '${model['email']}',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                controller: updateGenderController,
                                obscure: false,
                                keyboardType: TextInputType.text,
                                label: model['gender'],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              defaultFormField(
                                controller: updateAgeController,
                                obscure: false,
                                keyboardType: TextInputType.number,
                                label: model['age'],
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                MainCubit.get(context).updateData(
                                  id1: model['id'],
                                  id2: updateIdController.text,
                                  name: updateNameController.text,
                                  email: updateEmailController.text,
                                  gender: updateGenderController.text,
                                  age: updateAgeController.text,
                                );
                                updateAgeController.clear();
                                updateGenderController.clear();
                                updateEmailController.clear();
                                updateNameController.clear();
                                updateIdController.clear();
                                Navigator.pop(context);
                              },
                              child: const Text('Update')),
                          TextButton(
                              onPressed: () {
                                updateAgeController.clear();
                                updateGenderController.clear();
                                updateEmailController.clear();
                                updateNameController.clear();
                                updateIdController.clear();
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cancel',
                              )),
                        ],
                      );
                    });
              },
              child: const Text('UPDATE'),
            ),
            TextButton(
              onPressed: () {
                MainCubit.get(context).deleteData(id: model['id']);
              },
              child: const Text(
                'REMOVE',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
