import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parsha/models/parsha.dart';

import 'package:riverpod/riverpod.dart';

final parshaProvider = FutureProvider.autoDispose((ref) async {
  final Parsha parsha = await getParshaFromDb();

  return parsha;
});

Future<Parsha> getParshaFromDb() async {
  final db = FirebaseFirestore.instance;
  Parsha currentParsha = Parsha(
      name: 'This Weeks Parsha',
      summary: 'An error has occurred',
      keyPoints: [],
      themes: [],
      lessons: [],
      characters: []);
  try {
    await db.collection("currentParsha").get().then((event) {
      for (var doc in event.docs) {
        currentParsha = Parsha.fromJson(doc.data());
      }
    });
  } catch (e) {
    debugPrint('Exception: $e');
  }
  return currentParsha;
}
