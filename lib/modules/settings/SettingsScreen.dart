import 'package:flutter/material.dart';
import 'package:todo/layout/_cubit/Cubit.dart';

class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
            )),
        title: Text(
          'Settings',
          style: TextStyle(

          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 10.0,
              bottom: 6.0,
            ),
            child: Text(
              'General',
              style: TextStyle(
                fontSize: 20.0,
                color: TodoCubit.get(context).isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
          ),
          ListTile(
            // leading: Icon(
            //   Icons.dark_mode_rounded,
            //   size: 25.0,
            // ),
            title: Padding(
              padding: const EdgeInsets.only(
                left: 6.0,
              ),
              child: Text(
                'Dark mode',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            trailing: CircleAvatar(
              radius: 25.0,
              backgroundColor: TodoCubit.get(context).isDark ? Colors.grey.shade600 : Colors.grey.shade300,
              child: IconButton(
                onPressed: () {
                  TodoCubit.get(context).changeMode();
                },
                icon: TodoCubit.get(context).isDark ? Icon(
                  Icons.light_mode_sharp,
                  size: 25.0,
                  color: Colors.white,
                ) : Icon(
                  Icons.dark_mode_sharp,
                  size: 25.0,
                  color: Colors.grey.shade900,
                ),
                tooltip: 'Dark mode',
              ),
            ),
          ),
          // SizedBox(
          //   height: 12.0,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     left: 22.0,
          //   ),
          //   child: Row(
          //     children: [
          //       Text(
          //         'Circle Time Color',
          //         style: Theme.of(context).textTheme.headline2,
          //       ),
          //       SizedBox(
          //         width: 30.0,
          //       ),
          //       DropdownButton(
          //         borderRadius: BorderRadius.circular(12.0),
          //         style: Theme.of(context).textTheme.headline3,
          //           dropdownColor: TodoCubit.get(context).isDark ? Colors.grey.shade700 : Colors.grey.shade300,
          //           value: TodoCubit.get(context).dropValue,
          //           icon: Icon(
          //             Icons.arrow_drop_down,
          //             size: 25.0,
          //             color: Colors.grey,
          //           ),
          //           items: TodoCubit.get(context).dropItems.map((String value) {
          //             return DropdownMenuItem(
          //                 value: value,
          //                 child: Text(
          //                     value,
          //                 ));
          //           }).toList(),
          //           onChanged: (value) {
          //             TodoCubit.get(context).changeDropDownButton(value);
          //           }),
          //     ],
          //   ),
          // ),

        ],
      ),
    );
  }
}
