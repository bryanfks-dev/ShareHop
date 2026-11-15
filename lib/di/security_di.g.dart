// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(secretCipherFactory)
final secretCipherFactoryProvider = SecretCipherFactoryProvider._();

final class SecretCipherFactoryProvider
    extends
        $FunctionalProvider<
          SecretCipherFactory,
          SecretCipherFactory,
          SecretCipherFactory
        >
    with $Provider<SecretCipherFactory> {
  SecretCipherFactoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'secretCipherFactoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$secretCipherFactoryHash();

  @$internal
  @override
  $ProviderElement<SecretCipherFactory> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SecretCipherFactory create(Ref ref) {
    return secretCipherFactory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SecretCipherFactory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SecretCipherFactory>(value),
    );
  }
}

String _$secretCipherFactoryHash() =>
    r'20e6fa48c8348714c72c2b1b28a617698f5aee45';

@ProviderFor(secureRandom)
final secureRandomProvider = SecureRandomProvider._();

final class SecureRandomProvider
    extends $FunctionalProvider<SecureRandom, SecureRandom, SecureRandom>
    with $Provider<SecureRandom> {
  SecureRandomProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'secureRandomProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$secureRandomHash();

  @$internal
  @override
  $ProviderElement<SecureRandom> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SecureRandom create(Ref ref) {
    return secureRandom(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SecureRandom value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SecureRandom>(value),
    );
  }
}

String _$secureRandomHash() => r'c87913217d6b6312ae38159bdbcbe7dfb26ea85a';
