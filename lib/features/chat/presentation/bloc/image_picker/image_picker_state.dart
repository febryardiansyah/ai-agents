part of 'image_picker_cubit.dart';

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
