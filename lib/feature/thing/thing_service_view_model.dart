import 'dart:convert';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:last_thing/feature/thing/thing_state.dart';
import 'package:last_thing/services/channel_service.dart';
import 'package:last_thing/services/shared_preferences_service.dart';
import 'package:last_thing/theme/palette.dart';
import 'package:last_thing/utils/color.dart';

final thingServiceViewModelProvider =
    StateNotifierProvider<ThingServiceViewModel, ThingState>((ref) {
  return ThingServiceViewModel(
      const ThingState(thing: '', color: Palette.kWhite), ref);
});

class ThingServiceViewModel extends StateNotifier<ThingState> {
  ThingServiceViewModel(
    ThingState state,
    this.ref,
  ) : super(state) {
    init();
  }

  final Ref ref;

  final ChannelService _channelService = ChannelService();

  init() {
    if (ref.read(sharedPreferencesServiceProvider).getString("last_thing") !=
            null &&
        ref
            .read(sharedPreferencesServiceProvider)
            .getString("last_thing")!
            .isNotEmpty) {
      final thingState = jsonDecode(ref
          .read(sharedPreferencesServiceProvider)
          .getString("last_thing")!) as Map<String, dynamic>;
      state = state.copWith(
          thing: thingState['thing'],
          color: HexColor.fromHex(thingState['color']));

      _channelService.changeStatusBar(state.thing, state.color.toHex());
    } else {
      state = state.copWith(thing: '');
      _channelService.changeStatusBar('Last thing', Palette.kWhite.toHex());
    }
  }

  updateValue(String value) async {
    state = state.copWith(thing: value);

    await ref.read(sharedPreferencesServiceProvider).putString("last_thing",
        jsonEncode({'thing': state.thing, 'color': state.color.toHex()}));

    if (state.thing.isNotEmpty) {
      _channelService.changeStatusBar(value, state.color.toHex());
    } else {
      _channelService.changeStatusBar('Last thing', Palette.kWhite.toHex());
    }
  }

  updateColor(Color color) {
    state = state.copWith(color: color);
  }

  exitApp() {
    _channelService.exitApp();
  }
}
