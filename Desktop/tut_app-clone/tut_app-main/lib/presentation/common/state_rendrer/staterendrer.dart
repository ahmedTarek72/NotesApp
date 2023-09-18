import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';

enum StateRendrerType {
  // popUp
  popUpLoadingState,
  popUpErrorState,
  //fullScreen
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  //general
  contentState,
}

class StateRenderer extends StatelessWidget {
  StateRendrerType stateRendrerType;
  String message;
  String title;
  Function reTryActionFunction;
  StateRenderer({
    Key? key,
    required this.stateRendrerType,
    this.message = AppStrings.loading,
    this.title = "",
    required this.reTryActionFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
