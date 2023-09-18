abstract class BaseViewModel
    implements BaseViewModelInputs, BaseViewModelOutputs {}

abstract class BaseViewModelInputs {
  void start(); // start job of view model

  void dispose(); // end job of view model
}

abstract class BaseViewModelOutputs {
  // will be implemented later
}
