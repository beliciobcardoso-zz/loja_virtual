import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validators.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Criar Conta"),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
              key: formKey,
              child: Consumer<UserManager>(builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(14),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      autofocus: true,
                      decoration:
                          const InputDecoration(hintText: 'Nome Completo'),
                      enabled: !userManager.loading,
                      validator: (name) {
                        if (name.isEmpty) {
                          return "Campo obrigatório";
                        } else if (name.trim().split(' ').length <= 1) {
                          return "Digite o seu nome completo!";
                        }
                        return null;
                      },
                      onSaved: (name) => user.name = name,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      enabled: !userManager.loading,
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) {
                        if (email.isEmpty) {
                          return "Campo obrigatrio";
                        } else if (!emailValid(email)) {
                          return "E-mail inválido";
                        }
                        return null;
                      },
                      onSaved: (email) => user.email = email,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Senha'),
                      enabled: !userManager.loading,
                      obscureText: true,
                      validator: (password1) {
                        if (password1.isEmpty) {
                          return "Campo obrigatrio";
                        } else if (password1.length < 6) {
                          return "Senha deve conte mais de 6 caracteres";
                        }
                        return null;
                      },
                      onSaved: (password) => user.password = password,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Repita a senha'),
                      enabled: !userManager.loading,
                      obscureText: true,
                      validator: (password2) {
                        if (password2.isEmpty) {
                          return "Campo obrigatrio";
                        } else if (password2.length < 6) {
                          return "Senha deve conte mais de 6 caracteres";
                        }
                        return null;
                      },
                      onSaved: (password) => user.confirmPassword = password,
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
                                  formKey.currentState.save();
                                  if (user.password != user.confirmPassword) {
                                    scaffoldKey.currentState.showSnackBar(
                                      const SnackBar(
                                        content: Text("Senhas não coincidem!"),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }
                                  userManager.singUp(
                                    user: user,
                                    onSuccess: () {
                                      debugPrint("Sucesso");
                                      Navigator.of(context).pop();
                                    },
                                    onFail: (e) {
                                      scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content: Text("Falha ao entrar: $e"),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
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
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.yellow),
                              )
                            : const Text(
                                "Criar Conta",
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    )
                  ],
                );
              })),
        ),
      ),
    );
  }
}
