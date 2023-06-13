import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/components/Components.dart';
import 'package:todo/shared/cubit/Cubit.dart';
import 'package:todo/shared/cubit/States.dart';

class Done extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context , state){},
      builder: (context , state){
        var tasks = AppCubit.get(context).doneTasks;
        return  ConditionalBuilder(
          condition: tasks.isNotEmpty,
          builder: (context) =>  ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context , index) => buildItemToDoList(tasks[index] , context),
              separatorBuilder: (context , index) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                ),
                child: Divider(
                  color: Colors.grey.shade600,
                  thickness: 1,
                ),
              ),
              itemCount: tasks.length),
          fallback: (context) => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No Dones Tasks',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

        );
      },
    );

  }
}
