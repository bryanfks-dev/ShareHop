import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/presentation/controllers/connections_controller.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';

void main() {
  group('ConnectionsController', () {
    test('initializes with pinned connections from '
        'managePinnedConnectionsController', () {
      final container = ProviderContainer();
      final connections = container.read(connectionsControllerProvider);

      expect(connections.length, 3);
      expect(connections[0].displayName, 'Studio NAS');
      expect(connections[1].displayName, 'Production');
      expect(connections[2].displayName, 'Design archive');
    });

    test('updates reactively when a connection is unpinned', () {
      final container = ProviderContainer();
      final manageController = container.read(
        managePinnedConnectionsControllerProvider.notifier,
      );

      expect(container.read(connectionsControllerProvider).length, 3);

      manageController.unpin('1');

      final updated = container.read(connectionsControllerProvider);
      expect(updated.length, 2);
      expect(updated.any((c) => c.id == '1'), isFalse);
    });

    test('updates reactively when a connection is pinned', () {
      final container = ProviderContainer();
      final manageController = container.read(
        managePinnedConnectionsControllerProvider.notifier,
      );

      expect(container.read(connectionsControllerProvider).length, 3);

      final success = manageController.pin('4');
      expect(success, isTrue);

      final updated = container.read(connectionsControllerProvider);
      expect(updated.length, 4);
      expect(updated.any((c) => c.id == '4'), isTrue);
    });

    test('getPinnedConnections returns all pinned connections', () {
      final container = ProviderContainer();
      final controller = container.read(connectionsControllerProvider.notifier);
      final pinned = controller.getPinnedConnections();

      expect(pinned.length, 3);
      expect(pinned[0].id, '1');
      expect(pinned[1].id, '2');
      expect(pinned[2].id, '3');
    });

    test(
      'getPinnedConnection without id returns the first pinned connection',
      () {
        final container = ProviderContainer();
        final controller = container.read(
          connectionsControllerProvider.notifier,
        );
        final first = controller.getPinnedConnection();

        expect(first, isNotNull);
        expect(first?.id, '1');
        expect(first?.displayName, 'Studio NAS');
      },
    );

    test('getPinnedConnection with id returns matching connection', () {
      final container = ProviderContainer();
      final controller = container.read(connectionsControllerProvider.notifier);
      final connection = controller.getPinnedConnection(id: '2');

      expect(connection, isNotNull);
      expect(connection?.id, '2');
      expect(connection?.displayName, 'Production');
    });

    test('getPinnedConnection with non-existent id returns null', () {
      final container = ProviderContainer();
      final controller = container.read(connectionsControllerProvider.notifier);
      final connection = controller.getPinnedConnection(id: '999');

      expect(connection, isNull);
    });
  });
}
