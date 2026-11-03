import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/core/repositories/connection/repository.dart';
import 'package:sharehop/core/services/web_dav_storage_service.dart';
import 'package:sharehop/core/use_cases/create_connection_use_case.dart';
import 'package:sharehop/core/use_cases/test_web_dav_connection_use_case.dart';
import 'package:sharehop/infrastructures/repositories/connection/repository_impl.dart';
import 'package:sharehop/infrastructures/services/web_dav_storage/service_impl.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_manager.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_pool.dart';

part 'connection_di.g.dart';

@Riverpod(keepAlive: true)
ConnectionRepository connectionRepository(Ref ref) =>
    ConnectionRepositoryImpl();

@Riverpod(keepAlive: true)
WebDavClientPool webDavClientPool(Ref ref) => WebDavClientPool();

@Riverpod(keepAlive: true)
WebDavClientManager webDavClientManager(Ref ref) =>
    WebDavClientManager(ref.watch(webDavClientPoolProvider));

@Riverpod(keepAlive: true)
WebDavStorageService webDavStorageService(Ref ref) =>
    WebDavStorageServiceImpl(ref.watch(webDavClientManagerProvider));

@Riverpod(keepAlive: true)
CreateConnectionUseCase createConnectionUseCase(Ref ref) =>
    CreateConnectionUseCase(ref.watch(connectionRepositoryProvider));

@Riverpod(keepAlive: true)
TestWebDavConnectionUseCase testWebDavConnectionUseCase(Ref ref) =>
    TestWebDavConnectionUseCase(ref.watch(webDavStorageServiceProvider));
