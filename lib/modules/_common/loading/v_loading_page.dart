import 'package:flutter/material.dart';
import 'package:universe_rental/constants/app_constants.dart';
import '../../../constants/app_colors.dart';
import '../flutter_super_scaffold.dart';

class LoadingPage extends StatefulWidget {
  final int durationInMs;
  const LoadingPage({super.key, this.durationInMs = 1200});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  ValueNotifier<double> animationValue = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    initLoad();
  }

  @override
  void dispose() {
    if (animationController != null) {
      animationController!.dispose();
    }
    super.dispose();
  }

  void initLoad() async {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.durationInMs),
    );
    animationController!.addListener(() {
      animationValue.value = animationController!.value;
      animationValue.notifyListeners();
    });
    animationController!.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSuperScaffold(
      isTopSafe: false,
      isBotSafe: false,
      superBarColor: SuperBarColor(
          xTopIconWhite: true,
          topBarColor: AppColors.white,
          xBotIconWhite: true,
          botBarColor: AppColors.white),
      backgroundColor: AppColors.white,
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: animationValue,
          builder: (context, value, child) {
            return Opacity(
                opacity: value,
                child: Text(
                  "UNIVERSE RENTAL",
                  style: TextStyle(fontSize: AppConstants.fontSizeXL),
                ));
          },
        ),
      ),
    );
  }
}
