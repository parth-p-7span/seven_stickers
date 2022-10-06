import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seven_stickers/models/sticker_data.dart';
import 'package:seven_stickers/widgets/sticker_pack_item.dart';
import '../widgets/app_bar.dart' as app_bar;

mixin constants {
  static String baseUrl =
      'https://mandj.sfo2.cdn.digitaloceanspaces.com/stickers_test/';
}

class StickersScreen extends StatefulWidget {
  static const routeName = '/';

  const StickersScreen({Key? key}) : super(key: key);

  @override
  State<StickersScreen> createState() => _StickersScreenState();
}

class _StickersScreenState extends State<StickersScreen> {
  bool _isLoading = false;

  late StickerData stickerData;

  List stickerPacks = [];
  List installedStickerPacks = [];
  late String stickerFetchType;
  late Dio dio;
  var downloads = <Future>[];
  var data;


  void _loadStickers() async {
    if (stickerFetchType == 'staticStickers') {
      data = await rootBundle.loadString("assets/contents.json");
    } else {
      dio = Dio();
      data = await dio.get("${constants.baseUrl}contents.json");
    }
    setState(() {
      stickerData = StickerData.fromJson(jsonDecode(data.toString()));
      _isLoading = false;
    });
  }

  @override
  didChangeDependencies() {
    var args = ModalRoute.of(context)?.settings.arguments as String?;
    stickerFetchType = args ?? "staticStickers";
    setState(() {
      _isLoading = true;
    });
    _loadStickers();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar.AppBar(
        title: stickerFetchType == "staticStickers"
            ? "Static Stickers"
            : "Remote Stickers",
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: stickerData.stickerPacks!.length,
        itemBuilder: (context, index) {
          return StickerPackItem(
            stickerPack: stickerData.stickerPacks![index],
            stickerFetchType: stickerFetchType,
          );
        },
      ),
    );
  }
}
