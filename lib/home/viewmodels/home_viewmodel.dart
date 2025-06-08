import 'package:interactive_calendar/data/repositories/auth/auth_repository_remote.dart';

class HomeViewModel {
  HomeViewModel(
      {required AuthRepositoryRemote authRepository})
      : _authRepository = authRepository;

  final AuthRepositoryRemote _authRepository;

  String getCurrentUserId() {
    return _authRepository.getCurrentUserId();
  }
}
