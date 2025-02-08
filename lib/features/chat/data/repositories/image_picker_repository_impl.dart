import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/features/chat/domain/repositories/image_picker_repository.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerRepositoryImpl implements ImagePickerRepository {
  final ImagePicker imagePicker;

  ImagePickerRepositoryImpl({required this.imagePicker});

  @override
  Future<DataState<List<XFile>>> pickImage() async {
    try {
      final images = await imagePicker.pickMultiImage();
      return DataSuccess(images);
    } catch (e) {
      return DataError(e.toString());
    }
  }
}
