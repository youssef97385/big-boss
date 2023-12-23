import 'package:bigboss/src/features/address/logic/address_cubit.dart';
import 'package:bigboss/src/features/address/widget/address_list_body.dart';
import 'package:bigboss/src/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/widgets/app_bar_view.dart';

class AddressList extends StatefulWidget {
  const AddressList({super.key});

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: AppBarView(
          appBarTitle: 'Addresses',
        ),
      ),
      body:  AddressListBody(),

    );
  }
}
