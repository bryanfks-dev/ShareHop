import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/core/repositories/connection/repository.dart';
import 'package:sharehop/core/services/smb_storage_service.dart';
import 'package:sharehop/core/services/web_dav_storage_service.dart';
import 'package:sharehop/core/use_cases/create_connection_use_case.dart';
import 'package:sharehop/core/use_cases/get_smb_storage_status_use_case.dart';
import 'package:sharehop/core/use_cases/test_connection_use_case.dart';
import 'package:sharehop/infrastructures/repositories/connection/repository_impl.dart';
import 'package:sharehop/infrastructures/services/smb_storage/service_impl.dart';
import 'package:sharehop/infrastructures/services/web_dav_storage/service_impl.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_manager.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_pool.dart';

part 'connection_di.g.dart';

@Riverpod(keepAlive: true)
ConnectionRepository connectionRepository(Ref ref) =>
    const ConnectionRepositoryImpl();

@Riverpod(keepAlive: true)
WebDavClientPool webDavClientPool(Ref ref) => WebDavClientPool();

@Riverpod(keepAlive: true)
WebDavClientManager webDavClientManager(Ref ref) =>
    WebDavClientManager(ref.watch(webDavClientPoolProvider));

@Riverpod(keepAlive: true)
WebDavStorageService webDavStorageService(Ref ref) =>
    WebDavStorageServiceImpl(ref.watch(webDavClientManagerProvider));

@Riverpod(keepAlive: true)
SmbStorageService smbStorageService(Ref ref) => const SmbStorageServiceImpl();

@Riverpod(keepAlive: true)
CreateConnectionUseCase createConnectionUseCase(Ref ref) =>
    CreateConnectionUseCase(
      ref.watch(connectionRepositoryProvider),
      ref.watch(testConnectionUseCaseProvider),
    );

@Riverpod(keepAlive: true)
TestConnectionUseCase testConnectionUseCase(Ref ref) =>
    TestConnectionUseCase(ref.watch(webDavStorageServiceProvider));

@Riverpod(keepAlive: true)
GetSmbStorageStatusUseCase getSmbStorageStatusUseCase(Ref ref) =>
    GetSmbStorageStatusUseCase(ref.watch(smbStorageServiceProvider));
