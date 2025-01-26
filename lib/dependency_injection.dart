import 'package:flutter_gemini_ai/features/chat/domain/repositories/image_picker_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import 'features/chat/data/repositories/image_picker_repository_impl.dart';
import 'features/chat/domain/usecases/pick_image.dart';
import 'features/chat/screen/bloc/image_picker/image_picker_cubit.dart';

final sl = GetIt.instance;

Future<void> registerDependencies() async {
  final imagePicker = ImagePicker();

  sl.registerLazySingleton(() => imagePicker);

  /// repositories
  sl.registerLazySingleton<ImagePickerRepository>(
    () => ImagePickerRepositoryImpl(imagePicker: sl()),
  );

  /// usecases
  sl.registerLazySingleton(() => PickImageUseCase(sl()));

  /// bloc
  sl.registerFactory(() => ImagePickerCubit(sl()));
}
