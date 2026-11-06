import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/core/gateways/web_dav_storage_gateway.dart';
import 'package:sharehop/core/repositories/connection_repository.dart';
import 'package:sharehop/core/services/connection_service.dart';
import 'package:sharehop/core/use_cases/create_connection_use_case.dart';
import 'package:sharehop/data/mapper/connection_credential_mapper.dart';
import 'package:sharehop/data/mapper/connection_mapper.dart';
import 'package:sharehop/data/mapper/encrypted_value_mapper.dart';
import 'package:sharehop/infrastructures/gateways/web_dav_storage/gateway_impl.dart';
import 'package:sharehop/infrastructures/repositories/connection_repository_impl.dart';
import 'package:sharehop/infrastructures/services/connection_service_impl.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_manager.dart';
import 'package:sharehop/infrastructures/web_dav/web_dav_client_pool.dart';

part 'connection_di.g.dart';

@Riverpod(keepAlive: true)
ConnectionRepository connectionRepository(Ref ref) =>
    ConnectionRepositoryImpl(ref.watch(connectionMapperProvider));

@Riverpod(keepAlive: true)
WebDavClientPool webDavClientPool(Ref ref) => WebDavClientPool();

@Riverpod(keepAlive: true)
WebDavClientManager webDavClientManager(Ref ref) =>
    WebDavClientManager(ref.watch(webDavClientPoolProvider));

@Riverpod(keepAlive: true)
WebDavStorageGateway webDavStorageGateway(Ref ref) =>
    WebDavStorageGatewayImpl(ref.watch(webDavClientManagerProvider));

@Riverpod(keepAlive: true)
ConnectionService connectionService(Ref ref) =>
    ConnectionServiceImpl(ref.watch(webDavStorageGatewayProvider));

@Riverpod(keepAlive: true)
CreateConnectionUseCase createConnectionUseCase(Ref ref) =>
    CreateConnectionUseCase(
      ref.watch(connectionRepositoryProvider),
      ref.watch(connectionServiceProvider),
      ref.watch(connectionCredentialMapperProvider),
      ref.watch(connectionMapperProvider),
    );

@Riverpod(keepAlive: true)
ConnectionCredentialMapper connectionCredentialMapper(Ref ref) =>
    ConnectionCredentialMapper();

@Riverpod(keepAlive: true)
EncryptedValueMapper encryptedValueMapper(Ref ref) => EncryptedValueMapper();

@Riverpod(keepAlive: true)
ConnectionMapper connectionMapper(Ref ref) =>
    ConnectionMapper(ref.watch(encryptedValueMapperProvider));
