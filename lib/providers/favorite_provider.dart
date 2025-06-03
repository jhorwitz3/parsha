import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parsha/models/string_url_pair.dart';
import 'package:parsha/providers/user_provider.dart';

import 'package:riverpod/riverpod.dart';

final futureFavoritesProvider = FutureProvider.autoDispose((ref) async {
  List<StringUrlPair> favorites = await getFavoritesFromDb(ref);

  return favorites;
});

Future<List<StringUrlPair>> getFavoritesFromDb(Ref ref) async {
  final db = FirebaseFirestore.instance;
  List<StringUrlPair> favorites = [];
  User? currentUser = ref.read(currentUserProvider);
  if (currentUser == null) {
    return favorites;
  }
  try {
    //DB stores favorites under userId/randomDocumentId
    await db.collection(currentUser.uid).get().then((event) {
      for (var doc in event.docs) {
        favorites.add(StringUrlPair.fromJson(doc.data()));
      }
    });
  } catch (e) {
    debugPrint('Exception: $e');
  }
  return favorites;
}

// Provider that provides concrete favoritres
final favoritesProvider = Provider<List<StringUrlPair>>((ref) {
  final futureFavorites = ref.watch(futureFavoritesProvider);
  return futureFavorites.when(
    data: (favorites) => favorites,
    loading: () => [],
    error: (_, __) => [],
  );
});

class UpdateFavoritesNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void set(bool val) => state = val;

  /// Writes a StringUrlPair document to the user's Firestore collection
  /// Creates the collection if it doesn't exist
  Future<void> writeStringUrlPair(StringUrlPair pair) async {
    User? currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      return;
    }

    try {
      final firestore = FirebaseFirestore.instance;
      final collection = firestore.collection(currentUser.uid);

      // Check if the pair already exists
      final querySnapshot = await collection
          .where('string', isEqualTo: pair.string)
          .where('url', isEqualTo: pair.url)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Pair exists, remove it instead
        await querySnapshot.docs.first.reference.delete();
        debugPrint(
            'StringUrlPair already existed - removed from collection: ${currentUser.uid}');
      } else {
        // Pair doesn't exist, add it
        await collection.add(pair.toJson());
        debugPrint(
            'Successfully wrote StringUrlPair to collection: ${currentUser.uid}');
      }
    } catch (e) {
      debugPrint('Error processing StringUrlPair: $e');
      rethrow;
    }
  }

  /// Removes a StringUrlPair document from the user's Firestore collection
  /// Note: This removes the first matching document found
  Future<void> removeStringUrlPair(StringUrlPair pair) async {
    User? currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      return;
    }

    try {
      final firestore = FirebaseFirestore.instance;
      final collection = firestore.collection(currentUser.uid);

      // Query for documents that match both string and url
      final querySnapshot = await collection
          .where('string', isEqualTo: pair.string)
          .where('url', isEqualTo: pair.url)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Remove the first matching document
        await querySnapshot.docs.first.reference.delete();
        debugPrint(
            'Successfully removed StringUrlPair from collection: ${currentUser.uid}');
      } else {
        debugPrint('No matching StringUrlPair found to remove');
      }
    } catch (e) {
      debugPrint('Error removing StringUrlPair: $e');
      rethrow;
    }
  }
}

final updateFavoritesProvider =
    NotifierProvider<UpdateFavoritesNotifier, bool>(() {
  return UpdateFavoritesNotifier();
});
