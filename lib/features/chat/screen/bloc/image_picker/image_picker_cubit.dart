import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini_ai/core/constants/constants.dart';
import 'package:flutter_gemini_ai/core/resources/data_state.dart';
import 'package:flutter_gemini_ai/features/chat/domain/usecases/pick_image.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit(PickImageUseCase pickImageUsecase)
      : _repo = pickImageUsecase,
        super(const ImagePickerState());
  final PickImageUseCase _repo;

  void pickImage() async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      final data = await _repo.call();

      if (data is DataSuccess) {
        emit(state.copyWith(
          status: BlocStatus.loaded,
          imagePaths: data.data?.map((e) => e.path).toList(),
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

