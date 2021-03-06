import 'package:ecommerce/app/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthWidget extends ConsumerWidget {
  final WidgetBuilder nonSignedInBuilder;
  final WidgetBuilder signedInBuilder;
  final WidgetBuilder adminSignedInBuilder;

  const AuthWidget(
      {Key? key,
      required this.signedInBuilder,
      required this.nonSignedInBuilder,
      required this.adminSignedInBuilder})
      : super(key: key);

  final adminEmail = "admin@admin.com";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChanges = ref.watch(authStateChangesProvider);
    const adminEmail = "admin@admin.com"; // store this somewhere else

    return authStateChanges.when(
      data: (user) => user != null
          ? user.email == adminEmail
              ? adminSignedInBuilder(context)
              : signedInBuilder(context)
          : nonSignedInBuilder(context),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => const Scaffold(
        body: Center(
          child: Text("Something went wrong!"),
        ),
      ),
    );
  }
}
