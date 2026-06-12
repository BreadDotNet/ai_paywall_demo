import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/core/config/app_config.dart';
import 'src/core/di/di_container.dart';
import 'src/core/services/storage/shared_preferences_storage_service.dart';
import 'src/features/app/application/bloc/app_session_cubit.dart';
import 'src/features/billing/data/data_source/fake_billing_data_source.dart';
import 'src/features/billing/data/data_source/secure_billing_storage.dart';
import 'src/features/billing/data/repository/billing_repository_impl.dart';
import 'src/features/billing/domain/repository/billing_repository.dart';
import 'src/features/onboarding/data/repository/onboarding_repository_impl.dart';
import 'src/features/onboarding/domain/repository/onboarding_repository.dart';

Future<DIContainer> createDependencies() async {
  final container = DIContainer();
  final preferences = await SharedPreferences.getInstance();

  final appConfig = AppConfig.fromEnvironment();
  final sharedPreferencesStorage = SharedPreferencesStorageService(preferences);
  final secureBillingStorage = SecureBillingStorage(
    const FlutterSecureStorage(),
  );
  final billingRepository = BillingRepositoryImpl(
    dataSource: FakeBillingDataSource(),
    storage: secureBillingStorage,
  );
  final onboardingRepository = OnboardingRepositoryImpl(
    sharedPreferencesStorage,
  );
  final appSessionCubit = AppSessionCubit(
    billingRepository: billingRepository,
    onboardingRepository: onboardingRepository,
  );

  container
    ..register<AppConfig>(appConfig)
    ..register<SharedPreferencesStorageService>(sharedPreferencesStorage)
    ..register<BillingRepository>(billingRepository)
    ..register<OnboardingRepository>(onboardingRepository)
    ..register<AppSessionCubit>(appSessionCubit);

  return container;
}
