import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitter/common/loading_page.dart';
import 'package:flutter_twitter/features/auth/controller/auth_controller.dart';
import 'package:flutter_twitter/features/user_profile/view/user_profile_view.dart';
import 'package:flutter_twitter/theme/pallete.dart';

import '../../user_profile/controller/user_profile_controller.dart';

class SideDrawer extends ConsumerWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.read(authControllerProvider.notifier).logout(context);
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    if (currentUser == null) {
      return const Loader();
    }

    return SafeArea(
      child: Drawer(
        backgroundColor: Pallete.backgroundColor,
        child: Column(
          children: [
            const SizedBox(height: 50),
            ListTile(
              leading: const Icon(
                Icons.person,
                size: 30,
              ),
              title: const Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  UserProfileView.route(currentUser),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.payment,
                size: 30,
              ),
              title: const Text(
                'Twitter Blue',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              onTap: () {
                // ref
                //     .read(userProfileControllerProvider.notifier)
                //     .updateUserProfile(
                //       userModel: currentUser.copyWith(isTwitterBlue: true),
                //       context: context,
                //       bannerFile: null,
                //       profileFile: null,
                //     );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                size: 30,
              ),
              title: const Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              onTap: () {
                ref.read(authControllerProvider.notifier).logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
