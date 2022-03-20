
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:white_rabit_employer_detials/white_rabit/api/api_repostery.dart';
import 'package:white_rabit_employer_detials/white_rabit/screens/landing/employee_details_notifier.dart';

final homeApiRepositoryProvider = Provider<ApiRepository>(
      (ref) => ApiRepository(),
);

final employerProvider = StateNotifierProvider(
      (ref) => EmployerNotifier(ref.watch(homeApiRepositoryProvider)),
);