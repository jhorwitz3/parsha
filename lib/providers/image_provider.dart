import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parsha/models/parsha.dart';
import 'package:parsha/providers/parsha_provider.dart';

import 'package:riverpod/riverpod.dart';

final imageProvider = FutureProvider.autoDispose((ref) async {
  final AsyncValue<Parsha> parsha = ref.watch(parshaProvider);
  Map<String, String> stringToUrlMap = {};

  switch (parsha) {
    case AsyncData(:final value):
      stringToUrlMap = await getImageUrlsFromDb(value);
  }
  return stringToUrlMap;
});

Future<Map<String, String>> getImageUrlsFromDb(Parsha parsha) async {
  final db = FirebaseFirestore.instance;
  Map<String, String> stringToUrlMap = {};

  try {
    await db.collection("themes").get().then((event) {
      for (var doc in event.docs) {
        debugPrint('doc.id: ${doc.id}');
        stringToUrlMap[doc.id] = doc.data()['imageUrl'];
      }
    });
    await db.collection("lessons").get().then((event) {
      for (var doc in event.docs) {
        debugPrint('doc.id: ${doc.id}');
        stringToUrlMap[doc.id] = doc.data()['imageUrl'];
      }
    });
    await db.collection("keyPoints").get().then((event) {
      for (var doc in event.docs) {
        debugPrint('doc.id: ${doc.id}');
        stringToUrlMap[doc.id] = doc.data()['imageUrl'];
      }
    });
    await db.collection("summary").get().then((event) {
      for (var doc in event.docs) {
        debugPrint('doc.id: ${doc.id}');
        stringToUrlMap[doc.id] = doc.data()['imageUrl'];
      }
    });
  } catch (e) {
    debugPrint('Exception: $e');
  }
  return stringToUrlMap;
}
