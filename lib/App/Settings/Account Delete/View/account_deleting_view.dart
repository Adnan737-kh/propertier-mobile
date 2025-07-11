import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';

import '../view_model/account_delete_view_model.dart';

class AccountDeletionScreen extends StatelessWidget {
  AccountDeletionScreen({super.key});
  final AccountDeleteViewModel controller = Get.put(AccountDeleteViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColor.primaryColor,
        title: Text(context.local.delete_account),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.local.we_re_sorry_to_see_you_go,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),
            Text(
              context.local
                  .before_you_proceed_with_deleting_your_account_please_note,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildBulletPoint(context.local
                .all_your_personal_information_and_data_will_be_permanently_removed),
            _buildBulletPoint(context.local
                .your_profile_saved_preferences_and_history_will_be_erased),
            _buildBulletPoint(context.local.this_action_cannot_be_undone),
            const SizedBox(height: 24),
            Text(
              context.local
                  .if_you_re_sure_you_want_to_delete_your_account_please_click_the_button_below,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () => _showConfirmationDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: Text(context.local.delete_my_account),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                context.local.thank_you_for_being_a_part_of_our_community,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 18)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(() => AlertDialog(
              title: Text(context.local.confirm_account_deletion),
              content: Text(context.local
                  .are_you_absolutely_sure_you_want_to_delete_your_account_This_action_cannot_be_undone),
              actions: <Widget>[
                TextButton(
                  child: Text(context.local.cancel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                controller.isLoading.value
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: CircularProgressIndicator(),
                      )
                    : TextButton(
                        child: Text(context.local.delete,
                            style: const TextStyle(color: Colors.red)),
                        onPressed: () {
                          Navigator.of(context).pop();
                          controller.requestDeleteAccount();
                        },
                      ),
              ],
            ));
      },
    );
  }
}
