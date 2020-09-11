import 'package:bloc/bloc.dart';

class AppObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print("$event");
    super.onEvent(bloc, event);
  }
}
