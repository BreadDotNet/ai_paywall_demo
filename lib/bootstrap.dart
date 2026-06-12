import 'package:flutter/widgets.dart';

import 'create_dependencies.dart';
import 'src/core/navigation/create_router.dart';
import 'src/features/app/application/bloc/app_session_cubit.dart';
import 'src/features/app/presentation/app/app.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = await createDependencies();
  await container.get<AppSessionCubit>().restoreSession();
  final router = createRouter(container);

  runApp(App(container: container, router: router));
}
