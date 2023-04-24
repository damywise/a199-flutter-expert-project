import 'package:ditonton/domain/usecases/get_episode_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetEpisodeDetail usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetEpisodeDetail(mockSeriesRepository);
  });

  const tId = 1;

  test('should get series detail from the repository', () async {
    // arrange
    when(
      mockSeriesRepository.getEpisodeDetail(
        tId,
        testSeasonDetail.id,
        testEpisode.id,
      ),
    ).thenAnswer((_) async => Right(testEpisode));
    // act
    final result =
        await usecase.execute(tId, testSeasonDetail.id, testEpisode.id!);
    // assert
    expect(result, Right(testEpisode));
  });
}
