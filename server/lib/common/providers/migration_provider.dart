import 'package:dart_frog/dart_frog.dart';
import 'package:shopping_list_backend/common/implementations/migration_service.dart';
import 'package:shopping_list_backend/common/protocols/database_protocol.dart';
import 'package:shopping_list_backend/common/protocols/migration_protocol.dart';

MigrationProtocol? _migrationService;

Middleware migrationProvider() => provider<Future<MigrationProtocol>>(
      (ctx) async => _migrationService ??= MigrationService(
        db: await ctx.read<Future<DatabaseProtocol>>(),
      ),
    );
