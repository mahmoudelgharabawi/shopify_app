import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopify_app/models/ads.model.dart';
import 'package:shopify_app/utils/collections.utils.dart';

class HomeProvider extends ChangeNotifier {
  List<Ads>? adList;

  void initHomeProvider() async {
    await getAds();
  }

  Future<void> getAds() async {
    QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
        .instance
        .collection(CollectionsUtils.ads.name)
        .get();
    adList =
        List<Ads>.from(result.docs.map((e) => Ads.fromJson(e.data(), e.id)));
    notifyListeners();
  }
}
