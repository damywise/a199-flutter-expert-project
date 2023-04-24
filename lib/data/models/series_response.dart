// To parse this JSON data, do
//
//     final seriesResponse = seriesResponseFromJson(jsonString);

import 'package:ditonton/data/models/series_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'series_response.freezed.dart';
part 'series_response.g.dart';

@freezed
class SeriesResponse with _$SeriesResponse {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SeriesResponse({
    int? page,
    List<SeriesModel>? results,
    int? totalPages,
    int? totalResults,
  }) = _SeriesResponse;

  factory SeriesResponse.fromJson(Map<String, dynamic> json) =>
      _$SeriesResponseFromJson(json);
}

extension SeriesResponseExtension on SeriesResponse {
  List<SeriesModel> get seriesList =>
      results?.where((element) => element.posterPath != null).toList() ??
      <SeriesModel>[];
}
