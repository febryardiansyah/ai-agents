import 'package:aspectumai/core/resources/data_state.dart';
import 'package:aspectumai/core/usecase/usecase.dart';
import 'package:aspectumai/features/chat/domain/repositories/chat_repository.dart';

class SendChatUsecase extends UseCase<DataState<String>, String> {
  final ChatRepository _chatRepository;

  SendChatUsecase(this._chatRepository);

  @override
  Future<DataState<String>> call(String params) {
    return _chatRepository.sendMessage(params);
  }
}
