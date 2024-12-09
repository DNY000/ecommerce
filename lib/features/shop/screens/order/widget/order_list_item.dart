import 'package:app1/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:app1/features/shop/controllers/order/order_controller.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class TOrderListView extends StatelessWidget {
  const TOrderListView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = TheplerFunction.isDarkMode(context);
    final orderController = Get.put(OrderController());
    return FutureBuilder(
      future: orderController.fetchUserOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Đã xảy ra lỗi: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Không có đơn hàng nào'),
          );
        }

        final orders = snapshot.data!;
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(
            height: 8,
          ),
          itemCount: orders.length,
          itemBuilder: (_, index) {
            final order = orders[index];
            return TCircularContainer(
              isShowBorder: true,
              radius: 20,
              padding: 20,
              margin: 20,
              background: dark ? Colors.grey.shade700 : Colors.grey.shade50,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //ROw 1
                    Row(
                      children: [
                        const Icon(FontAwesomeIcons.truckFast),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(order.status.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .apply(color: Colors.blueGrey)),
                              Text(
                                order.orderDate.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .apply(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        const Icon(FontAwesomeIcons.angleRight)
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    // row 2
                    Row(
                      children: [
                        Expanded(
                            child: Row(
                          children: [
                            Row(
                              children: [
                                const Icon(FontAwesomeIcons.tag),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Other',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .apply(color: Colors.grey),
                                    ),
                                    Text(
                                      '#233233',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .apply(color: Colors.grey),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        )),
                        Expanded(
                            child: Row(
                          children: [
                            Row(
                              children: [
                                const Icon(FontAwesomeIcons.calendar),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Ngày giao hàng',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .apply(color: Colors.grey),
                                    ),
                                    Text(
                                      ' 20, nov 2024',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .apply(color: Colors.grey),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ))
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
