import 'package:flutter/material.dart';
import 'package:loja_virtual/models/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({this.icondata, this.title, this.page});
  final IconData icondata;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    final int curPage =
        context.watch<PageManager>().page; //obter a pagina atual
    final Color primaryColor =
        Theme.of(context).primaryColor; //pega a cor primaria
    return InkWell(
      onTap: () {
        context.read<PageManager>().setPage(page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                icondata,
                size: 32,
                color: curPage == page ? primaryColor : Colors.grey[700],
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: curPage == page ? primaryColor : Colors.grey[700],
              ),
            )
          ],
        ),
      ),
    );
  }
}
