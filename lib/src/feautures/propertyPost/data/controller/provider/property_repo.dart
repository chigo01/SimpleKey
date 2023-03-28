import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:simple_key/src/core/providers/auth_providers.dart';
import 'package:simple_key/src/feautures/propertyPost/data/backend/repository/property_repository.dart';
import 'package:simple_key/src/feautures/propertyPost/data/controller/notifier/notifier.dart';
import 'package:simple_key/src/model/product_model.dart';

final propertyRepositoryProvider = Provider(
  (ref) => PropertyRepository(
    ref.watch(fireStoreProvider),
    ref.watch(firebaseStorageProvider),
    ref.watch(firebaseAuthProvider),
  ),
);

final productPostProvider = AsyncNotifierProvider(
  () => ProductPostNotifier(),
);

final getAllProperties =
    StreamNotifierProvider<ProductReadNotifier, List<AgentProperty>>(
  () => ProductReadNotifier(),
);
