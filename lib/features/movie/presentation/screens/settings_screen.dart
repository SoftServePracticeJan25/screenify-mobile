import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenify/config/constants/app_colors.dart';
import 'package:screenify/config/constants/app_images.dart';
import 'package:screenify/features/movie/presentation/blocs/app_bloc/app_bloc.dart';
import 'package:screenify/features/movie/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _takePhoto(BuildContext context) async {
    final ImagePicker imagePicker = ImagePicker();
    final authBloc = context.read<AuthBloc>();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    authBloc.add(UploadAvatarEvent(file: image));
  }

  Widget _settingsTile(String title, Widget child, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .color!
                      .withValues(alpha: 0.8),
                ),
          ),
          const Spacer(),
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final UserInfo userInfo =
    //     (context.watch<AuthBloc>().state as AuthLoaded).userInfo;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final userInfo = (state as AuthLoaded).userInfo;
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                MediaQuery.of(context).platformBrightness == Brightness.dark
                    ? AppImages.mainBackgroundDark
                    : AppImages.mainBackgroundLight,
              ),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await _takePhoto(context);
                  },
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 5,
                    backgroundImage: userInfo.photoUrl.isNotEmpty
                        ? NetworkImage(userInfo.photoUrl)
                        : null,
                    child: userInfo.photoUrl.isEmpty
                        ? Icon(
                            size: 48,
                            Platform.isIOS
                                ? CupertinoIcons.camera
                                : Icons.camera,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.hi(userInfo.username),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 2,
                          color: AppColors.black20,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.accountSettings,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          const Divider(
                            color: AppColors.settingsBorderDark,
                          ),
                          _settingsTile(
                            AppLocalizations.of(context)!.username,
                            Text(userInfo.username),
                            context,
                          ),
                          _settingsTile(
                            AppLocalizations.of(context)!.email,
                            Text(
                              userInfo.email,
                            ),
                            context,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 2,
                          color: AppColors.black20,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.appSettings,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          const Divider(
                            color: AppColors.settingsBorderDark,
                          ),
                          _settingsTile(
                            AppLocalizations.of(context)!.language,
                            DropdownButton<String>(
                              dropdownColor: Theme.of(context).primaryColor,
                              value: context
                                  .watch<AppBloc>()
                                  .state
                                  .locale
                                  ?.languageCode,
                              items: [
                                DropdownMenuItem(
                                  value: 'en',
                                  child: SizedBox(
                                    // width: MediaQuery.of(context).size.width / 3,
                                    child: Text(
                                      AppLocalizations.of(context)!.english,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'uk',
                                  child: Text(
                                    AppLocalizations.of(context)!.ukrainian,
                                  ),
                                ),
                              ],
                              onChanged: (String? value) {
                                if (value == null) return;
                                context
                                    .read<AppBloc>()
                                    .add(ChangeLocaleEvent(value));
                              },
                            ),
                            context,
                          ),
                          _settingsTile(
                            AppLocalizations.of(context)!.theme,
                            DropdownButton<ThemeMode>(
                              dropdownColor: Theme.of(context).primaryColor,
                              value: context.watch<AppBloc>().state.themeMode,
                              items: [
                                DropdownMenuItem(
                                  value: ThemeMode.system,
                                  child: SizedBox(
                                    child: Text(
                                      AppLocalizations.of(context)!.system,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: ThemeMode.light,
                                  child: SizedBox(
                                    child: Text(
                                      AppLocalizations.of(context)!.light,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: ThemeMode.dark,
                                  child: SizedBox(
                                    child: Text(
                                      AppLocalizations.of(context)!.dark,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (ThemeMode? value) {
                                if (value == null) return;
                                context
                                    .read<AppBloc>()
                                    .add(ChangeThemeModeEvent(value));
                              },
                            ),
                            context,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const LogoutEvent(),
                        );
                  },
                  child: Text(AppLocalizations.of(context)!.logOut),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
