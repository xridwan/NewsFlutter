sealed class NotificationState {
  const NotificationState();
}

final class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

final class NotificationLoaded extends NotificationState {
  final bool isEnabled;

  const NotificationLoaded(this.isEnabled);
}
