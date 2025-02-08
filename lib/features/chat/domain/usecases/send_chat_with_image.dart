import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/core/usecase/usecase.dart';
import 'package:aspectumai/features/chat/domain/repositories/chat_repository.dart';

class SendChatWithImageUsecase
    extends UseCase<DataState<String>, ChatWithImageParams> {
  final ChatRepository _chatRepository;

  SendChatWithImageUsecase(this._chatRepository);

  @override
  Future<DataState<String>> call(ChatWithImageParams params) {
    return _chatRepository.sendMessageWithImage(
      params.message,
      params.imagePaths,
    );
  }
}

final class ChatWithImageParams {
  final String message;
  final List<String> imagePaths;

  ChatWithImageParams({
    required this.message,
    required this.imagePaths,
  });
}
