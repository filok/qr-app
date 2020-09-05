import 'dart:async';

import 'package:appqr/src/bloc/validator.dart';
import 'package:appqr/src/providers/db_provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    obtenerScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStrem =>
      _scansController.stream.transform(validarGo);
  Stream<List<ScanModel>> get scansStremHttp =>
      _scansController.stream.transform(validarHttp);

  dispose() {
    _scansController?.close();
  }

  obtenerScans() async {
    _scansController.sink.add(await DBprovider.db.getTodosScans());
  }

  agregarScan(ScanModel scan) async {
    await DBprovider.db.nuevoScan(scan);
    obtenerScans();
  }

  borrarScan(int id) async {
    await DBprovider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScanTodos() async {
    await DBprovider.db.deleteAll();
    obtenerScans();
  }
}
