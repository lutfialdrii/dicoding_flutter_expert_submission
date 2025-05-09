import 'package:ditonton/common/constants.dart';
import 'package:ditonton/data/models/watchlist_model.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_serie_detail.dart';
import 'package:ditonton/domain/entities/watchlist.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testWatchList = [testWatchlistMovie, testWatchlistTvSerie];

final testWatchlistMovie = Watchlist(
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    title: 'title',
    category: Category.movie);

final testWatchlistTvSerie = Watchlist(
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    title: 'title',
    category: Category.tvSerie);

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);
final testTvSerieDetail = TvSerieDetail(
    adult: false,
    backdropPath: "backdropPath",
    createdBy: [],
    episodeRunTime: [],
    firstAirDate: DateTime.now(),
    genres: [],
    homepage: "",
    id: 0,
    inProduction: false,
    languages: [],
    lastAirDate: DateTime.now(),
    lastEpisodeToAir: TEpisodeToAir(
        id: 0,
        name: "name",
        overview: "overview",
        voteAverage: 0,
        voteCount: 0,
        airDate: DateTime.now(),
        episodeNumber: 0,
        episodeType: "",
        productionCode: "",
        runtime: 0,
        seasonNumber: 0,
        showId: 0,
        stillPath: ""),
    name: "",
    nextEpisodeToAir: TEpisodeToAir(
        id: 0,
        name: "name",
        overview: "overview",
        voteAverage: 0,
        voteCount: 0,
        airDate: DateTime.now(),
        episodeNumber: 0,
        episodeType: "",
        productionCode: "",
        runtime: 0,
        seasonNumber: 0,
        showId: 0,
        stillPath: ""),
    networks: [],
    numberOfEpisodes: 0,
    numberOfSeasons: 0,
    originCountry: [],
    originalLanguage: "",
    originalName: "",
    overview: "",
    popularity: 0,
    posterPath: "",
    productionCompanies: [],
    productionCountries: [],
    seasons: [],
    spokenLanguages: [],
    status: "",
    tagline: "",
    type: "",
    voteAverage: 0,
    voteCount: 0);

final testWatchlist = WatchlistModel(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
    category: Category.movie);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'category': Category.movie.toString(),
};
