import 'package:flutter/material.dart';
import 'package:make_me_laugh/data/joke.dart';
import 'package:make_me_laugh/data/settings.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool anyCategory = true;
  late Settings settings;

  @override
  void initState() {
    settings = context.read<Settings>();
    anyCategory = settings.categories.isEmpty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: onPopInvoked,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          centerTitle: true,
        ),
        body: Builder(builder: (context) {
          return SettingsList(sections: [
            SettingsSection(
              title: const Text("Text-to-speech"),
              tiles: [
                SettingsTile.switchTile(
                  initialValue: settings.enableTextToSpeech,
                  onToggle: toggleEnableTextToSpeech,
                  title: const Text("Enabled"),
                )
              ],
            ),
            SettingsSection(title: const Text("Category"), tiles: [
              SettingsTile.switchTile(
                initialValue: anyCategory,
                onToggle: toggleAnyCategory,
                title: const Text("Any"),
              ),
              for (final category in JokeCategory.values)
                SettingsTile.switchTile(
                  initialValue: settings.categories.contains(category),
                  enabled: !anyCategory,
                  onToggle: toggleCategory(category),
                  title: Text(category.name),
                ),
            ]),
            SettingsSection(
              title: const Text("Blacklist"),
              tiles: [
                for (final flag in BlacklistFlags.values)
                  SettingsTile.switchTile(
                    initialValue: settings.blacklistFlags.contains(flag),
                    onToggle: toggleBlackListFlag(flag),
                    title: Text(flag.name),
                  ),
              ],
            )
          ]);
        }),
      ),
    );
  }

  onPopInvoked(bool didPop) async {
    final navigator = Navigator.of(context);
    if (anyCategory) {
      settings.categories = [];
    }
    await settings.save(settings);
    if (navigator.canPop()) navigator.pop();
  }

  toggleEnableTextToSpeech(value) {
    setState(() {
      settings.enableTextToSpeech = value;
    });
  }

  toggleAnyCategory(value) {
    setState(() {
      anyCategory = value;
    });
  }

  void Function(bool value) toggleCategory(JokeCategory category) {
    return (value) {
      setState(() {
        value ? settings.categories.add(category) : settings.categories.remove(category);
      });
    };
  }

  void Function(bool value) toggleBlackListFlag(BlacklistFlags flag) {
    return (value) {
      setState(() {
        value ? settings.blacklistFlags.add(flag) : settings.blacklistFlags.remove(flag);
      });
    };
  }
}
