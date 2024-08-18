import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../constant.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit(ImagePicker picker)
      : _picker = picker,
        super(const ImagePickerState());
  final ImagePicker _picker;

  void pickImage() async {
    emit(state.copyWith(state: BlocStatus.loading));

    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        emit(state.copyWith(
          state: BlocStatus.loaded,
          imagePath: image.path,
        ));
      } else {
        emit(state.copyWith(
          state: BlocStatus.error,
          errorMessage: 'No image selected',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        state: BlocStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void clearImage() {
    emit(state.copyWith(
      state: BlocStatus.initial,
      imagePath: '',
      errorMessage: '',
    ));
  }
}
