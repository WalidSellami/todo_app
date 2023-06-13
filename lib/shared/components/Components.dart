import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo/layout/_cubit/Cubit.dart';
import 'package:todo/shared/cubit/Cubit.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  // Function? onSubmit,
  String? Function(String?)? onChange,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  VoidCallback? onTap,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      // onFieldSubmitted: (s) {
      //   onSubmit!(s);
      // },
      onChanged: onChange,
      validator: validate,
      onTap: onTap ?? () {},
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        border: const OutlineInputBorder(),
      ),
    );

Widget buildItemToDoList(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Task:',
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            color:
                                                TodoCubit.get(context).isDark
                                                    ? Colors.grey.shade300
                                                    : Colors.grey.shade700,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6.0,
                                        ),
                                        Expanded(
                                          child: Text(
                                            model['title'],
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: TodoCubit.get(context)
                                                        .isDark
                                                    ? Colors.white
                                                    : Colors.grey.shade900,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Time:',
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            color:
                                                TodoCubit.get(context).isDark
                                                    ? Colors.grey.shade300
                                                    : Colors.grey.shade700,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6.0,
                                        ),
                                        Text(
                                          model['time'],
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: TodoCubit.get(context)
                                                      .isDark
                                                  ? Colors.white
                                                  : Colors.grey.shade900,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Date:',
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            color:
                                                TodoCubit.get(context).isDark
                                                    ? Colors.grey.shade300
                                                    : Colors.grey.shade700,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6.0,
                                        ),
                                        Text(
                                          model['date'],
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color:
                                                TodoCubit.get(context).isDark
                                                    ? Colors.white
                                                    : Colors.grey.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                    ],
                  );
                });
          },
          child: Row(
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundColor: TodoCubit.get(context).isDark ? Colors.grey.shade800.withOpacity(.5) : Colors.blue.shade800,
                child: Text(
                  '${model['time']}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model['title']}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${model['date']}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
              IconButton(
                splashColor: Colors.green.shade100,
                onPressed: () {
                  AppCubit.get(context)
                      .updateDataBase(status: 'done', id: model['id']);
                },
                icon: Icon(
                  Icons.check_circle_outline,
                  color: (AppCubit.get(context).index == 0 ||
                          AppCubit.get(context).index == 2)
                      ? Colors.grey.shade600
                      : HexColor('35c2c2'),
                  size: 26.0,
                ),
              ),
              IconButton(
                splashColor: Colors.grey.shade300,
                onPressed: () {
                  AppCubit.get(context)
                      .updateDataBase(status: 'archived', id: model['id']);
                },
                icon: Icon(
                  Icons.archive_outlined,
                  color: (AppCubit.get(context).index == 0 ||
                          AppCubit.get(context).index == 1)
                      ? Colors.grey.shade600
                      : HexColor('35c2c2'),
                  size: 26.0,
                ),
              ),
            ],
          ),
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteDataBase(id: model['id']);
      },
    );

