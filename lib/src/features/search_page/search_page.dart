import 'package:bigboss/src/features/search_page/cubit/search_cubit.dart';
import 'package:bigboss/src/features/search_page/search_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/common/widgets/app_bar_view.dart';
import '../../injection.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => serviceLocator<SearchCubit>(),
        child: Scaffold(

          body: SearchBody(

          ),
        )
    );
  }
}
