// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'series_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SeriesResponse _$SeriesResponseFromJson(Map<String, dynamic> json) {
  return _SeriesResponse.fromJson(json);
}

/// @nodoc
mixin _$SeriesResponse {
  int? get page => throw _privateConstructorUsedError;
  List<SeriesModel>? get results => throw _privateConstructorUsedError;
  int? get totalPages => throw _privateConstructorUsedError;
  int? get totalResults => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SeriesResponseCopyWith<SeriesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeriesResponseCopyWith<$Res> {
  factory $SeriesResponseCopyWith(
          SeriesResponse value, $Res Function(SeriesResponse) then) =
      _$SeriesResponseCopyWithImpl<$Res, SeriesResponse>;
  @useResult
  $Res call(
      {int? page,
      List<SeriesModel>? results,
      int? totalPages,
      int? totalResults});
}

/// @nodoc
class _$SeriesResponseCopyWithImpl<$Res, $Val extends SeriesResponse>
    implements $SeriesResponseCopyWith<$Res> {
  _$SeriesResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? results = freezed,
    Object? totalPages = freezed,
    Object? totalResults = freezed,
  }) {
    return _then(_value.copyWith(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      results: freezed == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<SeriesModel>?,
      totalPages: freezed == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int?,
      totalResults: freezed == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SeriesResponseCopyWith<$Res>
    implements $SeriesResponseCopyWith<$Res> {
  factory _$$_SeriesResponseCopyWith(
          _$_SeriesResponse value, $Res Function(_$_SeriesResponse) then) =
      __$$_SeriesResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? page,
      List<SeriesModel>? results,
      int? totalPages,
      int? totalResults});
}

/// @nodoc
class __$$_SeriesResponseCopyWithImpl<$Res>
    extends _$SeriesResponseCopyWithImpl<$Res, _$_SeriesResponse>
    implements _$$_SeriesResponseCopyWith<$Res> {
  __$$_SeriesResponseCopyWithImpl(
      _$_SeriesResponse _value, $Res Function(_$_SeriesResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? results = freezed,
    Object? totalPages = freezed,
    Object? totalResults = freezed,
  }) {
    return _then(_$_SeriesResponse(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      results: freezed == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<SeriesModel>?,
      totalPages: freezed == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int?,
      totalResults: freezed == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_SeriesResponse implements _SeriesResponse {
  const _$_SeriesResponse(
      {this.page,
      final List<SeriesModel>? results,
      this.totalPages,
      this.totalResults})
      : _results = results;

  factory _$_SeriesResponse.fromJson(Map<String, dynamic> json) =>
      _$$_SeriesResponseFromJson(json);

  @override
  final int? page;
  final List<SeriesModel>? _results;
  @override
  List<SeriesModel>? get results {
    final value = _results;
    if (value == null) return null;
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? totalPages;
  @override
  final int? totalResults;

  @override
  String toString() {
    return 'SeriesResponse(page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SeriesResponse &&
            (identical(other.page, page) || other.page == page) &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, page,
      const DeepCollectionEquality().hash(_results), totalPages, totalResults);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SeriesResponseCopyWith<_$_SeriesResponse> get copyWith =>
      __$$_SeriesResponseCopyWithImpl<_$_SeriesResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SeriesResponseToJson(
      this,
    );
  }
}

abstract class _SeriesResponse implements SeriesResponse {
  const factory _SeriesResponse(
      {final int? page,
      final List<SeriesModel>? results,
      final int? totalPages,
      final int? totalResults}) = _$_SeriesResponse;

  factory _SeriesResponse.fromJson(Map<String, dynamic> json) =
      _$_SeriesResponse.fromJson;

  @override
  int? get page;
  @override
  List<SeriesModel>? get results;
  @override
  int? get totalPages;
  @override
  int? get totalResults;
  @override
  @JsonKey(ignore: true)
  _$$_SeriesResponseCopyWith<_$_SeriesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
