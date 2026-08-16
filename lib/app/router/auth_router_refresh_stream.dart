import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:habit_level/features/auth/presentation/bloc/auth/auth_bloc.dart';

class AuthRouterRefreshStream extends ChangeNotifier {
  AuthRouterRefreshStream(Stream<AuthState> stream) {
    _subscription = stream.listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
