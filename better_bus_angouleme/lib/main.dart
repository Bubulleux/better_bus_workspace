import 'mobius_downloader.dart';
import 'package:better_bus_v2/better_bus.dart';
import 'package:better_bus_v2/data_provider/app_provider.dart';
import 'package:better_bus_v2/model/app_config.dart';
import 'package:better_bus_v2/model/app_paths.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

class MobiusConfig extends AppConfig {
  MobiusConfig()
      : super(
          cityName: "Angoulême",
          networkName: "Mobius",
          cityLocation: LatLng(45.65, 0.15),
          primaryColor: Colors.red,
        );

  @override
  AppProvider createProvider() {
    return AppProvider(downloader: MobiusDownloader(paths: AppPaths()));
  }
}

void main() {
  runBetterBus(MobiusConfig());
}
