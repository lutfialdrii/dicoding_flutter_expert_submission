import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/home/blocs/category/category_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CategoryBloc', () {
    late CategoryBloc categoryBloc;

    setUp(() {
      categoryBloc = CategoryBloc();
    });

    tearDown(() {
      categoryBloc.close();
    });

    test('initial state is Category.movie', () {
      expect(categoryBloc.state, CategoryState(Category.movie));
    });

    blocTest<CategoryBloc, CategoryState>(
      'emits [Category.tvSerie] when ChangeCategory is added',
      build: () => categoryBloc,
      act: (bloc) => bloc.add(ChangeCategory(Category.tvSerie)),
      expect: () => [CategoryState(Category.tvSerie)],
    );
  });
}
