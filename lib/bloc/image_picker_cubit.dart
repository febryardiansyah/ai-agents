import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../utils.dart';

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

  void clearImage() {
    emit(state.copyWith(
      status: BlocStatus.initial,
      errorMessage: '',
    ));
  }
}

class ImagePickerState extends Equatable {
  final BlocStatus status;
  final List<String> imagePaths;
  final String errorMessage;

  const ImagePickerState({
    this.status = BlocStatus.initial,
    this.imagePaths = const [],
    this.errorMessage = '',
  });

  ImagePickerState copyWith({
    BlocStatus? status,
    List<String>? imagePaths,
    String? errorMessage,
  }) {
    return ImagePickerState(
      status: status ?? this.status,
      imagePaths: imagePaths ?? this.imagePaths,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, imagePaths, errorMessage];
}
