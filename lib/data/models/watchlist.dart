import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_serie_detail.dart';
import 'package:equatable/equatable.dart';

class Watchlist extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? type;

  Watchlist({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.type,
  });

  factory Watchlist.fromMap(Map<String, dynamic> map) => Watchlist(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        type: map['type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'type': type,
      };

  factory Watchlist.fromMovieDetailEntity(MovieDetail movie) => Watchlist(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
        type: Category.movie,
      );

  factory Watchlist.fromTvSerieDetailEntity(TvSerieDetail tvSerie) => Watchlist(
        id: tvSerie.id!,
        title: tvSerie.name,
        posterPath: tvSerie.posterPath,
        overview: tvSerie.overview,
        type: Category.tvSerie,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, posterPath, overview];
}
