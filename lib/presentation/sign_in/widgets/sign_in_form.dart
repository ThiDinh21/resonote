import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resonote/application/auth/sign_in_form/bloc/sign_in_form_bloc.dart';
import 'package:resonote/domain/auth/auth_failure.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      builder: (context, state) {
        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              const SizedBox(height: 8),
              const Text(
                'Resonote',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                ),
                autocorrect: false,
                onChanged: (value) => context
                    .read<SignInFormBloc>()
                    .add(SignInFormEvent.emailChange(value)),
                validator: (_) => context
                    .read<SignInFormBloc>()
                    .state
                    .emailAddress
                    .value
                    .fold(
                      (fail) => fail.maybeMap(
                        invalidEmail: (_) => 'Invalid Email',
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                ),
                autocorrect: false,
                obscureText: true,
                onChanged: (value) => context
                    .read<SignInFormBloc>()
                    .add(SignInFormEvent.passwordChange(value)),
                validator: (_) =>
                    context.read<SignInFormBloc>().state.password.value.fold(
                          (fail) => fail.maybeMap(
                            shortPassword: (_) => 'Password too short',
                            orElse: () => null,
                          ),
                          (_) => null,
                        ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                      child: TextButton(
                    onPressed: () {
                      context.read<SignInFormBloc>().add(const SignInFormEvent
                          .signInWithEmailAndPasswordPressed());
                    },
                    child: const Text('Sign In'),
                  )),
                  Expanded(
                      child: TextButton(
                    onPressed: () {
                      context.read<SignInFormBloc>().add(const SignInFormEvent
                          .registerWithEmailAndPasswordPressed());
                    },
                    child: const Text('Register'),
                  )),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<SignInFormBloc>()
                      .add(const SignInFormEvent.signInWithGooglePressed());
                },
                child: const Text(
                  'Sign in with Google',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (AuthFailure fail) {
              FlushbarHelper.createError(
                  message: fail.map(
                cancelledByUser: (_) => 'Cancelled',
                serverError: (_) => 'Server error',
                emailAlreadyInUse: (_) => 'Email already in used',
                invalidEmailAndPasswordCombination: (_) =>
                    'Wrong email or password',
              ));
            },
            (_) {
              // TODO: Navigate to Home screen
            },
          ),
        );
      },
    );
  }
}
