import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c17_fri/core/extentions.dart';
import 'package:evently_c17_fri/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = "OnbaordingScreen";

  const OnboardingScreen({super.key});


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    bool isEnglish = context.locale == Locale('en', 'US');
    return Scaffold(
      appBar: AppBar(title: Image.asset("assets/images/logo.png")),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          spacing: 28,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/creative.png", width: double.infinity),

            Text(
              "onboardingTitle".tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),

            Text(
              "onboardingSubTitle".tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),

            Column(
              spacing: 16,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "language".tr(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              context.setLocale(Locale('en', 'US'));
                            },
                            child: languageIconWidget("us", isEnglish, context),
                          ),
                          SizedBox(width: 16),
                          InkWell(
                            onTap: () {
                              context.setLocale(Locale('ar', 'EG'));
                            },
                            child: languageIconWidget(
                              "eg",
                              !isEnglish,
                              context,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("theme".tr(), style: context.getLargeTitle()),
                    Container(
                      padding: EdgeInsets.only(
                        right: provider.themeMode == ThemeMode.dark ? 0 : 4,
                        left: provider.themeMode == ThemeMode.light ? 0 : 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          width: 2,
                          color: context.getThemeObject().colorScheme.primary,
                        ),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              provider.changeTheme(ThemeMode.light);
                            },
                            child: themeIconWidget(
                              "sun",
                              provider.themeMode != ThemeMode.light,
                              context,
                            ),
                          ),
                          SizedBox(width: 16),
                          InkWell(
                            onTap: () {
                              provider.changeTheme(ThemeMode.dark);
                            },
                            child: themeIconWidget(
                              "moon",
                              provider.themeMode == ThemeMode.light,
                              context,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: context.getThemeObject().colorScheme.primary,
                ),
                child: Text(
                  "start".tr(),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget themeIconWidget(
    String iconName,
    bool isSelected,
    BuildContext context,
  ) {
    return Container(
      decoration: isSelected
          ? null
          : BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Theme.of(context).colorScheme.primary,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 5,
              ),
            ),
      child: ImageIcon(
        AssetImage("assets/images/$iconName.png"),
        color: !isSelected
            ? Theme.of(context).colorScheme.surface
            : Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget languageIconWidget(
    String iconName,
    bool isSelected,
    BuildContext context,
  ) {
    return Container(
      decoration: !isSelected
          ? null
          : BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 5,
              ),
            ),
      child: Image.asset(
        "assets/images/$iconName.png",
        width: 24,
        height: 24,
        fit: BoxFit.cover,
      ),
    );
  }
}
