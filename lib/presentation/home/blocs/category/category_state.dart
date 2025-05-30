part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final Category category;

  CategoryState(this.category);
  @override
  List<Object?> get props => [category];
}
