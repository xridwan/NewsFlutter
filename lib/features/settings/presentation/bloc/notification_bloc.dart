import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/notification/notification_service.dart';
import '../../data/notification_preferences.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationPreferences notificationPreferences;
  final NotificationService notificationService;

  NotificationBloc(this.notificationPreferences, this.notificationService)
    : super(NotificationInitial()) {
    on<IsNotificationChecked>((event, emit) async {
      final isEnabled = await notificationPreferences.isEnabled();
      emit(NotificationLoaded(isEnabled));
    });

    on<ToggleNotificationStatus>((event, emit) async {
      await notificationPreferences.setEnabled(event.value);
      await notificationService.scheduleIfEnabled(notificationPreferences);
      emit(NotificationLoaded(event.value));
    });
  }
}
