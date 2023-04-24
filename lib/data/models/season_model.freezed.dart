// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'season_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SeasonModel _$SeasonModelFromJson(Map<String, dynamic> json) {
  return _SeasonModel.fromJson(json);
}

/// @nodoc
mixin _$SeasonModel {
  String? get airDate => throw _privateConstructorUsedError;
  int? get episodeCount => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  String? get posterPath => throw _privateConstructorUsedError;
  int? get seasonNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SeasonModelCopyWith<SeasonModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeasonModelCopyWith<$Res> {
  factory $SeasonModelCopyWith(
          SeasonModel value, $Res Function(SeasonModel) then) =
      _$SeasonModelCopyWithImpl<$Res, SeasonModel>;
  @useResult
  $Res call(
      {String? airDate,
      int? episodeCount,
      int? id,
      String? name,
      String? overview,
      String? posterPath,
      int? seasonNumber});
}

/// @nodoc
class _$SeasonModelCopyWithImpl<$Res, $Val extends SeasonModel>
    implements $SeasonModelCopyWith<$Res> {
  _$SeasonModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? airDate = freezed,
    Object? episodeCount = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? seasonNumber = freezed,
  }) {
    return _then(_value.copyWith(
      airDate: freezed == airDate
          ? _value.airDate
          : airDate // ignore: cast_nullable_to_non_nullable
              as String?,
      episodeCount: freezed == episodeCount
          ? _value.episodeCount
          : episodeCount // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      seasonNumber: freezed == seasonNumber
          ? _value.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SeasonModelCopyWith<$Res>
    implements $SeasonModelCopyWith<$Res> {
  factory _$$_SeasonModelCopyWith(
          _$_SeasonModel value, $Res Function(_$_SeasonModel) then) =
      __$$_SeasonModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? airDate,
      int? episodeCount,
      int? id,
      String? name,
      String? overview,
      String? posterPath,
      int? seasonNumber});
}

/// @nodoc
class __$$_SeasonModelCopyWithImpl<$Res>
    extends _$SeasonModelCopyWithImpl<$Res, _$_SeasonModel>
    implements _$$_SeasonModelCopyWith<$Res> {
  __$$_SeasonModelCopyWithImpl(
      _$_SeasonModel _value, $Res Function(_$_SeasonModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? airDate = freezed,
    Object? episodeCount = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? overview = freezed,
    Object? posterPath = freezed,
    Object? seasonNumber = freezed,
  }) {
    return _then(_$_SeasonModel(
      airDate: freezed == airDate
          ? _value.airDate
          : airDate // ignore: cast_nullable_to_non_nullable
              as String?,
      episodeCount: freezed == episodeCount
          ? _value.episodeCount
          : episodeCount // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      seasonNumber: freezed == seasonNumber
          ? _value.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_SeasonModel implements _SeasonModel {
  const _$_SeasonModel(
      {this.airDate,
      this.episodeCount,
      this.id,
      this.name,
      this.overview,
      this.posterPath,
      this.seasonNumber});

  factory _$_SeasonModel.fromJson(Map<String, dynamic> json) =>
      _$$_SeasonModelFromJson(json);

  @override
  final String? airDate;
  @override
  final int? episodeCount;
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? overview;
  @override
  final String? posterPath;
  @override
  final int? seasonNumber;

  @override
  String toString() {
    return 'SeasonModel(airDate: $airDate, episodeCount: $episodeCount, id: $id, name: $name, overview: $overview, posterPath: $posterPath, seasonNumber: $seasonNumber)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SeasonModel &&
            (identical(other.airDate, airDate) || other.airDate == airDate) &&
            (identical(other.episodeCount, episodeCount) ||
                other.episodeCount == episodeCount) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.seasonNumber, seasonNumber) ||
                other.seasonNumber == seasonNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, airDate, episodeCount, id, name,
      overview, posterPath, seasonNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SeasonModelCopyWith<_$_SeasonModel> get copyWith =>
      __$$_SeasonModelCopyWithImpl<_$_SeasonModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SeasonModelToJson(
      this,
    );
  }
}

abstract class _SeasonModel implements SeasonModel {
  const factory _SeasonModel(
      {final String? airDate,
      final int? episodeCount,
      final int? id,
      final String? name,
      final String? overview,
      final String? posterPath,
      final int? seasonNumber}) = _$_SeasonModel;

  factory _SeasonModel.fromJson(Map<String, dynamic> json) =
      _$_SeasonModel.fromJson;

  @override
  String? get airDate;
  @override
  int? get episodeCount;
  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get overview;
  @override
  String? get posterPath;
  @override
  int? get seasonNumber;
  @override
  @JsonKey(ignore: true)
  _$$_SeasonModelCopyWith<_$_SeasonModel> get copyWith =>
      throw _privateConstructorUsedError;
}
