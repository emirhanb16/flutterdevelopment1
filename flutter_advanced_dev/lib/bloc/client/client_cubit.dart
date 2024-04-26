import 'package:flutter_bloc/flutter_bloc.dart';

part 'client.state.dart';

class ClientCubit extends Cubit<ClientState> {
  ClientCubit(ClientState initialState) : super(initialState);

  void changeLanguage(String language) {
    final newState = ClientState(
      language: language,
      darkMode: state.darkMode,
    );

    emit(newState);
  }

  void changeDarkMode(
    bool darkMode,
  ) {
    final newState = ClientState(
      language: state.language,
      darkMode: darkMode,
    );

    emit(newState);
  }
}
