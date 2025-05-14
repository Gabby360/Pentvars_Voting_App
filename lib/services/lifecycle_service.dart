import 'package:flutter/material.dart';

class LifecycleService extends WidgetsBindingObserver {
  static final LifecycleService _instance = LifecycleService._internal();
  
  factory LifecycleService() {
    return _instance;
  }

  LifecycleService._internal();

  void initialize() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _handleResumed();
        break;
      case AppLifecycleState.inactive:
        _handleInactive();
        break;
      case AppLifecycleState.paused:
        _handlePaused();
        break;
      case AppLifecycleState.detached:
        _handleDetached();
        break;
      case AppLifecycleState.hidden:
        _handleHidden();
        break;
    }
  }

  void _handleResumed() {
    debugPrint('App resumed');
  }

  void _handleInactive() {
    debugPrint('App inactive');
  }

  void _handlePaused() {
    debugPrint('App paused');
  }

  void _handleDetached() {
    debugPrint('App detached');
  }

  void _handleHidden() {
    debugPrint('App hidden');
  }
} 