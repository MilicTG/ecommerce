import 'package:ecommerce/services/firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/providers.dart';

final databaseProvider = Provider<FirestoreService?>((ref) {
  final auth = ref.watch(authStateChangesProvider);

  String? uid = auth.asData?.value?.uid;
  if (uid != null) {
    return FirestoreService(uid: uid);
  }
  return null;
});
