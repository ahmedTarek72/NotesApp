// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tut_app/domain/model/models.dart';

import '../../base/base_view_model.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class OnBoardingViewModel implements BaseViewModel
    , OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  late final List<SliderObject> _list;
  int currentPageIndex = 0;
  late int numOfPages;
  late PageController pageController;

  final StreamController _streamController =
      StreamController<SliderViewObject>();

  @override
  void dispose() {
    _streamController.close();
    pageController.dispose();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
 
    pageController = PageController(initialPage: currentPageIndex);
  }

  @override
  void goToNextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  void goToPreviousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  void onPageChanged(int index) {
    currentPageIndex = index;
    _postDataToView();
  }

  // data will be inputted to view model
  @override
  Sink get inputSliderViewModel => _streamController.sink;

  // data will be outputted from view model
  @override
  Stream<SliderViewObject> get outputSliderViewModel =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // list of model objects will be send to view

  void _postDataToView() {
    _streamController.add(SliderViewObject(
      sliderObject: _list[currentPageIndex],
      currentIndex: currentPageIndex,
      numOfPages: _list.length,
    ));
  }

  List<SliderObject> _getSliderData() => [
        SliderObject(
            title: AppStrings.onBoardingHeader1,
            description: AppStrings.onBoardingBody1,
            image: ImageAssets.splashLogo1),
        SliderObject(
            title: AppStrings.onBoardingHeader2,
            description: AppStrings.onBoardingBody2,
            image: ImageAssets.splashLogo2),
        SliderObject(
            title: AppStrings.onBoardingHeader3,
            description: AppStrings.onBoardingBody3,
            image: ImageAssets.splashLogo3),
        SliderObject(
            title: AppStrings.onBoardingHeader4,
            description: AppStrings.onBoardingBody4,
            image: ImageAssets.splashLogo4),
      ];
}

// inputs means orders from view to view model
abstract class OnBoardingViewModelInputs {
  void goToNextPage();
  void goToPreviousPage();
  void onPageChanged(int index);

  // input data to view
  Sink get inputSliderViewModel;
}

abstract class OnBoardingViewModelOutputs {
  // output data from view model to view
  Stream<SliderViewObject> get outputSliderViewModel;
}
