import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../configs/theme/theme_exports.dart';
import '../../../../../../core/constants/constants_exports.dart';
import '../../../../../../core/widgets/settings_switch.dart';
import '../../../bloc/settings_screen_bloc/notification_screen_bloc/notification_settings_bloc.dart';
import '../../../bloc/settings_screen_bloc/notification_screen_bloc/notification_settings_event.dart';
import '../../../bloc/settings_screen_bloc/notification_screen_bloc/notification_settings_state.dart';
import '../../../widgets/settings_widgets/notification_settings_section.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationSettingsBloc(),
      child: BlocBuilder<NotificationSettingsBloc, NotificationSettingsState>(
        builder: (context, state) {
          final bloc = context.read<NotificationSettingsBloc>();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Notification Settings'),
              leading: const BackButton(),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.paddingM,
                AppSizes.paddingS,
                AppSizes.paddingM,
                AppSizes.paddingL,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mute All
                  SettingsSection(
                    children: [
                      SettingsSwitchTile(
                        title: 'Mute All Notifications',
                        value: state.muteAll,
                        onChanged: (v) => bloc.add(ToggleMuteAll(v)),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingM),

                  // General
                  _sectionTitle(context, 'General'),
                  SettingsSection(
                    children: [
                      SettingsSwitchTile(
                        title: 'Push Notifications',
                        value: state.push,
                        onChanged:
                            state.muteAll
                                ? (_) {}
                                : (v) => bloc.add(TogglePush(v)),
                      ),
                      SettingsSwitchTile(
                        title: 'Email Notifications',
                        value: state.email,
                        onChanged:
                            state.muteAll
                                ? (_) {}
                                : (v) => bloc.add(ToggleEmail(v)),
                      ),
                      SettingsSwitchTile(
                        title: 'In App Notifications',
                        value: state.inApp,
                        onChanged:
                            state.muteAll
                                ? (_) {}
                                : (v) => bloc.add(ToggleInApp(v)),
                      ),
                    ],
                  ),

                  // My Listings
                  const SizedBox(height: AppSizes.paddingM),
                  _sectionTitle(context, 'My Listings'),
                  SettingsSection(
                    children: [
                      SettingsSwitchTile(
                        title: 'Listing Status',
                        value: state.listingStatus,
                        onChanged:
                            state.muteAll
                                ? (_) {}
                                : (v) => bloc.add(ToggleListingStatus(v)),
                      ),
                      SettingsSwitchTile(
                        title: 'Listing Reminders',
                        value: state.listingReminders,
                        onChanged:
                            state.muteAll
                                ? (_) {}
                                : (v) => bloc.add(ToggleListingReminders(v)),
                      ),
                    ],
                  ),

                  // Messages & Chats
                  const SizedBox(height: AppSizes.paddingM),
                  _sectionTitle(context, 'Messages & Chats'),
                  SettingsSection(
                    children: [
                      SettingsSwitchTile(
                        title: 'New Message',
                        value: state.newMessage,
                        onChanged:
                            state.muteAll
                                ? (_) {}
                                : (v) => bloc.add(ToggleNewMessage(v)),
                      ),
                      SettingsSwitchTile(
                        title: 'Response Reminders',
                        value: state.responseReminders,
                        onChanged:
                            state.muteAll
                                ? (_) {}
                                : (v) => bloc.add(ToggleResponseReminders(v)),
                      ),
                    ],
                  ),

                  // Discovery
                  const SizedBox(height: AppSizes.paddingM),
                  _sectionTitle(context, 'Discovery'),
                  SettingsSection(
                    children: [
                      SettingsSwitchTile(
                        title: 'New items near you',
                        value: state.discovery,
                        onChanged:
                            state.muteAll
                                ? (_) {}
                                : (v) => bloc.add(ToggleDiscovery(v)),
                      ),
                    ],
                  ),

                  // System
                  const SizedBox(height: AppSizes.paddingM),
                  _sectionTitle(context, 'System'),
                  SettingsSection(
                    children: [
                      SettingsSwitchTile(
                        title: 'Account & Identity Verification',
                        value: state.system,
                        onChanged:
                            state.muteAll
                                ? (_) {}
                                : (v) => bloc.add(ToggleSystem(v)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.paddingXS),
      child: Text(
        title,
        style: AppTypography.body16Medium.copyWith(
          color: context.colors.titles,
        ),
      ),
    );
  }
}

/*
class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool muteAll = false;

  bool push = true;
  bool email = false;
  bool inApp = false;

  bool listingStatus = true;
  bool listingReminders = true;

  bool newMessage = true;
  bool responseReminders = true;

  bool discovery = true;
  bool system = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.paddingM,
          AppSizes.paddingS,
          AppSizes.paddingM,
          AppSizes.paddingL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsSection(
              children: [
                SettingsSwitchTile(
                  title: 'Mute All Notifications',
                  value: muteAll,
                  onChanged: (v) {
                    setState(() {
                      muteAll = v;
                      push = !v;
                      email = !v;
                      inApp = !v;
                      listingStatus = !v;
                      listingReminders = !v;
                      newMessage = !v;
                      responseReminders = !v;
                      discovery = !v;
                      system = !v;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: AppSizes.paddingM),

            _sectionTitle('General'),
            SettingsSection(
              children: [
                SettingsSwitchTile(
                  title: 'Push Notifications',
                  value: push,
                  onChanged: muteAll ? (_) {} : (v) => setState(() => push = v),
                ),
                SettingsSwitchTile(
                  title: 'Email Notifications',
                  value: email,
                  onChanged:
                      muteAll ? (_) {} : (v) => setState(() => email = v),
                ),
                SettingsSwitchTile(
                  title: 'In App Notifications',
                  value: inApp,
                  onChanged:
                      muteAll ? (_) {} : (v) => setState(() => inApp = v),
                ),
              ],
            ),

            const SizedBox(height: AppSizes.paddingM),

            _sectionTitle('My Listings'),
            SettingsSection(
              children: [
                SettingsSwitchTile(
                  title: 'Listing Status',
                  value: listingStatus,
                  onChanged:
                      muteAll
                          ? (_) {}
                          : (v) => setState(() => listingStatus = v),
                ),
                SettingsSwitchTile(
                  title: 'Listing Reminders',
                  value: listingReminders,
                  onChanged:
                      muteAll
                          ? (_) {}
                          : (v) => setState(() => listingReminders = v),
                ),
              ],
            ),

            const SizedBox(height: AppSizes.paddingM),

            _sectionTitle('Messages & Chats'),
            SettingsSection(
              children: [
                SettingsSwitchTile(
                  title: 'New Message',
                  value: newMessage,
                  onChanged:
                      muteAll ? (_) {} : (v) => setState(() => newMessage = v),
                ),
                SettingsSwitchTile(
                  title: 'Response Reminders',
                  value: responseReminders,
                  onChanged:
                      muteAll
                          ? (_) {}
                          : (v) => setState(() => responseReminders = v),
                ),
              ],
            ),

            const SizedBox(height: AppSizes.paddingM),

            _sectionTitle('Discovery'),
            SettingsSection(
              children: [
                SettingsSwitchTile(
                  title: 'New items near you',
                  value: discovery,
                  onChanged:
                      muteAll ? (_) {} : (v) => setState(() => discovery = v),
                ),
              ],
            ),

            const SizedBox(height: AppSizes.paddingM),

            _sectionTitle('System'),
            SettingsSection(
              children: [
                SettingsSwitchTile(
                  title: 'Account & Identity Verification',
                  value: system,
                  onChanged:
                      muteAll ? (_) {} : (v) => setState(() => system = v),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.paddingXS),
      child: Text(
        title,
        style: AppTypography.body16Medium.copyWith(
          color: context.colors.titles,
        ),
      ),
    );
  }
}
*/
