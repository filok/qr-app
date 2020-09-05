import 'package:appqr/src/bloc/scans_bloc.dart';
import 'package:appqr/src/models/scan_model.dart';
import 'package:appqr/src/utils/utils.dart';

import 'package:flutter/material.dart';

class MapasPage extends StatelessWidget {
  final scansBloc = new ScansBloc();
  @override
  Widget build(BuildContext context) {
    scansBloc.obtenerScans();
    return StreamBuilder<List<ScanModel>>(
        stream: scansBloc.scansStrem,
        builder:
            (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final scans = snapshot.data;

          if (scans.length == 0) {
            return Center(
              child: Text('No hay Información'),
            );
          }
          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, index) => Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              onDismissed: (direction) => scansBloc.borrarScan(scans[index].id),
              child: ListTile(
                leading: Icon(Icons.map, color: Theme.of(context).primaryColor),
                title: Text(scans[index].valor),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () => abrirScan(context, scans[index]),
              ),
            ),
          );
        });
  }
}
