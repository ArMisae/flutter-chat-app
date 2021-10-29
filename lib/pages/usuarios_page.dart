import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat/models/usuarios.dart';
import 'package:chat/services/auth_service.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(uid: '1', nombre: 'Perez', email: 'perez@gmail.com', online: true),
    Usuario(
        uid: '2', nombre: 'Arnold', email: 'arnold@gmail.com', online: true),
    Usuario(uid: '3', nombre: 'Maria', email: 'maria@gmail.com', online: false)
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    var color2 = const Color(0xFF42A5F5);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          usuario.nombre,
          style: const TextStyle(color: Colors.black87),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            AuthService.delete();
            Navigator.pushReplacementNamed(context, 'login');
          },
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.black87,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            // child: Icon(Icons.check_circle, color: Colors.blue[400],),
            child: const Icon(
              Icons.offline_bolt,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: color2,
        ),
        child: _listViewUsuarios(),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => const Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(
          usuario.nombre.substring(0, 2),
        ),
        backgroundColor: Colors.blue[300],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green[300] : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  void _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
