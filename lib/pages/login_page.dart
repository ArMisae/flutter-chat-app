import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/widgets/boton_azul.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Logo(
                    titulo: 'Messenger',
                  ),
                  _Form(),
                  const Labels(
                    ruta: 'register',
                    titulo: 'No tienes cuenta?',
                    subTitulo: 'Crea una ahora!',
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: const Text(
                      'Términos y condiciones de uso',
                      style: TextStyle(fontWeight: FontWeight.w200),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtr = TextEditingController();
  final passCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          CustomInput(
            iconData: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            texController: emailCtr,
          ),
          CustomInput(
            iconData: Icons.lock_outline,
            placeholder: 'Contraseña',
            isPassword: true,
            texController: passCtr,
          ),
          BotonAzul(
            text: 'Ingresar',
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(
                        emailCtr.text.trim(), passCtr.text.trim());

                    if (loginOk) {
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      // Mostrar alerta
                      mostrarAlerta(context, 'Login incorrecto',
                          'Revise sus credenciales nuevamente');
                    }
                  },
          )
        ],
      ),
    );
  }
}
