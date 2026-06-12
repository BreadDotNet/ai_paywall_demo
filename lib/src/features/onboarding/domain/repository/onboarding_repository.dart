import '../../../../core/base/dependency.dart';

abstract interface class OnboardingRepository implements Repository {
  Future<bool> isCompleted();

  Future<void> markCompleted();

  Future<void> clear();
}
