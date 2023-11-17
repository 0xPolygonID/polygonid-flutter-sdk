import 'package:flutter/material.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_colors.dart';
import 'package:polygonid_flutter_sdk_example/utils/custom_strings.dart';

enum SelectedProfile { public, private }

typedef ProfileCallback = void Function(SelectedProfile);

class ProfileRadio extends StatelessWidget {
  const ProfileRadio(SelectedProfile profile, ProfileCallback profileCallback,
      {Key? key})
      : _profile = profile,
        _profileCallback = profileCallback,
        super(key: key);

  final ProfileCallback _profileCallback;
  final SelectedProfile? _profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _makeRadioListTile(
            CustomStrings.authPublicProfile, SelectedProfile.public),
        _makeRadioListTile(
            CustomStrings.authPrivateProfile, SelectedProfile.private),
      ],
    );
  }

  Widget _makeRadioListTile(String text, SelectedProfile value) {
    return RadioListTile(
        title: Text(text),
        value: value,
        groupValue: _profile,
        activeColor: CustomColors.primaryButton,
        onChanged: (SelectedProfile? value) {
          _profileCallback(value!);
        });
  }
}
