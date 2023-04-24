import 'package:bloc_use_case_generator/bloc_generator.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/season_detail.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:ditonton/domain/usecases/get_episode_detail.dart';
import 'package:ditonton/domain/usecases/get_season_detail.dart';
import 'package:ditonton/domain/usecases/get_series_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'series_detail_bloc.g.dart';

abstract class SeriesDetailEvent {}

abstract class SeriesDetailState {}

@BlocAnnotation(
  baseEventType: SeriesDetailEvent,
  baseStateType: SeriesDetailState,
  failureModel: GlobalFailureModel,
  blocUseCases: [
    BlocUseCase(
      name: 'GetSeriesDetail',
      input: {
        'id': int,
      },
      output: {'series': SeriesDetail},
    ),
  ],
)
class SeriesDetailBloc extends Bloc<SeriesDetailEvent, SeriesDetailState> {
  SeriesDetailBloc({
    required this.getSeriesDetail,
  }) : super(InitialSeriesDetailState()) {
    on<GetSeriesDetailEvent>(_onGetSeriesDetail);
  }

  final GetSeriesDetail getSeriesDetail;

  Future<void> _onGetSeriesDetail(GetSeriesDetailEvent event, Emitter<SeriesDetailState> emit) async {
    emit(GetSeriesDetailInProgressState());

    final id = event.id;

    final detailResult = await getSeriesDetail.execute(id);
    detailResult.fold(
      (failure) {
        emit(
          GetSeriesDetailFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (series) {
        emit(GetSeriesDetailCompletedState(series: series));
      },
    );
  }
}

// class SeriesDetailBloc extends Bloc<SeriesDetailEvent, SeriesDetailState> {
//
//   SeriesDetailBloc({
//     required this.getSeriesDetail,
//     required this.getSeriesRecommendations,
//     required this.getWatchListStatus,
//     required this.saveWatchlist,
//     required this.removeWatchlist,
//   });
//   static const watchlistAddSuccessMessage = 'Added to Watchlist';
//   static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
//
//   final GetSeriesDetail getSeriesDetail;
//   final GetSeriesRecommendations getSeriesRecommendations;
//   final GetWatchListStatus getWatchListStatus;
//   final SaveWatchlistSeries saveWatchlist;
//   final RemoveWatchlistSeries removeWatchlist;
//
//   late SeriesDetail _series;
//   SeriesDetail get series => _series;
//
//   RequestState _seriesState = RequestState.Empty;
//   RequestState get seriesState => _seriesState;
//
//   List<Series> _seriesRecommendations = [];
//   List<Series> get seriesRecommendations => _seriesRecommendations;
//
//   RequestState _recommendationState = RequestState.Empty;
//   RequestState get recommendationState => _recommendationState;
//
//   String _message = '';
//   String get message => _message;
//
//   bool _isAddedtoWatchlist = false;
//   bool get isAddedToWatchlist => _isAddedtoWatchlist;
//
//   Future<void> fetchSeriesDetail(int id) async {
//     _seriesState = RequestState.Loading;
//     notifyListeners();
//     final detailResult = await getSeriesDetail.execute(id);
//     final recommendationResult = await getSeriesRecommendations.execute(id);
//     detailResult.fold(
//       (failure) {
//         _seriesState = RequestState.Error;
//         _message = failure.message;
//         notifyListeners();
//       },
//       (series) {
//         _recommendationState = RequestState.Loading;
//         _series = series;
//         notifyListeners();
//         recommendationResult.fold(
//           (failure) {
//             _recommendationState = RequestState.Error;
//             _message = failure.message;
//           },
//           (series) {
//             _recommendationState = RequestState.Loaded;
//             _seriesRecommendations = series;
//           },
//         );
//         _seriesState = RequestState.Loaded;
//         notifyListeners();
//       },
//     );
//   }
//
//   String _watchlistMessage = '';
//   String get watchlistMessage => _watchlistMessage;
//
//   Future<void> addWatchlist(SeriesDetail series) async {
//     final result = await saveWatchlist.execute(series);
//
//     await result.fold(
//       (failure) async {
//         _watchlistMessage = failure.message;
//       },
//       (successMessage) async {
//         _watchlistMessage = successMessage;
//       },
//     );
//
//     await loadWatchlistStatus(series.id);
//   }
//
//   Future<void> removeFromWatchlist(SeriesDetail series) async {
//     final result = await removeWatchlist.execute(series);
//
//     await result.fold(
//       (failure) async {
//         _watchlistMessage = failure.message;
//       },
//       (successMessage) async {
//         _watchlistMessage = successMessage;
//       },
//     );
//
//     await loadWatchlistStatus(series.id);
//   }
//
//   Future<void> loadWatchlistStatus(int id) async {
//     final result = await getWatchListStatus.execute(id);
//     _isAddedtoWatchlist = result;
//     notifyListeners();
//   }
// }
