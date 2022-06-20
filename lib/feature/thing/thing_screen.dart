import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:last_thing/feature/thing/thing_service_view_model.dart';
import 'package:last_thing/theme/palette.dart';
import 'package:last_thing/utils/dark_mode.dart';

class ThingScreen extends ConsumerStatefulWidget {
  const ThingScreen({Key? key}) : super(key: key);

  @override
  ThingScreenState createState() => ThingScreenState();
}

class ThingScreenState extends ConsumerState<ThingScreen> {
  final _inputController = TextEditingController();

  //final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _inputController.dispose();
    //_focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(thingServiceViewModelProvider);
    _inputController.text = vm.thing;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  TextField(
                    controller: _inputController,
                    maxLines: 1,
                    autofocus: true,
                    //focusNode: _focusNode,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: isDarkMode(context)
                                ? Colors.white38
                                : Colors.black12,
                            width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: isDarkMode(context)
                                ? Colors.white38
                                : Colors.black12,
                            width: 1.0),
                      ),
                      hintText: 'Remember to',
                    ),
                    onSubmitted: (value) {
                      ref
                          .read(thingServiceViewModelProvider.notifier)
                          .updateValue(value);

                      //_focusNode.requestFocus();
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '(press Enter to save)',
                      style: TextStyle(
                        color: isDarkMode(context)
                            ? Colors.white38
                            : Colors.black26,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Theme(
                          data: ThemeData(
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(thingServiceViewModelProvider.notifier)
                                  .updateColor(colors[index]);
                            },
                            child:
                                Stack(alignment: Alignment.center, children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colors[index],
                                ),
                              ),
                              if (colors[index] == vm.color)
                                Icon(
                                  Icons.check,
                                  color:
                                      index == 0 ? Colors.black : Colors.white,
                                ),
                            ]),
                          ),
                        );
                      },
                      itemCount: colors.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Padding(
                            padding: EdgeInsets.only(right: 8));
                      },
                    ),
                  ),
                  Tooltip(
                    message: 'Quit Last thing',
                    child: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      splashRadius: 18,
                      onPressed: () => ref
                          .read(thingServiceViewModelProvider.notifier)
                          .exitApp(),
                      icon: const Icon(
                        Icons.exit_to_app_rounded,
                      ),
                      iconSize: 18,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
