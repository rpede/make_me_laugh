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
  List<JokeCategory> categories = [];
  List<BlacklistFlags> blacklistFlags = [...BlacklistFlags.values];

  @override
  void initState() {
    final settings = context.read<Settings>();
    categories = settings.categories;
    blacklistFlags = settings.blacklistFlags;
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
            SettingsSection(title: const Text("Category"), tiles: [
              SettingsTile.switchTile(
                initialValue: anyCategory,
                onToggle: toggleAnyCategory,
                title: const Text("Any"),
              ),
              for (final category in JokeCategory.values)
                SettingsTile.switchTile(
                  initialValue: categories.contains(category),
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
                    initialValue: blacklistFlags.contains(flag),
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
    final settings = context.read<Settings>();
    settings.categories = anyCategory ? [] : categories;
    settings.blacklistFlags = blacklistFlags;
    await settings.save(settings);
    if (navigator.canPop()) navigator.pop();
  }

  toggleAnyCategory(value) {
    setState(() {
      anyCategory = value;
    });
  }

  void Function(bool value) toggleCategory(JokeCategory category) {
    return (value) {
      setState(() {
        value ? categories.add(category) : categories.remove(category);
      });
    };
  }

  void Function(bool value) toggleBlackListFlag(BlacklistFlags flag) {
    return (value) {
      setState(() {
        value ? blacklistFlags.add(flag) : blacklistFlags.remove(flag);
      });
    };
  }
}
