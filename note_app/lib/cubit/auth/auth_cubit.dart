import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../utils/shared_pref.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final sharedPref = SharedPref();
  Future<void> appStarted() async {
    final uid = await sharedPref.getUid();
    try {
      if (uid != null) {
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn(String uid) async {
    sharedPref.setUid(uid);
    emit(Authenticated(uid: uid));
  }

  Future<void> loggedOut(String uid) async {
    sharedPref.setUid("");
    emit(UnAuthenticated());
  }
}
