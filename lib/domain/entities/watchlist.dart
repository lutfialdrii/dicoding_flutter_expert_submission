import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_serie_detail.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Watchlist extends Equatable {
  int id;
  String? title;
  String? posterPath;
  String? overview;
  Category? category;

  Watchlist({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.category,
  });

  factory Watchlist.fromMovieDetailEntity(MovieDetail movie) => Watchlist(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
        category: Category.movie,
      );

  factory Watchlist.fromTvSerieDetailEntity(TvSerieDetail tvSerie) => Watchlist(
        id: tvSerie.id!,
        title: tvSerie.name ?? "",
        posterPath: tvSerie.posterPath ?? "",
        overview: tvSerie.overview ?? "",
        category: Category.tvSerie,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview, category];
}
