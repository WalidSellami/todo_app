import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/layout/_cubit/Cubit.dart';
import 'package:todo/modules/settings/SettingsScreen.dart';
import 'package:todo/shared/components/Components.dart';
import 'package:todo/shared/cubit/Cubit.dart';
import 'package:todo/shared/cubit/States.dart';

class ToDo  extends StatefulWidget {

  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  var titleCnt = TextEditingController();

  var timeCnt = TextEditingController();

  var dateCnt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
        listener: (context , state){
          if(state is AppInsertDataBase){
            Navigator.pop(context);
          }
        },
        builder: (context , state){
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            drawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade700,
                    ),
                    child: const Text(
                      'ToDo App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings,
                      size: 25.0,
                    ),
                    title: const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Settings()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.exit_to_app_outlined,
                      size: 25.0,
                    ),
                    title: const Text(
                      'Exit',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              title: const Text(
                                'Exit',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: const SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    Text(
                                      'Do you want to exit ?',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'No',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                ),
                                TextButton(
                                  onPressed: (){
                                    exit(0);
                                  },
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                              ],
                            );
                          }
                      );
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.index],
              ),
            ),
            floatingActionButton: (cubit.index == 0) ? FloatingActionButton(
              onPressed: (){
                if(cubit.isSheet){
                  if(formKey.currentState!.validate()){
                    cubit.insertToDatabase(
                        title: titleCnt.text,
                        date: dateCnt.text,
                        time: timeCnt.text);
                    titleCnt.text = '';
                    timeCnt.text = '';
                    dateCnt.text = '';
                  }
                }else{
                  scaffoldKey.currentState!.showBottomSheet((context){
                    return Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultFormField(
                                controller: titleCnt,
                                type: TextInputType.text,
                                validate: (String? value){
                                  if((value??'').isEmpty){
                                    return'Title must not be empty';
                                  }
                                  return null;
                                },
                                label: 'Task Title',
                                prefix: Icons.title),
                            const SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                                controller: timeCnt,
                                type: TextInputType.number,
                                validate: (String? value){
                                  if((value??'').isEmpty){
                                    return'Time must not be empty';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  if (kDebugMode) {
                                    print('Timing tapped');
                                  }
                                  showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                      .then((value) {
                                    timeCnt.text = value!.format(context);
                                  });
                                },
                                label: 'Task Time',
                                prefix: Icons.watch_later_outlined),
                            const SizedBox(
                              height: 15.0,
                            ),
                            defaultFormField(
                                controller: dateCnt,
                                type: TextInputType.datetime,
                                validate: (String? value){
                                  if((value??'').isEmpty){
                                    return'Date must not be empty';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  if (kDebugMode) {
                                    print('Date tapped');
                                  }
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2040-01-01'),
                                  ).then((value) {
                                    dateCnt.text =
                                        DateFormat.yMMMd().format(value!);
                                  });
                                },
                                label: 'Task Date',
                                prefix: Icons.calendar_month),
                          ],
                        ),
                      ),
                    );
                  },
                  elevation: 25.0,
                  ).closed.then((value){
                    cubit.changeBottomSheet(isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheet(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(
                cubit.fabIcon,
                color: TodoCubit.get(context).isDark ? Colors.black : Colors.white,
              ),
            ) : null,
            body: cubit.screens[cubit.index],
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  label: 'Tasks',
                  icon: Icon(
                    Icons.menu,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Done',
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Archived',
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                ),
              ],
              currentIndex: cubit.index,
              onTap: (index){
                cubit.changeIndex(index);
              },
            ),
          );
        },
    );
  }
}
