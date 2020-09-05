import 'dart:async';

import 'package:appqr/src/models/scan_model.dart';

class Validators {
  final validarGo =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
          handleData: (scans, sink) {
    final geoScans = scans.where((s) => s.tipo == 'geo').toList();
    sink.add(geoScans);
  });

  final validarHttp =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
          handleData: (scans, sink) {
    final geoScans = scans.where((s) => s.tipo == 'http').toList();
    sink.add(geoScans);
  });
}
