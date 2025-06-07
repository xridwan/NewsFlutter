import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/settings/presentation/widget/app_bar_widget.dart';

import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            navigateBack: () {
              context.pop();
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              return SwitchListTile(
                title: const Text('Daily Notification'),
                value: state is NotificationLoaded ? state.isEnabled : false,
                onChanged: (value) {
                  context.read<NotificationBloc>().add(
                    ToggleNotificationStatus(value),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
