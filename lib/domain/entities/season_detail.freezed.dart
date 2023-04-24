// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'season_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SeasonDetail {
  int get id => throw _privateConstructorUsedError;
  String get airDate => throw _privateConstructorUsedError;
  List<Episode> get episodes => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get overview => throw _privateConstructorUsedError;
  int? get seasonDetailModelId => throw _privateConstructorUsedError;
  String get posterPath => throw _privateConstructorUsedError;
  int get seasonNumber => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SeasonDetailCopyWith<SeasonDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeasonDetailCopyWith<$Res> {
  factory $SeasonDetailCopyWith(
          SeasonDetail value, $Res Function(SeasonDetail) then) =
      _$SeasonDetailCopyWithImpl<$Res, SeasonDetail>;
  @useResult
  $Res call(
      {int id,
      String airDate,
      List<Episode> episodes,
      String name,
      String overview,
      int? seasonDetailModelId,
      String posterPath,
      int seasonNumber});
}

/// @nodoc
class _$SeasonDetailCopyWithImpl<$Res, $Val extends SeasonDetail>
    implements $SeasonDetailCopyWith<$Res> {
  _$SeasonDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? airDate = null,
    Object? episodes = null,
    Object? name = null,
    Object? overview = null,
    Object? seasonDetailModelId = freezed,
    Object? posterPath = null,
    Object? seasonNumber = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      airDate: null == airDate
          ? _value.airDate
          : airDate // ignore: cast_nullable_to_non_nullable
              as String,
      episodes: null == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      seasonDetailModelId: freezed == seasonDetailModelId
          ? _value.seasonDetailModelId
          : seasonDetailModelId // ignore: cast_nullable_to_non_nullable
              as int?,
      posterPath: null == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String,
      seasonNumber: null == seasonNumber
          ? _value.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SeasonDetailCopyWith<$Res>
    implements $SeasonDetailCopyWith<$Res> {
  factory _$$_SeasonDetailCopyWith(
          _$_SeasonDetail value, $Res Function(_$_SeasonDetail) then) =
      __$$_SeasonDetailCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String airDate,
      List<Episode> episodes,
      String name,
      String overview,
      int? seasonDetailModelId,
      String posterPath,
      int seasonNumber});
}

/// @nodoc
class __$$_SeasonDetailCopyWithImpl<$Res>
    extends _$SeasonDetailCopyWithImpl<$Res, _$_SeasonDetail>
    implements _$$_SeasonDetailCopyWith<$Res> {
  __$$_SeasonDetailCopyWithImpl(
      _$_SeasonDetail _value, $Res Function(_$_SeasonDetail) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? airDate = null,
    Object? episodes = null,
    Object? name = null,
    Object? overview = null,
    Object? seasonDetailModelId = freezed,
    Object? posterPath = null,
    Object? seasonNumber = null,
  }) {
    return _then(_$_SeasonDetail(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      airDate: null == airDate
          ? _value.airDate
          : airDate // ignore: cast_nullable_to_non_nullable
              as String,
      episodes: null == episodes
          ? _value._episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      seasonDetailModelId: freezed == seasonDetailModelId
          ? _value.seasonDetailModelId
          : seasonDetailModelId // ignore: cast_nullable_to_non_nullable
              as int?,
      posterPath: null == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String,
      seasonNumber: null == seasonNumber
          ? _value.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_SeasonDetail implements _SeasonDetail {
  const _$_SeasonDetail(
      {required this.id,
      required this.airDate,
      required final List<Episode> episodes,
      required this.name,
      required this.overview,
      required this.seasonDetailModelId,
      required this.posterPath,
      required this.seasonNumber})
      : _episodes = episodes;

  @override
  final int id;
  @override
  final String airDate;
  final List<Episode> _episodes;
  @override
  List<Episode> get episodes {
    if (_episodes is EqualUnmodifiableListView) return _episodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_episodes);
  }

  @override
  final String name;
  @override
  final String overview;
  @override
  final int? seasonDetailModelId;
  @override
  final String posterPath;
  @override
  final int seasonNumber;

  @override
  String toString() {
    return 'SeasonDetail(id: $id, airDate: $airDate, episodes: $episodes, name: $name, overview: $overview, seasonDetailModelId: $seasonDetailModelId, posterPath: $posterPath, seasonNumber: $seasonNumber)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SeasonDetail &&
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
  _$$_SeasonDetailCopyWith<_$_SeasonDetail> get copyWith =>
      __$$_SeasonDetailCopyWithImpl<_$_SeasonDetail>(this, _$identity);
}

abstract class _SeasonDetail implements SeasonDetail {
  const factory _SeasonDetail(
      {required final int id,
      required final String airDate,
      required final List<Episode> episodes,
      required final String name,
      required final String overview,
      required final int? seasonDetailModelId,
      required final String posterPath,
      required final int seasonNumber}) = _$_SeasonDetail;

  @override
  int get id;
  @override
  String get airDate;
  @override
  List<Episode> get episodes;
  @override
  String get name;
  @override
  String get overview;
  @override
  int? get seasonDetailModelId;
  @override
  String get posterPath;
  @override
  int get seasonNumber;
  @override
  @JsonKey(ignore: true)
  _$$_SeasonDetailCopyWith<_$_SeasonDetail> get copyWith =>
      throw _privateConstructorUsedError;
}
