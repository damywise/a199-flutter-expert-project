import 'package:ditonton/domain/usecases/get_season_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeasonDetail usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetSeasonDetail(mockSeriesRepository);
  });

  const tId = 1;
  const tSId = 1;

  test('should get series detail from the repository', () async {
    // arrange
    when(mockSeriesRepository.getSeasonDetail(tId, tSId))
        .thenAnswer((_) async => Right(testSeasonDetail));
    // act
    final result = await usecase.execute(tId, tSId);
    // assert
    expect(result, Right(testSeasonDetail));
  });
}
