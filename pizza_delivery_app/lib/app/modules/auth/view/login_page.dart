import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pizza_delivery_app/app/modules/auth/controllers/login_controller.dart';
import 'package:pizza_delivery_app/app/modules/splash/view/splash_page.dart';
import 'package:pizza_delivery_app/app/shared/components/pizza_delivery_button.dart';
import 'package:pizza_delivery_app/app/shared/components/pizza_delivery_input.dart';
import 'package:pizza_delivery_app/app/shared/mixins/loader_mixin.dart';
import 'package:pizza_delivery_app/app/shared/mixins/messages_mixin.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class LoginPage extends StatelessWidget {
  static const router = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ChangeNotifierProvider(
            create: (context) => LoginController(),
            child: LoginContent(),
          ),
        ),
      ),
    );
  }
}

class LoginContent extends StatefulWidget {
  @override
  _LoginContentState createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent>
    with LoaderMixin, MessagesMixin {
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final obscurePasswordValueNotifier = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    final loginController = context.read<LoginController>();
    loginController.addListener(() {
      showHideLoaderHelper(context, loginController.showLoader);

      if (!isNull(loginController.error)) {
        showError(message: loginController.error, context: context);
      }

      if (loginController.loginSuccess) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(SplashPage.router, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Image.asset(
            'assets/images/logo.png',
            width: 250,
          ),
        ),
        Container(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  PizzaDeliveryInput(
                    'E-mail',
                    controller: emailEditingController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (!isEmail(value?.toString()?.trim() ?? '')) {
                        return 'Por favor, forneça um e-mail válido';
                      }
                      return null;
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: obscurePasswordValueNotifier,
                    builder: (_, obscurePasswordValueNotifierValue, child) {
                      return PizzaDeliveryInput(
                        'Senha',
                        controller: passwordEditingController,
                        suffixIcon: obscurePasswordValueNotifierValue
                            ? Icon(MaterialIcons.visibility)
                            : Icon(MaterialIcons.visibility_off),
                        suffixIconOnPressed: () {
                          obscurePasswordValueNotifier.value =
                              !obscurePasswordValueNotifierValue;
                        },
                        obscureText: obscurePasswordValueNotifierValue,
                        validator: (value) {
                          if (!isLength(value.toString(), 6)) {
                            return 'Por favor, forneça uma senha com no mínimo 6 caracteres';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  SizedBox(height: 30),
                  PizzaDeliveryButton(
                    'Login',
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        context.read<LoginController>().login(
                            emailEditingController.text.trim(),
                            passwordEditingController.text);
                      }
                    },
                    buttonColor: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: 5),
                  FlatButton(
                    child: Text(
                      'Não tem uma conta? Cadastre-se',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
