import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/core/usecase/usecase.dart';
import 'package:aspectumai/features/chat/domain/repositories/image_picker_repository.dart';
import 'package:image_picker/image_picker.dart';

class PickImageUseCase extends UseCase<DataState<List<XFile>>, NoParams> {
  final ImagePickerRepository _repository;

  PickImageUseCase(this._repository);

  @override
  Future<DataState<List<XFile>>> call(NoParams params) {
    return _repository.pickImage();
  }
}
