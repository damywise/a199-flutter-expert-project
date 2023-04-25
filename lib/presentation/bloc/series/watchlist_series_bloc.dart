import 'dart:async';

import 'package:bloc_use_case_generator/bloc_generator.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_series_bloc.g.dart';

@BlocAnnotation(
  baseEventType: WatchlistSeriesEvent,
  baseStateType: WatchlistSeriesState,
  failureModel: GlobalFailureModel,
  blocUseCases: [
    BlocUseCase(
      name: 'GetWatchlistSeries',
      output: {'series': List<Series>},
    ),
    BlocUseCase(
      name: 'AddWatchlistSeries',
      input: {
        'series': SeriesDetail,
      },
      output: {
        'message': String,
      },
    ),
    BlocUseCase(
      name: 'RemoveWatchlistSeries',
      input: {
        'series': SeriesDetail,
      },
      output: {
        'message': String,
      },
    ),
    BlocUseCase(
      name: 'LoadWatchlistStatusSeries',
      input: {
        'id': int,
      },
      output: {'isAddedToWatchlist': bool},
    ),
  ],
)
abstract class WatchlistSeriesEvent {}

abstract class WatchlistSeriesState {}

class WatchlistSeriesBloc
    extends Bloc<WatchlistSeriesEvent, WatchlistSeriesState> {
  WatchlistSeriesBloc({
    required GetWatchlistSeries getWatchlistSeries,
    required GetWatchListStatus getWatchListStatus,
    required SaveWatchlistSeries saveWatchlist,
    required RemoveWatchlistSeries removeWatchlist,
  })  : _removeWatchlist = removeWatchlist,
        _saveWatchlist = saveWatchlist,
        _getWatchListStatus = getWatchListStatus,
        _getWatchlistSeries = getWatchlistSeries,
        super(InitialWatchlistSeriesEventState()) {
    on<GetWatchlistSeriesEvent>(_onGetWatchlistSeries);
    on<AddWatchlistSeriesEvent>(
      _onAddWatchlistSeries,
    );
    on<RemoveWatchlistSeriesEvent>(
      _onRemoveWatchlistSeries,
    );
    on<LoadWatchlistStatusSeriesEvent>(
      _onLoadWatchlistStatusSeries,
    );
  }

  static const _watchlistAddSuccessMessage = 'Added to Watchlist';
  static const _watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistSeries _getWatchlistSeries;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlistSeries _saveWatchlist;
  final RemoveWatchlistSeries _removeWatchlist;

  FutureOr<void> _onGetWatchlistSeries(
    GetWatchlistSeriesEvent event,
    Emitter<WatchlistSeriesState> emit,
  ) async {
    emit(GetWatchlistSeriesInProgressState());
    final result = await _getWatchlistSeries.execute();
    result.fold(
      (failure) {
        emit(
          GetWatchlistSeriesFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (series) {
        emit(GetWatchlistSeriesCompletedState(series: series));
      },
    );
  }

  FutureOr<void> _onAddWatchlistSeries(
    AddWatchlistSeriesEvent event,
    Emitter<WatchlistSeriesState> emit,
  ) async {
    emit(AddWatchlistSeriesInProgressState());
    final series = event.series;

    final detailResult = await _saveWatchlist.execute(series);
    detailResult.fold(
      (failure) {
        emit(
          AddWatchlistSeriesFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (series) {
        emit(
          AddWatchlistSeriesCompletedState(
            message: _watchlistAddSuccessMessage,
          ),
        );
      },
    );
  }

  FutureOr<void> _onRemoveWatchlistSeries(
    RemoveWatchlistSeriesEvent event,
    Emitter<WatchlistSeriesState> emit,
  ) async {
    emit(RemoveWatchlistSeriesInProgressState());

    final series = event.series;

    final detailResult = await _removeWatchlist.execute(series);
    detailResult.fold(
      (failure) {
        emit(
          RemoveWatchlistSeriesFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (series) {
        emit(
          RemoveWatchlistSeriesCompletedState(
            message: _watchlistRemoveSuccessMessage,
          ),
        );
      },
    );
  }

  FutureOr<void> _onLoadWatchlistStatusSeries(
    LoadWatchlistStatusSeriesEvent event,
    Emitter<WatchlistSeriesState> emit,
  ) async {
    final id = event.id;
    final added = await _getWatchListStatus.execute(id);
    emit(
      LoadWatchlistStatusSeriesCompletedState(isAddedToWatchlist: added),
    );
  }
}
