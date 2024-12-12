import 'package:app1/features/personalization/screens/profile/profile.dart';
import 'package:app1/features/personalization/screens/settings/settings.dart';
import 'package:app1/features/shop/models/brand_model.dart';
import 'package:app1/features/shop/models/category_model.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:app1/features/shop/screens/brand/all_brand.dart';
import 'package:app1/features/shop/screens/cart/cart.dart';
import 'package:app1/features/shop/screens/checkout/checkout.dart';
import 'package:app1/features/shop/screens/home/home_screen.dart';
import 'package:app1/features/shop/screens/home/user/user_screen.dart';
import 'package:app1/features/shop/screens/order/order.dart';
import 'package:app1/features/shop/screens/product_detail/widgets/product_detail.dart';
import 'package:app1/features/shop/screens/product_reviews/product_reviews_screen.dart';
import 'package:app1/features/shop/screens/store/store_screen.dart';
import 'package:app1/features/shop/screens/wishlist/favourite_screen.dart';
import 'package:app1/routes/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../features/shop/screens/notification/notification.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: TRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: TRoutes.store,
      page: () => StoreScreen(
        brandModel: BrandModel.empty(),
        categoryModel: CategoryModel.empty(),
        productModel: ProductModel.empty(),
      ),
    ),
    GetPage(
      name: TRoutes.favourites,
      page: () => const Favouritescreen(),
    ),
    GetPage(
      name: TRoutes.settings,
      page: () => const SettingsScreen(),
    ),
    GetPage(
      name: TRoutes.productReviews,
      page: () => const ProductReviewsScreen(),
    ),
    GetPage(
      name: TRoutes.productDetail,
      page: () => ProductDetail(productModel: ProductModel.empty()),
    ),
    GetPage(
      name: TRoutes.order,
      page: () => const OrderSreen(),
    ),
    GetPage(
      name: TRoutes.checkout,
      page: () => const CheckoutScreen(),
    ),
    GetPage(
      name: TRoutes.cart,
      page: () => const CartScreen(),
    ),
    GetPage(
      name: TRoutes.brand,
      page: () => const AllBrandScreen(productModel: []),
    ),
    GetPage(
      name: TRoutes.userAddress,
      page: () => const UserScreen(),
    ),
    GetPage(
      name: TRoutes.userProfile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: TRoutes.notification,
      page: () => const NotificationScreen(message: RemoteMessage()),
    ),
  ];
}
