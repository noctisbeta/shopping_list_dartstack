import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:shopping_list/controllers/bloc/room_bloc.dart';
import 'package:shopping_list/controllers/bloc/room_state.dart';
import 'package:shopping_list/controllers/dio_wrapper.dart';
import 'package:shopping_list/controllers/remote_room_data_source.dart';
import 'package:shopping_list/controllers/remote_room_repository.dart';
import 'package:shopping_list/controllers/router.dart';
import 'package:shopping_list/interfaces/room_repository_protocol.dart';

void main() async {
  usePathUrlStrategy();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (ctx) => DioWrapper(
            Dio(
              BaseOptions(
                baseUrl: 'http://localhost:8080/api/v1/',
              ),
            ),
          ),
        ),
        RepositoryProvider(
          create: (ctx) => RemoteRoomDataSource(
            dio: ctx.read<DioWrapper>(),
          ),
        ),
        RepositoryProvider<RoomRepository>(
          create: (ctx) => RemoteRoomRepository(
            dataSource: ctx.read<RemoteRoomDataSource>(),
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => RoomBloc(
          const RSinitial(),
          repository: context.read<RoomRepository>(),
        ),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ),
      ),
    ),
  );
}
