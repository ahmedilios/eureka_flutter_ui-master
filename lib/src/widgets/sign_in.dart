import 'package:altair/altair.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vega/vega.dart';

class SignInPage extends StatefulWidget {
  final AuthBloc bloc;
  final Widget appBar;
  final Widget title;
  final Widget loading;
  final Widget drawer;
  final List<Widget> below;

  final String usernameLabel;
  final String usernameHint;
  final TextInputType usernameInput;
  final GenericTextController usernameController;

  final String passwordLabel;
  final String passwordHint;
  final TextInputType passwordInput;
  final GenericTextController passwordController;

  final String forgotPasswordLabel;
  final VoidCallback onForgotPasswordPressed;

  final String signUpLabel;
  final VoidCallback onSignUpPressed;
  final TextStyle signUpStyle;

  final Widget Function(BuildContext, SimpleState) builderHandler;
  final Widget Function(BuildContext, SimpleEvent) listenerHandler;

  final VoidCallback onSignIn;

  final VegaInputStyle fieldDecoration;
  final Widget signInButton;
  final bool autovalidate;

  SignInPage({
    this.bloc,
    this.appBar,
    this.drawer,
    this.loading,
    this.below = const [],
    @required this.title,
    this.usernameLabel = 'Usuário',
    this.usernameHint = 'email@example.com',
    this.usernameController,
    this.passwordLabel = 'Senha',
    this.passwordHint = '*******',
    this.passwordController,
    this.forgotPasswordLabel = 'Esqueceu sua senha?',
    this.onForgotPasswordPressed,
    this.signUpLabel = 'Não tem conta? Cadastre-se agora',
    this.onSignUpPressed,
    this.signUpStyle,
    this.builderHandler,
    this.listenerHandler,
    this.onSignIn,
    this.fieldDecoration,
    this.signInButton,
    this.autovalidate = false,
    this.usernameInput = TextInputType.emailAddress,
    this.passwordInput = TextInputType.visiblePassword,
  });

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  GenericTextController _usernameController;
  GenericTextController _passwordController;
  bool _obscurePassword;

  @override
  void initState() {
    super.initState();
    _usernameController = widget.usernameController ?? TextController();
    _passwordController = widget.passwordController ?? TextController();
    _obscurePassword = true;
  }

  void _togglePasswordVisibility() => setState(() {
        _obscurePassword = !_obscurePassword;
      });

  Widget _buildField({
    String label,
    String hint,
    GenericTextController controller,
    bool enabled = true,
    bool obscureText = false,
    Widget prefixIcon,
    Widget suffixIcon,
    TextInputType keyboardType,
  }) =>
      VegaTextField(
        label: label,
        hint: hint,
        enabled: enabled,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: 1,
        autocorrect: false,
        verifiedIcon: const Icon(Icons.check),
        style: widget.fieldDecoration?.merge(
              VegaInputStyle(
                innerDecoration: InputDecoration(
                  labelText: label,
                  hintText: hint,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                ),
              ),
            ) ??
            VegaInputStyle(
              innerDecoration: InputDecoration(
                labelText: label,
                hintText: hint,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 32.0,
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
      );

  Widget _buildUsernameField({
    bool enabled,
  }) =>
      _buildField(
        label: widget.usernameLabel,
        hint: widget.usernameHint,
        controller: _usernameController,
        enabled: enabled,
        keyboardType: widget.usernameInput,
      );

  Widget _buildPasswordField({
    bool enabled,
  }) =>
      _buildField(
        label: widget.passwordLabel,
        hint: widget.passwordHint,
        controller: _passwordController,
        enabled: enabled,
        keyboardType: widget.passwordInput,
        obscureText: _obscurePassword,
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: _togglePasswordVisibility,
        ),
      );

  Widget _buildButton(BuildContext context) => widget.signInButton != null
      ? GestureDetector(
          onTap: _onSubmit,
          child: AbsorbPointer(child: widget.signInButton),
        )
      : FlatButton(
          onPressed: _onSubmit,
          color: Theme.of(context).primaryColor,
          textColor: Theme.of(context).colorScheme.onPrimary,
          child: Text("ENTRAR"),
        );

  Widget _buildLoadingButton(BuildContext context) =>
      widget.loading ??
      FlatButton(
        onPressed: () {},
        color: Theme.of(context).primaryColor,
        child: SpinKitThreeBounce(
          color: Theme.of(context).colorScheme.onPrimary,
          size: 16.0,
        ),
      );

  void _onSubmit() {
    FocusScope.of(context).unfocus();

    _usernameController.text = _usernameController.text.trim();

    final validate = _formKey.currentState?.validate();

    if (validate) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      widget.bloc.add(
        AuthLogin(
          model: LoginModel(username, password),
        ),
      );
    }
  }

  Widget _buildForgotPassword(BuildContext context) => RichText(
        textAlign: TextAlign.end,
        text: TextSpan(
          text: widget.forgotPasswordLabel,
          style: Theme.of(context).textTheme.caption,
          recognizer: TapGestureRecognizer()
            ..onTap = widget.onForgotPasswordPressed,
        ),
      );

  Widget _buildSignUp(BuildContext context) => RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: widget.signUpLabel,
          style: widget.signUpStyle ?? Theme.of(context).textTheme.caption,
          recognizer: TapGestureRecognizer()..onTap = widget.onSignUpPressed,
        ),
      );

  Widget _buildForm(BuildContext context, bool isLoading) => Scaffold(
        appBar: widget.appBar,
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: constraints.biggest.height,
              ),
              child: Form(
                key: _formKey,
                child: Stack(
                  children: <Widget>[
                    ...widget.below,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 32.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          widget.title,
                          const SizedBox(height: 32.0),
                          _buildUsernameField(enabled: !isLoading),
                          const SizedBox(height: 16.0),
                          _buildPasswordField(enabled: !isLoading),
                          const SizedBox(height: 16.0),
                          _buildForgotPassword(context),
                          const SizedBox(height: 32.0),
                          if (isLoading)
                            _buildLoadingButton(context)
                          else
                            _buildButton(context),
                          const SizedBox(height: 32.0),
                          _buildSignUp(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => BlocConsumer(
        bloc: widget.bloc,
        listener: (BuildContext context, state) {
          if (widget.listenerHandler != null) {
            final shouldContinue = widget.listenerHandler(context, state);

            if (shouldContinue ?? false) {
              return;
            }
          }

          if (state is Authenticated) {
            if (widget.onSignIn != null) widget.onSignIn();
          }

          // TODO: Fix
          // if (state is Unauthenticated) {
          // Scaffold.of(context).showSnackBar(
          //   SnackBar(
          //     backgroundColor: Colors.red,
          //     content: Text('Falha no login!'),
          //   ),
          // );
          // }
        },
        builder: (BuildContext context, state) {
          if (widget.builderHandler != null) {
            final child = widget.builderHandler(context, state);

            if (child != null) {
              return child;
            }
          }

          if (state is UninitializedState || state is AuthLoading) {
            return _buildForm(context, true);
          }

          if (state is Unauthenticated) {
            return _buildForm(context, false);
          }

          if (state is Authenticated) {
            return _buildForm(context, true);
          }

          return Container();
        },
      );
}
