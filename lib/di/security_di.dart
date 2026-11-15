import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharehop/core/security/secret_cipher.dart';
import 'package:sharehop/core/security/secure_random.dart';
import 'package:sharehop/infrastructures/security/derived_key_secret_cipher.dart';
import 'package:sharehop/infrastructures/security/secure_random_impl.dart';

part 'security_di.g.dart';

@Riverpod(keepAlive: true)
SecretCipherFactory secretCipherFactory(Ref ref) => DerivedKeySecretCipher.new;

@Riverpod(keepAlive: true)
SecureRandom secureRandom(Ref ref) => SecureRandomImpl();
