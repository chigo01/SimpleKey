import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:simple_key/src/feautures/propertyPost/data/controller/provider/property_repo.dart';
import 'package:simple_key/src/model/product_model.dart';

class ProductPostNotifier extends AsyncNotifier {
  @override
  FutureOr build() {
    throw UnimplementedError();
  }

  Future<void> uploadProperty(
    WidgetRef widgetRef,
    List<String> newImages,
    AgentProperty property,
  ) async {
    state = const AsyncValue.loading();

    final uploadImage = ref.watch(propertyRepositoryProvider);

    await uploadImage
        .uploadImages(
          widgetRef,
          newImages,
        )
        .whenComplete(
          () async => await uploadImage.postProperty(property),
        );
  }
}

class ProductReadNotifier extends StreamNotifier<List<AgentProperty>> {
  @override
  Stream<List<AgentProperty>> build() {
    final readProperty = ref.watch(propertyRepositoryProvider);

    return readProperty.getAllProperties();
  }
}
