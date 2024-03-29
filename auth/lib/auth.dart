import 'package:auth/controllers/app_refresh_controller.dart';
import 'package:auth/controllers/app_singin_controller.dart';
import 'package:auth/controllers/app_singup_controller.dart';
import 'package:auth/controllers/app_token_controller.dart';
import 'package:auth/controllers/app_user_controller.dart';
import 'package:auth/utils/app_env.dart';
import 'package:conduit_core/conduit_core.dart';
import 'package:conduit_postgresql/conduit_postgresql.dart';

class AppService extends ApplicationChannel {
  late final ManagedContext managedContext;

  @override
  Future prepare() {
    final persistentStore = _initDatabase();
    managedContext = ManagedContext(
        ManagedDataModel.fromCurrentMirrorSystem(), persistentStore);
    return super.prepare();
  }

  @override
  Controller get entryPoint => Router()
    ..route("/singin").link(
      () => AppSingInController(managedContext),
    )
    ..route("/singup").link(
      () => AppSingUpController(managedContext),
    )
    ..route("token/[:refresh]").link(
      () => AppRefreshController(managedContext),
    )
    ..route("user")
        .link(() => AppTokenController())!
        .link(() => AppUserController(managedContext));

  PostgreSQLPersistentStore _initDatabase() {
    return PostgreSQLPersistentStore(
      AppEnv.dbUsername,
      AppEnv.dbPassword,
      AppEnv.dbHost,
      int.tryParse(AppEnv.dbPort),
      AppEnv.dbDatabaseName,
    );
  }
}
