import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:loja_virtual/helpers/validators.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            child: const Text(
              "CRIAR CONTA",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
                builder: (context, userManager, context2) {
              return ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    controller: emailController,
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(hintText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (email) {
                      if (!emailValid(email)) {
                        return "E-mail inválido";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: passwordController,
                    enabled: !userManager.loading,
                    decoration: const InputDecoration(hintText: "Senha"),
                    autocorrect: false,
                    obscureText: true,
                    validator: (password) {
                      if (password.isEmpty || password.length < 6) {
                        return "Senha Inválida";
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: const Text("Esqueci minha senha"),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      onPressed: userManager.loading
                          ? null
                          : () {
                              if (formKey.currentState.validate()) {
                                userManager.singIn(
                                  user: User(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                  onFail: (e) {
                                    scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text("Falha ao entrar: $e"),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  },
                                  onSuccess: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              }
                            },
                      color: Theme.of(context).primaryColor,
                      disabledColor:
                          Theme.of(context).primaryColor.withAlpha(100),
                      textColor: Colors.white,
                      child: userManager.loading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.yellow),
                            )
                          : const Text(
                              "Entrar",
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
