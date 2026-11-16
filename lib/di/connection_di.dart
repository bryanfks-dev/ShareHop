import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/core/factories/connection/factory.dart';
import 'package:sharehop/core/gateways/web_dav_storage_gateway.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/repositories/pinned_connection_repository.dart';
import 'package:sharehop/core/services/connection_service.dart';
import 'package:sharehop/core/use_cases/check_connection_status_use_case.dart';
import 'package:sharehop/core/use_cases/create_connection_use_case.dart';
import 'package:sharehop/core/use_cases/delete_connection_use_case.dart';
import 'package:sharehop/core/use_cases/get_connections_use_case.dart';
import 'package:sharehop/core/use_cases/get_pinned_connection_ids_use_case.dart';
import 'package:sharehop/core/use_cases/pin_connection_use_case.dart';
import 'package:sharehop/core/use_cases/unpin_connection_use_case.dart';
import 'package:sharehop/core/use_cases/update_connection_use_case.dart';
import 'package:sharehop/data/mapper/connection_credential_mapper.dart';
import 'package:sharehop/data/mapper/connection_mapper.dart';
import 'package:sharehop/data/mapper/encrypted_value_mapper.dart';
import 'package:sharehop/di/app_config_di.dart';
import 'package:sharehop/di/security_di.dart';
import 'package:sharehop/infrastructures/gateways/web_dav_storage/gateway_impl.dart';
import 'package:sharehop/infrastructures/repositories/connection/repository_impl.dart';
import 'package:sharehop/infrastructures/repositories/pinned_connection/repository_impl.dart';
import 'package:sharehop/infrastructures/services/connection_service_impl.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_manager.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_pool.dart';

part 'connection_di.g.dart';

@Riverpod(keepAlive: true)
ConnectionRepository connectionRepository(Ref ref) => ConnectionRepositoryImpl(
  connectionMapper: ref.watch(connectionMapperProvider),
);

@Riverpod(keepAlive: true)
PinnedConnectionRepository pinnedConnectionRepository(Ref ref) =>
    const PinnedConnectionRepositoryImpl();

@Riverpod(keepAlive: true)
WebDavClientPool webDavClientPool(Ref ref) => WebDavClientPool();

@Riverpod(keepAlive: true)
WebDavClientManager webDavClientManager(Ref ref) =>
    WebDavClientManager(clientPool: ref.watch(webDavClientPoolProvider));

@Riverpod(keepAlive: true)
WebDavStorageGateway webDavStorageGateway(Ref ref) => WebDavStorageGatewayImpl(
  clientManager: ref.watch(webDavClientManagerProvider),
);

@Riverpod(keepAlive: true)
ConnectionService connectionService(Ref ref) => ConnectionServiceImpl(
  webDavStorageGateway: ref.watch(webDavStorageGatewayProvider),
);

@Riverpod(keepAlive: true)
ConnectionFactory connectionFactory(Ref ref) => const ConnectionFactory();

@Riverpod(keepAlive: true)
CreateConnectionUseCase createConnectionUseCase(Ref ref) =>
    CreateConnectionUseCase(
      appConfigRepository: ref.watch(appConfigRepositoryProvider),
      connectionRepository: ref.watch(connectionRepositoryProvider),
      secretCipherFactory: ref.watch(secretCipherFactoryProvider),
      connectionFactory: ref.watch(connectionFactoryProvider),
    );

@Riverpod(keepAlive: true)
PinConnectionUseCase pinConnectionUseCase(Ref ref) => PinConnectionUseCase(
  pinnedConnectionRepository: ref.watch(pinnedConnectionRepositoryProvider),
);

@Riverpod(keepAlive: true)
UnpinConnectionUseCase unpinConnectionUseCase(Ref ref) =>
    UnpinConnectionUseCase(
      pinnedConnectionRepository: ref.watch(pinnedConnectionRepositoryProvider),
    );

@Riverpod(keepAlive: true)
GetConnectionsUseCase getConnectionsUseCase(Ref ref) => GetConnectionsUseCase(
  connectionRepository: ref.watch(connectionRepositoryProvider),
);

@Riverpod(keepAlive: true)
GetPinnedConnectionIdsUseCase getPinnedConnectionIdsUseCase(Ref ref) =>
    GetPinnedConnectionIdsUseCase(
      pinnedConnectionRepository: ref.watch(pinnedConnectionRepositoryProvider),
    );

@Riverpod(keepAlive: true)
DeleteConnectionUseCase deleteConnectionUseCase(Ref ref) =>
    DeleteConnectionUseCase(
      connectionRepository: ref.watch(connectionRepositoryProvider),
      pinnedConnectionRepository: ref.watch(pinnedConnectionRepositoryProvider),
    );

@Riverpod(keepAlive: true)
UpdateConnectionUseCase updateConnectionUseCase(Ref ref) =>
    UpdateConnectionUseCase(
      appConfigRepository: ref.watch(appConfigRepositoryProvider),
      connectionRepository: ref.watch(connectionRepositoryProvider),
      secretCipherFactory: ref.watch(secretCipherFactoryProvider),
    );

@Riverpod(keepAlive: true)
CheckConnectionStatusUseCase checkConnectionStatusUseCase(Ref ref) =>
    CheckConnectionStatusUseCase(
      connectionRepository: ref.watch(connectionRepositoryProvider),
      appConfigRepository: ref.watch(appConfigRepositoryProvider),
      secretCipherFactory: ref.watch(secretCipherFactoryProvider),
      connectionService: ref.watch(connectionServiceProvider),
    );

@Riverpod(keepAlive: true)
ConnectionCredentialMapper connectionCredentialMapper(Ref ref) =>
    ConnectionCredentialMapper();

@Riverpod(keepAlive: true)
EncryptedValueMapper encryptedValueMapper(Ref ref) =>
    const EncryptedValueMapper();

@Riverpod(keepAlive: true)
ConnectionMapper connectionMapper(Ref ref) =>
    ConnectionMapper(ref.watch(encryptedValueMapperProvider));
