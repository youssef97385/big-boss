import 'dart:async';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/managers/http/domain_lookup.dart';

import '../../app/logic/app_settings.dart';
import '../../core/constants/const.dart';
import '../../injection.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required this.domainLookup}) : super(const AppState.refresh(i: 0)) {
    on<AppEvent>(_refreshApp);
  }

  final DomainLookup domainLookup;

  StreamController connectionChangeController = StreamController.broadcast();

  final Connectivity _connectivity = Connectivity();

  Future<void> init() async {
    // _connectivity.onConnectivityChanged.listen(_connectionChange);
    await setURL();
  }

  Stream get connectionChange => connectionChangeController.stream;

  void _connectionChange(ConnectivityResult result) {
    setURL();
  }

  Future<void> setURL() async {
    serviceLocator<AppSettings>().apiBaseUrl = kIqBaseUrl;
    final bool previousConnection =
        serviceLocator<AppSettings>().hasConnection ?? false;


    // serviceLocator<AppSettings>().hasConnection =
    //     await domainLookup.check('google.com');

    add(const AppEvent.requestRefresh());

    if (previousConnection != serviceLocator<AppSettings>().hasConnection) {
      connectionChangeController
          .add(serviceLocator<AppSettings>().hasConnection);
    }
  }

  void _refreshApp(AppEvent event, Emitter<AppState> emit) {
    final Random random = Random();
    final int randomNumber = random.nextInt(100);
    emit(AppState.refresh(i: randomNumber));
  }

  @override
  Future<void> close() {
    connectionChangeController.close();
    return super.close();
  }
}
