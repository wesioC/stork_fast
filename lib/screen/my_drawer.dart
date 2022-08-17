import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:stork_fast/screen/add_entregues.dart';
import 'package:stork_fast/screen/frete_screen.dart';
import 'package:stork_fast/screen/home.dart';
import 'package:stork_fast/screen/localizacao.dart';
import 'package:stork_fast/screen/login.dart';
import 'package:stork_fast/service/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        DrawerHeader(
          child: Text("Bem-vindo(a)!",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
          decoration: BoxDecoration(color: Colors.black87),
        ),
        ListTile(
          leading: Icon(Icons.home_outlined),
          title: Text("Início"),
          subtitle: Text("Tela principal..."),
          trailing: Icon(Icons.arrow_forward),
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => HomeScreen())),
        ),
        ListTile(
          leading: Icon(Icons.account_circle_outlined),
          title: Text("Perfil"),
          subtitle: Text("Perfil do usuário..."),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (v) => HomeScreen()));
          },
        ),
        ListTile(
          leading: Icon(Icons.local_shipping_outlined),
          title: Text("Transporte de Veículo "),
          subtitle: Text("Adicionar fretes..."),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (v) => FreteScreen()));
          },
        ),
        ListTile(
          leading: Icon(Icons.share_location_outlined),
          title: Text("Localização"),
          subtitle: Text("Atualizar lacalização..."),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (v) => Localizacao()));
          },
        ),
        ListTile(
          leading: Icon(Icons.checklist_outlined),
          title: Text("Entrega de Veículos"),
          subtitle: Text("Registrar entrega de veículo..."),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (v) => AddEntregues()));
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text("Sair"),
          subtitle: Text("Voltar a tela de login..."),
          onTap: () => context.read<AuthService>().logout(),
        ),
      ]),
    );
  }
}
