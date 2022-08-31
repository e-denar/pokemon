import 'package:flutter/material.dart';

enum ViewModelState {
  /// When viewmodel has just been initialized.
  init,

  /// When processing something.
  loading,

  /// When processing is finished.
  success,

  /// When processing encountered an issue
  error,
}

abstract class ViewModel extends ChangeNotifier {
  ViewModelState _state = ViewModelState.init;
  ViewModelState get state => _state;

  /// Start loading state.
  /// This will set the [state] to [ViewModelState.loading].
  ///
  /// NOTE: This will notify the listeners of this viewmodel.
  @protected
  void startLoading() {
    _state = ViewModelState.loading;
    notifyListeners();
  }

  /// Stop loading state.
  /// This will set the [state] to [ViewModelState.success].
  ///
  /// NOTE: This will notify the listeners of this viewmodel.
  @protected
  void stopLoading() {
    _state = ViewModelState.success;
    notifyListeners();
  }

  /// Start error state.
  /// This will set the [state] to [ViewModelState.error].
  ///
  /// NOTE: This will notify the listeners of this viewmodel.
  @protected
  void startError() {
    _state = ViewModelState.error;
    notifyListeners();
  }
}
