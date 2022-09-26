import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ebook/utils/enum/app_theme_enum.dart';
import 'package:equatable/equatable.dart';

part 'theme_handler_event.dart';

part 'theme_handler_state.dart';

class ThemeHandlerBloc extends Bloc<ThemeHandlerEvent, ThemeHandlerState> {
  ThemeHandlerBloc()
      : super(const ThemeHandlerInitial(appTheme: AppTheme.light)) {
    on<SwitchThemeEvent>(_onSwitchEvent);
  }

  FutureOr<void> _onSwitchEvent(
      SwitchThemeEvent event, Emitter<ThemeHandlerState> emit) {
    emit(ThemeHandlerState(appTheme: event.theme));
  }
}
