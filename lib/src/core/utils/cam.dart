import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePath = StateProvider<String?>((ref) => null);
final image = StateProvider<String?>((ref) => null);
final imagePaths = StateProvider<List<String>>((ref) => []);
Future<void> getImage(WidgetRef ref, String? type) async {
  final ImagePicker picker = ImagePicker();
  final pickedFile = await picker.pickImage(
    source: type == "Camera" ? ImageSource.camera : ImageSource.gallery,
    maxHeight: double.infinity,
    maxWidth: double.infinity,
  );

  if (pickedFile != null) {
    ref.read(imagePath.notifier).update(
          (state) => state = pickedFile.path,
        );
  }
}

Future<void> getImages(WidgetRef ref) async {
  final ImagePicker picker = ImagePicker();
  final pickedFile = await picker.pickMultiImage(
    maxHeight: double.infinity,
    maxWidth: double.infinity,
    imageQuality: 50,
  );

  if (pickedFile.isNotEmpty) {
    ref.read(imagePaths.notifier).update(
          (state) => state = pickedFile.map((e) => e.path).toList(),
        );
  }
}
