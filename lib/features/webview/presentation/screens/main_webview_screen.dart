import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noji/features/webview/presentation/cubit/webview_cubit.dart';
import 'package:noji/features/webview/presentation/widgets/webview_content_view.dart';

class MainWebViewScreen extends StatelessWidget {
  const MainWebViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WebviewCubit>(
      create: (_) => WebviewCubit(),
      child: const WebviewContentView(),
    );
  }
}
