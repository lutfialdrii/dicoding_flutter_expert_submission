import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:equatable/equatable.dart';

class WatchlistModel extends Equatable {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final Category category;

  WatchlistModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.category,
  });

  factory WatchlistModel.fromMap(Map<String, dynamic> map) => WatchlistModel(
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

  factory WatchlistModel.fromEntity(Watchlist entity) {
    return WatchlistModel(
        id: entity.id,
        title: entity.title ?? "",
        posterPath: entity.posterPath ?? "",
        overview: entity.overview ?? "",
        category: entity.category!);
  }

  Watchlist toEntity() {
    return Watchlist(
        id: id,
        title: title,
        posterPath: posterPath,
        overview: overview,
        category: category);
  }

  @override
  
  List<Object?> get props => [id, title, posterPath, overview, category];
}
