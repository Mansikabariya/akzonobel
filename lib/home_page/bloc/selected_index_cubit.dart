import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedIndexCubit extends Cubit<int> {
  SelectedIndexCubit() : super(0); // Initial index is 0

  // Method to change the selected index
  void selectIndex(int index) => emit(index);
}
