
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/layout/_cubit/States.dart';
import 'package:todo/shared/network/local/CacheHelper.dart';


class TodoCubit extends Cubit<TodoStates> {

  TodoCubit() : super(InitialState());

  static TodoCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeMode({bool? fromShared}){
    if(fromShared != null) {
      isDark = fromShared;
    }else {
      isDark = !isDark;
      CacheHelper.putBooleen(key: 'isDark', value: isDark).then((value) {
        emit(ChangeModeApp());
      });
    }
  }

  // String? dropValue = 'blue';
  // List<String> dropItems = [
  //   'blue',
  //   'red',
  //   'grey',
  //   'green',
  // ];
  //
  // void changeDropDownButton(value){
  //   dropValue = value.toString();
  //   emit(ChangeDropDownButton());
  // }
  //
  // Color getColor(String color){
  //   if(color.compareTo('red') == 0){
  //     return Colors.red;
  //   }
  //   else if(color.compareTo('grey') == 0){
  //     return Colors.grey.shade700;
  //   }
  //   else if(color.compareTo('green') == 0){
  //     return Colors.green.shade600;
  //   }
  //   else{
  //     return Colors.blue.shade800;
  //   }
  // }

}

