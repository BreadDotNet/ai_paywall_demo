import '../base/dependency.dart';

final class DIContainer {
  final Map<Type, Dependency> _dependencies = {};

  void register<T extends Dependency>(T instance) {
    _dependencies[T] = instance;
  }

  T get<T extends Dependency>() {
    final dependency = _dependencies[T];
    if (dependency == null) {
      throw StateError('Dependency $T is not registered.');
    }
    return dependency as T;
  }
}
