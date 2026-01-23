import 'package:flutter/material.dart';
import '../../../../../../configs/theme/theme_exports.dart';
import '../../../../../../core/constants/constants_exports.dart';
import '../../../../../../core/widgets/settings_switch.dart';
import '../../../widgets/settings_widgets/notification_settings_section.dart';

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
