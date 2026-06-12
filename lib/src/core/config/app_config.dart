import '../base/dependency.dart';
import '../errors/application_exception.dart';

final class AppConfig implements Dependency {
  AppConfig({required this.appName}) {
    _validate();
  }

  factory AppConfig.fromEnvironment() {
    return AppConfig(
      appName: const String.fromEnvironment(
        'APP_NAME',
        defaultValue: 'AI Paywall Demo',
      ),
    );
  }

  final String appName;

  void _validate() {
    if (appName.trim().isEmpty) {
      throw const ConfigException(
        userMessage: 'App configuration is invalid.',
        details: {'APP_NAME': 'Must not be blank.'},
      );
    }
  }
}
