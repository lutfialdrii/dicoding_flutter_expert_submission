import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_serie_detail.dart';
import 'package:equatable/equatable.dart';

class Watchlist extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final Category? category;

  Watchlist({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.category,
  });

  factory Watchlist.fromMap(Map<String, dynamic> map) => Watchlist(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        category: map['category'] == Category.movie.toString()
            ? Category.movie
            : Category.tvSerie,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'category': category.toString(),
      };

  factory Watchlist.fromMovieDetailEntity(MovieDetail movie) => Watchlist(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
        category: Category.movie,
      );

  factory Watchlist.fromTvSerieDetailEntity(TvSerieDetail tvSerie) => Watchlist(
        id: tvSerie.id!,
        title: tvSerie.name,
        posterPath: tvSerie.posterPath,
        overview: tvSerie.overview,
        category: Category.tvSerie,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, posterPath, overview];
}
