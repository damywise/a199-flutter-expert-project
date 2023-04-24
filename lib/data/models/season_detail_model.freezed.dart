// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'season_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SeasonDetailModel _$SeasonDetailModelFromJson(Map<String, dynamic> json) {
  return _SeasonDetailModel.fromJson(json);
}

/// @nodoc
mixin _$SeasonDetailModel {
  int? get id => throw _privateConstructorUsedError;
  String? get airDate => throw _privateConstructorUsedError;
  List<EpisodeModel>? get episodes => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  int? get seasonDetailModelId => throw _privateConstructorUsedError;
  String? get posterPath => throw _privateConstructorUsedError;
  int? get seasonNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SeasonDetailModelCopyWith<SeasonDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeasonDetailModelCopyWith<$Res> {
  factory $SeasonDetailModelCopyWith(
          SeasonDetailModel value, $Res Function(SeasonDetailModel) then) =
      _$SeasonDetailModelCopyWithImpl<$Res, SeasonDetailModel>;
  @useResult
  $Res call(
      {int? id,
      String? airDate,
      List<EpisodeModel>? episodes,
      String? name,
      String? overview,
      int? seasonDetailModelId,
      String? posterPath,
      int? seasonNumber});
}

/// @nodoc
class _$SeasonDetailModelCopyWithImpl<$Res, $Val extends SeasonDetailModel>
    implements $SeasonDetailModelCopyWith<$Res> {
  _$SeasonDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? airDate = freezed,
    Object? episodes = freezed,
    Object? name = freezed,
    Object? overview = freezed,
    Object? seasonDetailModelId = freezed,
    Object? posterPath = freezed,
    Object? seasonNumber = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      airDate: freezed == airDate
          ? _value.airDate
          : airDate // ignore: cast_nullable_to_non_nullable
              as String?,
      episodes: freezed == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<EpisodeModel>?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      seasonDetailModelId: freezed == seasonDetailModelId
          ? _value.seasonDetailModelId
          : seasonDetailModelId // ignore: cast_nullable_to_non_nullable
              as int?,
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
abstract class _$$_SeasonDetailModelCopyWith<$Res>
    implements $SeasonDetailModelCopyWith<$Res> {
  factory _$$_SeasonDetailModelCopyWith(_$_SeasonDetailModel value,
          $Res Function(_$_SeasonDetailModel) then) =
      __$$_SeasonDetailModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? airDate,
      List<EpisodeModel>? episodes,
      String? name,
      String? overview,
      int? seasonDetailModelId,
      String? posterPath,
      int? seasonNumber});
}

/// @nodoc
class __$$_SeasonDetailModelCopyWithImpl<$Res>
    extends _$SeasonDetailModelCopyWithImpl<$Res, _$_SeasonDetailModel>
    implements _$$_SeasonDetailModelCopyWith<$Res> {
  __$$_SeasonDetailModelCopyWithImpl(
      _$_SeasonDetailModel _value, $Res Function(_$_SeasonDetailModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? airDate = freezed,
    Object? episodes = freezed,
    Object? name = freezed,
    Object? overview = freezed,
    Object? seasonDetailModelId = freezed,
    Object? posterPath = freezed,
    Object? seasonNumber = freezed,
  }) {
    return _then(_$_SeasonDetailModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      airDate: freezed == airDate
          ? _value.airDate
          : airDate // ignore: cast_nullable_to_non_nullable
              as String?,
      episodes: freezed == episodes
          ? _value._episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<EpisodeModel>?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      seasonDetailModelId: freezed == seasonDetailModelId
          ? _value.seasonDetailModelId
          : seasonDetailModelId // ignore: cast_nullable_to_non_nullable
              as int?,
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
class _$_SeasonDetailModel implements _SeasonDetailModel {
  const _$_SeasonDetailModel(
      {this.id,
      this.airDate,
      final List<EpisodeModel>? episodes,
      this.name,
      this.overview,
      this.seasonDetailModelId,
      this.posterPath,
      this.seasonNumber})
      : _episodes = episodes;

  factory _$_SeasonDetailModel.fromJson(Map<String, dynamic> json) =>
      _$$_SeasonDetailModelFromJson(json);

  @override
  final int? id;
  @override
  final String? airDate;
  final List<EpisodeModel>? _episodes;
  @override
  List<EpisodeModel>? get episodes {
    final value = _episodes;
    if (value == null) return null;
    if (_episodes is EqualUnmodifiableListView) return _episodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? name;
  @override
  final String? overview;
  @override
  final int? seasonDetailModelId;
  @override
  final String? posterPath;
  @override
  final int? seasonNumber;

  @override
  String toString() {
    return 'SeasonDetailModel(id: $id, airDate: $airDate, episodes: $episodes, name: $name, overview: $overview, seasonDetailModelId: $seasonDetailModelId, posterPath: $posterPath, seasonNumber: $seasonNumber)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SeasonDetailModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.airDate, airDate) || other.airDate == airDate) &&
            const DeepCollectionEquality().equals(other._episodes, _episodes) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.seasonDetailModelId, seasonDetailModelId) ||
                other.seasonDetailModelId == seasonDetailModelId) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.seasonNumber, seasonNumber) ||
                other.seasonNumber == seasonNumber));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      airDate,
      const DeepCollectionEquality().hash(_episodes),
      name,
      overview,
      seasonDetailModelId,
      posterPath,
      seasonNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SeasonDetailModelCopyWith<_$_SeasonDetailModel> get copyWith =>
      __$$_SeasonDetailModelCopyWithImpl<_$_SeasonDetailModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SeasonDetailModelToJson(
      this,
    );
  }
}

abstract class _SeasonDetailModel implements SeasonDetailModel {
  const factory _SeasonDetailModel(
      {final int? id,
      final String? airDate,
      final List<EpisodeModel>? episodes,
      final String? name,
      final String? overview,
      final int? seasonDetailModelId,
      final String? posterPath,
      final int? seasonNumber}) = _$_SeasonDetailModel;

  factory _SeasonDetailModel.fromJson(Map<String, dynamic> json) =
      _$_SeasonDetailModel.fromJson;

  @override
  int? get id;
  @override
  String? get airDate;
  @override
  List<EpisodeModel>? get episodes;
  @override
  String? get name;
  @override
  String? get overview;
  @override
  int? get seasonDetailModelId;
  @override
  String? get posterPath;
  @override
  int? get seasonNumber;
  @override
  @JsonKey(ignore: true)
  _$$_SeasonDetailModelCopyWith<_$_SeasonDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}
