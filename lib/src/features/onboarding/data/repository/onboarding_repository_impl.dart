import '../../../../core/errors/application_exception.dart';
import '../../../../core/services/storage/shared_preferences_storage_service.dart';
import '../../domain/repository/onboarding_repository.dart';

final class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._storage);

  static const _completedKey = 'onboarding.completed.v1';

  final SharedPreferencesStorageService _storage;

  @override
  Future<void> clear() async {
    try {
      await _storage.remove(_completedKey);
    } catch (error, stackTrace) {
      throw UnknownException(originalException: error, stackTrace: stackTrace);
    }
  }

  @override
  Future<bool> isCompleted() async {
    try {
      return _storage.getBool(_completedKey);
    } catch (error, stackTrace) {
      throw UnknownException(originalException: error, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> markCompleted() async {
    try {
      await _storage.setBool(_completedKey, true);
    } catch (error, stackTrace) {
      throw UnknownException(originalException: error, stackTrace: stackTrace);
    }
  }
}
