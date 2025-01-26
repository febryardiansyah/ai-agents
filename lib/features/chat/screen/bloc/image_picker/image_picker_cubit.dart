import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini_ai/core/constants/constants.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_state.dart';


class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit(ImagePicker picker)
      : _picker = picker,
        super(const ImagePickerState());
  final ImagePicker _picker;

  void pickImage() async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      final images = await _picker.pickMultiImage();

      if (images.isNotEmpty) {
        emit(state.copyWith(
          status: BlocStatus.loaded,
          imagePaths: images.map((e) => e.path).toList(),
        ));
      } else {
        emit(state.copyWith(
          status: BlocStatus.error,
          errorMessage: 'No images selected',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: BlocStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void removeImage(String path) {
    emit(state.copyWith(
      imagePaths: state.imagePaths.where((e) => e != path).toList(),
    ));
  }

  void clearImage() {
    emit(state.copyWith(
      status: BlocStatus.initial,
      errorMessage: '',
    ));
  }
}

