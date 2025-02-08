import 'package:aspectumai/core/resources/constants.dart';
import 'package:aspectumai/features/chat/data/data_sources/chat_source.dart';
import 'package:aspectumai/features/chat/data/data_sources/gemini_source.dart';
import 'package:aspectumai/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:aspectumai/features/chat/domain/repositories/chat_repository.dart';
import 'package:aspectumai/features/chat/domain/repositories/image_picker_repository.dart';
import 'package:aspectumai/features/chat/domain/usecases/send_chat.dart';
import 'package:aspectumai/features/chat/domain/usecases/send_chat_with_image.dart';
import 'package:aspectumai/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

import 'features/chat/data/repositories/image_picker_repository_impl.dart';
import 'features/chat/domain/usecases/pick_image.dart';
import 'features/chat/presentation/bloc/image_picker/image_picker_cubit.dart';

final sl = GetIt.instance;

Future<void> registerDependencies() async {
  final imagePicker = ImagePicker();
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    // model: 'gemini-pro',
    apiKey: APIKEY,
  );

  sl.registerLazySingleton(() => imagePicker);

  /// source
  sl.registerLazySingleton<ChatSource>(
    () => GeminiSource(model: model),
  );

  /// repositories
  sl.registerLazySingleton<ImagePickerRepository>(
    () => ImagePickerRepositoryImpl(imagePicker: sl()),
  );
  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl()));

  /// usecases
  sl.registerLazySingleton(() => PickImageUseCase(sl()));
  sl.registerLazySingleton(() => SendChatUsecase(sl()));
  sl.registerLazySingleton(() => SendChatWithImageUsecase(sl()));

  /// bloc
  sl.registerFactory(() => ImagePickerCubit(sl()));
  sl.registerFactory(() => ChatBloc(sl(), sl()));
}
