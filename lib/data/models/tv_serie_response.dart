import 'dart:convert';

import 'package:ditonton/data/models/tv_serie_model.dart';

TvSerieResponse tvSerieResponseFromJson(String str) =>
    TvSerieResponse.fromJson(json.decode(str));

String tvSerieResponseToJson(TvSerieResponse data) =>
    json.encode(data.toJson());

class TvSerieResponse {
  final int page;
  final List<TvSerieModel> results;
  final int totalPages;
  final int totalResults;

  TvSerieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TvSerieResponse.fromJson(Map<String, dynamic> json) =>
      TvSerieResponse(
        page: json["page"],
        results: List<TvSerieModel>.from(
            json["results"].map((x) => TvSerieModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
