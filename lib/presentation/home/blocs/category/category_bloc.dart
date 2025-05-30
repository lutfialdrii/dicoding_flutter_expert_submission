import 'package:bloc/bloc.dart';
import 'package:ditonton/common/constants.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryState(Category.movie)) {
    on<ChangeCategory>(
      (event, emit) => emit(CategoryState(event.category)),
    );
  }
}
