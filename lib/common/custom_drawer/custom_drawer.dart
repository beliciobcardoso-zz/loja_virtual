import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_drawer/drawer_tile.dart';
import 'package:loja_virtual/common/custom_drawer/custom_drawer_header.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 203, 236, 241),
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              CustomDrawerHeader(),
              const Divider(),
              const DrawerTile(
                icondata: Icons.home,
                title: 'Inicio',
                page: 0,
              ),
              const DrawerTile(
                icondata: Icons.list,
                title: 'Produtos',
                page: 1,
              ),
              const DrawerTile(
                icondata: Icons.playlist_add_check,
                title: 'Meus Pedidos',
                page: 2,
              ),
              const DrawerTile(
                icondata: Icons.location_on,
                title: 'Lojas',
                page: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
