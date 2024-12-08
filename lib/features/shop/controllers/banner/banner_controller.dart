import 'package:app1/data/repositories/banner/banner_repository.dart';
import 'package:app1/features/shop/models/banner_model.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  final currentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  void upLoadIndexPage(value) {
    currentIndex.value = value;
  }

  @override
  void onInit() {
    fetchBanner();
    super.onInit();
  }

  Future<void> fetchBanner() async {
    try {
      isLoading.value = true;
      final bannerRepo = Get.put(BannerRepository());
      final fetchedBanners = await bannerRepo.fetchBanner();
      banners.assignAll(fetchedBanners);

      // In ra imageURL của từng banner
      // for (var banner in banners) {
      //   // print(banner.imageURL);
      // }
    } catch (e) {
      throw 'Lỗi $e';
    } finally {
      isLoading.value = false;
    }
  }
}
