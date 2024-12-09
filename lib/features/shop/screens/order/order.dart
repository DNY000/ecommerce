import 'package:app1/common/appbar/appbar.dart';
import 'package:app1/features/shop/screens/order/widget/order_list_item.dart';
import 'package:flutter/material.dart';

class OrderSreen extends StatelessWidget {
  const OrderSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(
        title: Text('Đơn hàng'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: TOrderListView(),
      ),
    );
  }
}
