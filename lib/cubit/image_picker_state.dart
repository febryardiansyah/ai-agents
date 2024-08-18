part of 'image_picker_cubit.dart';

class ImagePickerState extends Equatable {
  final BlocStatus status;
  final String imagePath;
  final String errorMessage;

  const ImagePickerState({
    this.status = BlocStatus.initial,
    this.imagePath = '',
    this.errorMessage = '',
  });

  ImagePickerState copyWith({
    BlocStatus? state,
    String? imagePath,
    String? errorMessage,
  }) {
    return ImagePickerState(
      status: state ?? this.status,
      imagePath: imagePath ?? this.imagePath,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, imagePath, errorMessage];
}
