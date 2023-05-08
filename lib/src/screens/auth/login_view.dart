import 'package:abac_challenge/src/bloc/auth/cubit/auth_cubit.dart';
import 'package:abac_challenge/src/bloc/auth/login/login_bloc.dart';
import 'package:abac_challenge/src/bloc/auth/login/login_state.dart';
import 'package:abac_challenge/src/repository/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/login/login_event.dart';
import '../../bloc/form_state.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) => LoginBloc(
                  authRepo: context.read<AuthRepo>(),
                  authCubit: context.read<AuthCubit>(),
                ),
            child: _loginForm(context)));
  }

  Widget _loginForm(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is FormFailure) {
            _showSnackBar(context, formStatus.error, Colors.red);
          } else if (formStatus is FormSuccess) {
            _showSnackBar(context, "Login Success", Colors.green);
          }
        },
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: isSmallScreen
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // logo need to be added
                        _formContent(context),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // logo need to be added
                        Flexible(
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: 500,
                            ),
                            child: _formContent(context),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ));
  }

  Widget _formContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _emailField(),
        _gap(),
        _passwordField(),
        _gap(),
        _loginButton(),
        _gap(),
        _goToRegister(context),
      ],
    );
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          label: Text('Email'),
          prefixIcon: Icon(Icons.email_outlined),
          border: OutlineInputBorder(),
        ),
        validator: (value) => state.isValidEmail ? null : 'Invalid email',
        onChanged: (value) => context.read<LoginBloc>().add(
              LoginEmailChanged(email: value),
            ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        decoration: InputDecoration(
          label: const Text("Password"),
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(state.isPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off),
            onPressed: () => context.read<LoginBloc>().add(
                  LoginPasswordVisibilityChanged(
                      isVisible: !state.isPasswordVisible),
                ),
          ),
          border: const OutlineInputBorder(),
        ),
        obscureText: !state.isPasswordVisible,
        validator: (value) => state.isValidPassword ? null : 'Invalid password',
        onChanged: (value) => context.read<LoginBloc>().add(
              LoginPasswordChanged(password: value),
            ),
      );
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSuccess
          ? const CircularProgressIndicator()
          : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ));
    });
  }

  Widget _goToRegister(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          TextButton(
            onPressed: () => context.read<AuthCubit>().showRegister(),
            child: const Text(
              'Sign up',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    });
  }

  void _showSnackBar(BuildContext context, String message, Color? color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color ?? ThemeData().snackBarTheme.backgroundColor,
    ));
  }

  Widget _gap() => const SizedBox(height: 16);
}
