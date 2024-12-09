import 'package:get_storage/get_storage.dart';

class TLocalStorage {
  static late final GetStorage _storage;
  static TLocalStorage? _instance;

  // Singleton pattern
  factory TLocalStorage.instance() {
    _instance ??= TLocalStorage._internal();
    return _instance!;
  }

  TLocalStorage._internal();

  // Khởi tạo storage
  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _storage = GetStorage(bucketName);
  }

  // Các phương thức truy cập storage
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  Future<void> clearAll() async {
    await _storage.erase();
  }
}