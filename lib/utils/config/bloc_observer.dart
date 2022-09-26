import 'dart:developer';
import 'package:ebook/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.i(event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e(error);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('$change');
    logger.wtf(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.d(transition);
  }
}
