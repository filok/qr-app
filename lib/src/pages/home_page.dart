import 'package:appqr/src/bloc/scans_bloc.dart';
import 'package:appqr/src/models/scan_model.dart';
import 'package:appqr/src/pages/direcciones_page.dart';
import 'package:appqr/src/pages/mapas_page.dart';
import 'package:appqr/src/utils/utils.dart' as utils;
import 'package:barcode_scan/barcode_scan.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _callPage(currentIndex),
      bottomNavigationBar: _bottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingButtom(),
    );
  }

  //Appbar
  Widget appBar() {
    return AppBar(
      centerTitle: true,
      title: Text('QR Scanner App'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.delete_forever),
          onPressed: scansBloc.borrarScanTodos,
        ),
      ],
    );
  }

  //Bottom Navigation Bar
  Widget _bottomBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions),
          title: Text('Direcciones'),
        ),
      ],
    );
  }

  //Floating Buttom
  Widget _floatingButtom() {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () => _scanQR(context),
    );
  }

  //scan QR
  _scanQR(BuildContext context) async {
    dynamic futureString;

    try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString.rawContent = e.toString();
    }

    if (futureString != null) {
      final scan = ScanModel(valor: futureString.rawContent);
      scansBloc.agregarScan(scan);

      utils.abrirScan(context, scan);
    }
  }

  //Llamar pagina
  _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
      default:
        MapasPage();
    }
  }
}
