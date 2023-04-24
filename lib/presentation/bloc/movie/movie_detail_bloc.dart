import 'package:bloc_use_case_generator/bloc_generator.dart';
import 'package:ditonton/data/models/global_failure_model.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_detail_bloc.g.dart';

abstract class MovieDetailEvent {}

abstract class MovieDetailState {}

@BlocAnnotation(
  baseEventType: MovieDetailEvent,
  baseStateType: MovieDetailState,
  failureModel: GlobalFailureModel,
  blocUseCases: [
    BlocUseCase(
      name: 'GetMovieDetail',
      input: {
        'id': int,
      },
      output: {'movie': MovieDetail},
    ),
  ],
)
class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc({
    required this.getMovieDetail,
  }) : super(InitialMovieDetailState()) {
    on<GetMovieDetailEvent>(_onGetMovieDetail);
  }

  final GetMovieDetail getMovieDetail;

  Future<void> _onGetMovieDetail(
      GetMovieDetailEvent event, Emitter<MovieDetailState> emit) async {
    emit(GetMovieDetailInProgressState());

    final detailResult = await getMovieDetail.execute(event.id);
    detailResult.fold(
      (failure) {
        emit(
          GetMovieDetailFailedState(
            failure: GlobalFailureModel(message: failure.message),
          ),
        );
      },
      (movie) {
        emit(GetMovieDetailCompletedState(movie: movie));
      },
    );
  }
}
