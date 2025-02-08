import 'package:aspectumai/core/resources/data_state.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImagePickerRepository {
  Future<DataState<List<XFile>>> pickImage();
}
