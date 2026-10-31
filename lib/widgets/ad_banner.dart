import 'package:flutter/material.dart';

import '../core/app_flags.dart';
import '../theme/app_theme.dart';

/// Bottom ad slot. Hidden whenever [AppFlags.showAds] is false.
///
/// This is a placeholder box. To earn revenue, swap the body for an AdMob
/// `BannerAd` widget; the toggle and the premium switch keep working.
class AdBanner extends StatelessWidget {
  const AdBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppFlags.instance,
      builder: (context, _) {
        if (!AppFlags.instance.showAds) return const SizedBox.shrink();
        return SafeArea(
          top: false,
          child: Container(
            height: 58,
            margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            decoration: BoxDecoration(
              color: AppColors.yellowSoft,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.yellow, width: 1.2),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Text(
                    'Your ad here',
                    style: TextStyle(
                      color: AppColors.ink,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  left: 8,
                  child: Text(
                    'AD',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink.withValues(alpha: 0.55),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
