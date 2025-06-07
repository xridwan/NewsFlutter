sealed class NotificationEvent {
  const NotificationEvent();
}

final class IsNotificationChecked extends NotificationEvent {
  const IsNotificationChecked();
}

final class ToggleNotificationStatus extends NotificationEvent {
  final bool value;

  const ToggleNotificationStatus(this.value);
}
