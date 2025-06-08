
import 'package:interactive_calendar/data/repositories/auth/auth_repository_remote.dart';
import 'package:interactive_calendar/data/repositories/event/event_repository_remote.dart';
import 'package:interactive_calendar/data/services/auth_service.dart';
import 'package:interactive_calendar/data/services/event_service.dart';
import 'package:interactive_calendar/data/services/ui_service_local.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providersLocal {
  return [
    Provider.value(value: AuthService()),
    Provider.value(value: UiService()),
    Provider.value(value: EventService()),
    Provider(create: (context) => AuthRepositoryRemote(authService: context.read(), uiService: context.read())),
    Provider(create: (context) => EventRepositoryRemote(service: context.read())),
    ChangeNotifierProvider(create: (context) => AuthRepositoryRemote(authService: context.read(), uiService: context.read())),
  ];
}

// for production use, it's not needed for the exam, just for showcase
List<SingleChildWidget> get providersRemote {
  return [
    Provider.value(value: AuthService()),
  ];
}