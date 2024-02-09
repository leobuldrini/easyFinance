import 'package:flutter/material.dart';
import 'package:judge/models/active_tab.dart';
import 'package:judge/models/nav_item_model.dart';
import 'package:rive/rive.dart';

class BottomNavWithAnimatedIcons extends StatefulWidget {
  const BottomNavWithAnimatedIcons({super.key});

  @override
  State<BottomNavWithAnimatedIcons> createState() => _BottomNavWithAnimatedIconsState();
}

class _BottomNavWithAnimatedIconsState extends State<BottomNavWithAnimatedIcons> {
  List<SMIBool> riveIconInputs = [];
  List<StateMachineController?> controllers = [];
  int selectedNavIndex = 0;

  void riveOnInIt(Artboard artboard, {required String stateMachineName}) {
    StateMachineController? controller = StateMachineController.fromArtboard(artboard, stateMachineName);

    artboard.addController(controller!);
    controllers.add(controller);

    riveIconInputs.add(controller.findInput<bool>('active') as SMIBool);
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SafeArea(
      child: Container(
        height: 66,
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.3),
              offset: const Offset(0, 20),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              bottomNavItems.length,
              (index) => GestureDetector(
                    onTap: () {
                      riveIconInputs[index].change(true);
                      Future.delayed(
                        const Duration(seconds: 1),
                        () {
                          riveIconInputs[index].change(false);
                        },
                      );
                      setState(() {
                        selectedNavIndex = index;
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 36,
                          width: 36,
                          child: RiveAnimation.asset(
                            bottomNavItems[index].rive.src,
                            artboard: bottomNavItems[index].rive.artboard,
                            onInit: (artboard) {
                              riveOnInIt(artboard, stateMachineName: bottomNavItems[index].rive.stateMachineName);
                            },
                          ),
                        ),
                        AnimatedBar(isActive: selectedNavIndex == index),
                      ],
                    ),
                  )),
        ),
      ),
    ));
  }
}
