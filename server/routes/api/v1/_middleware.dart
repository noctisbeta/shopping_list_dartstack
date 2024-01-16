import 'package:dart_frog/dart_frog.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart' as shelf;
import 'package:shopping_list_backend/common/providers/database_provider.dart';

Handler middleware(Handler handler) => handler //
    .use(requestLogger())
    .use(databaseProvider())
    .use(
      fromShelfMiddleware(
        shelf.corsHeaders(
          headers: {
            shelf.ACCESS_CONTROL_ALLOW_ORIGIN: '*',
          },
        ),
      ),
    );
