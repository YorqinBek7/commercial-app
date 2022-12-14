import 'package:flutter_bloc/flutter_bloc.dart';

part 'select_language_state.dart';

class SelectLanguageCubit extends Cubit<SelectLanguageState> {
  SelectLanguageCubit() : super(SelectLanguageInitial());
  void selectUzbekLanguage() {
    emit(SelectLanguageUzbek());
  }

  void selectEnglandLanguage() {
    emit(SelectLanguageEngland());
  }
}
