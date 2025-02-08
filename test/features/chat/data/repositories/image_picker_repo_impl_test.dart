import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/features/chat/data/repositories/image_picker_repository_impl.dart';
import 'package:aspectumai/features/chat/domain/repositories/image_picker_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockImagePicker extends Mock implements ImagePicker {}

void main() {
  late ImagePicker mockImagePicker;
  late ImagePickerRepository imagePickerRepository;

  setUp(() {
    mockImagePicker = MockImagePicker();
    imagePickerRepository = ImagePickerRepositoryImpl(
      imagePicker: mockImagePicker,
    );
  });

  group('ImagePickerRepository', () {
    test('pick image success', () async {
      when(() => mockImagePicker.pickMultiImage()).thenAnswer(
        (_) async => [XFile('path')],
      );

      final result = await imagePickerRepository.pickImage();

      expect(result, isA<DataSuccess>());
      expect(result.data![0].path, 'path');

      verify(() => mockImagePicker.pickMultiImage()).called(1);
    });

    test('pick image error', () async {
      when(() => mockImagePicker.pickMultiImage()).thenThrow('error');

      final result = await imagePickerRepository.pickImage();

      expect(result, isA<DataError>());
      expect(result.error, 'error');

      verify(() => mockImagePicker.pickMultiImage()).called(1);
    });
  });
}
