import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/core/usecase/usecase.dart';
import 'package:aspectumai/features/chat/domain/repositories/image_picker_repository.dart';
import 'package:aspectumai/features/chat/domain/usecases/pick_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockImagePickerRepository extends Mock implements ImagePickerRepository {}

void main() {
  late ImagePickerRepository mockImagePickerRepository;
  late PickImageUseCase pickImageUseCase;

  setUp(() {
    mockImagePickerRepository = MockImagePickerRepository();
    pickImageUseCase = PickImageUseCase(mockImagePickerRepository);
  });

  group('PickImageUseCase', () {
    test('pick image success', () async {
      when(() => mockImagePickerRepository.pickImage()).thenAnswer(
        (_) async => DataSuccess([XFile('path')]),
      );

      final result = await pickImageUseCase.call(NoParams());

      expect(result, isA<DataSuccess>());
      expect(result.data![0].path, 'path');

      verify(() => mockImagePickerRepository.pickImage()).called(1);
    });

    test('pick image error', () async {
      when(() => mockImagePickerRepository.pickImage()).thenAnswer(
        (_) async => DataError('error'),
      );

      final result = await pickImageUseCase.call(NoParams());

      expect(result, isA<DataError>());
      expect(result.error, 'error');

      verify(() => mockImagePickerRepository.pickImage()).called(1);
    });
  });
}
