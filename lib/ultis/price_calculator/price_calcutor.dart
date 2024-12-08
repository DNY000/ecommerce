class TPricingCalculator {
  /// Tính tổng giá cuối cùng bao gồm thuế và phí vận chuyển
  static double calculateFinalPrice(double subtotal, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = subtotal * taxRate;

    double shippingCost = getShippingCost(location);

    double totalPrice = subtotal + taxAmount + shippingCost;
    return totalPrice;
  }

  /// Tính phí vận chuyển
  static String calculateShippingCost(double subtotal, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  /// Tính thuế
  static String calculateTax(double subtotal, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = subtotal * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static double getTaxRateForLocation(String location) {
    // Tra cứu thuế suất cho vị trí đã cho từ cơ sở dữ liệu hoặc API
    // Trả về thuế suất phù hợp
    return 0.10; // Ví dụ: thuế suất 10%
  }

  static double getShippingCost(String location) {
    // Tra cứu chi phí vận chuyển cho vị trí đã cho bằng bảng giá vận chuyển
    // Trả về chi phí vận chuyển phù hợp
    return 5.00; // Ví dụ: phí vận chuyển $5
  }
}
