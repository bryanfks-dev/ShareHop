import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sharehop/core/enums/connection_protocol.dart';
import 'package:sharehop/presentation/controllers/manage_pinned_connections_controller.dart';
import 'package:sharehop/presentation/view_models/connection_view_model.dart';

void main() {
  group('ManagePinnedConnectionsController', () {
    test('initializes with default pinned and other connections', () {
      final container = ProviderContainer();
      final state = container.read(managePinnedConnectionsControllerProvider);

      expect(state.pinnedConnections.length, 3);
      expect(state.otherConnections.length, 2);
      expect(state.pinnedConnections[0].displayName, 'Studio NAS');
      expect(state.pinnedConnections[1].displayName, 'Production');
      expect(state.pinnedConnections[2].displayName, 'Design archive');
      expect(state.otherConnections[0].displayName, 'Finance secure');
      expect(state.otherConnections[1].displayName, 'Legacy media');
    });

    test('pin moves a connection from other to pinned connections', () {
      final container = ProviderContainer();
      final notifier = container.read(
        managePinnedConnectionsControllerProvider.notifier,
      );

      final success = notifier.pin('4');

      expect(success, isTrue);
      final state = container.read(managePinnedConnectionsControllerProvider);
      expect(state.pinnedConnections.length, 4);
      expect(state.otherConnections.length, 1);
      expect(state.pinnedConnections.any((c) => c.id == '4'), isTrue);
      expect(state.otherConnections.any((c) => c.id == '4'), isFalse);
    });

    test('pin returns false when connection id is not found', () {
      final container = ProviderContainer();
      final notifier = container.read(
        managePinnedConnectionsControllerProvider.notifier,
      );

      final success = notifier.pin('non-existent-id');

      expect(success, isFalse);
      final state = container.read(managePinnedConnectionsControllerProvider);
      expect(state.pinnedConnections.length, 3);
    });

    test('pin returns false when pinned limit of 6 is reached', () {
      final container = ProviderContainer();
      final notifier = container.read(
        managePinnedConnectionsControllerProvider.notifier,
      );

      // Pin item 4 and item 5
      expect(notifier.pin('4'), isTrue);
      expect(notifier.pin('5'), isTrue);
      expect(
        container
            .read(managePinnedConnectionsControllerProvider)
            .pinnedConnections
            .length,
        5,
      );

      // Add a 6th item directly to reach limit
      final sixItems = [
        ...container
            .read(managePinnedConnectionsControllerProvider)
            .pinnedConnections,
        ConnectionViewModel(
          id: '6',
          displayName: 'Extra item',
          remoteAddress: 'extra.host',
          username: 'admin',
          password: 'password',
          protocol: ConnectionProtocol.smb,
          isPinned: true,
        ),
      ];
      final oneOther = [
        ConnectionViewModel(
          id: '7',
          displayName: 'Seventh item',
          remoteAddress: 'seventh.host',
          username: 'admin',
          password: 'password',
          protocol: ConnectionProtocol.smb,
          isPinned: false,
        ),
      ];

      notifier.state = ManagePinnedConnectionsState(
        pinnedConnections: sixItems,
        otherConnections: oneOther,
      );

      final success = notifier.pin('7');
      expect(success, isFalse);
    });

    test('unpin moves a connection from pinned to other connections', () {
      final container = ProviderContainer();
      container
          .read(managePinnedConnectionsControllerProvider.notifier)
          .unpin('1');

      final state = container.read(managePinnedConnectionsControllerProvider);
      expect(state.pinnedConnections.length, 2);
      expect(state.otherConnections.length, 3);
      expect(state.pinnedConnections.any((c) => c.id == '1'), isFalse);
      expect(state.otherConnections.any((c) => c.id == '1'), isTrue);
    });

    test(
      'unpin does nothing when connection id is not found in pinned list',
      () {
        final container = ProviderContainer();
        container
            .read(managePinnedConnectionsControllerProvider.notifier)
            .unpin('unknown-id');

        final state = container.read(managePinnedConnectionsControllerProvider);
        expect(state.pinnedConnections.length, 3);
        expect(state.otherConnections.length, 2);
      },
    );

    test(
      'ManagePinnedConnectionsState copyWith preserves or updates values',
      () {
        final item = ConnectionViewModel(
          id: '1',
          displayName: 'Test',
          remoteAddress: '127.0.0.1',
          username: 'u',
          password: 'p',
          protocol: ConnectionProtocol.smb,
          isPinned: true,
        );

        final state = ManagePinnedConnectionsState(
          pinnedConnections: [item],
          otherConnections: const [],
        );

        final copiedSame = state.copyWith();
        expect(copiedSame.pinnedConnections.length, 1);
        expect(copiedSame.otherConnections.length, 0);

        final copiedNew = state.copyWith(
          pinnedConnections: const [],
          otherConnections: [item],
        );
        expect(copiedNew.pinnedConnections.length, 0);
        expect(copiedNew.otherConnections.length, 1);
      },
    );
  });
}
