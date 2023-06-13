import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/layout/ToDo_App.dart';
import 'package:todo/layout/_cubit/Cubit.dart';
import 'package:todo/layout/_cubit/States.dart';
import 'package:todo/shared/cubit/Cubit.dart';
import 'package:todo/shared/network/local/CacheHelper.dart';
import 'package:todo/shared/styles/styles.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBooleen(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {

 final bool? isDark;

 const MyApp(this.isDark, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => TodoCubit()..changeMode(
      fromShared: isDark ?? false,
    ),),
        BlocProvider(create: (BuildContext context) => AppCubit()..createDataBase()),
      ],
      child: BlocConsumer<TodoCubit , TodoStates>(
        listener: (context , state) {},
        builder: (context , state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter ToDo App',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: TodoCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: const ToDo(),
          );
        },
      ),
    );
  }
}
