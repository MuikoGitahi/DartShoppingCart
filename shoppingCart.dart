void main() {
  //items in the cart
  List<double> itemPrices = [5.99, 15.49, 25.00, 7.50, 30.00];

  // Tax rate 
  double taxRate = 0.07; // 7% tax rate

  // Maximum discount percentage
  double maxDiscountPercentage = 50.0; // Cap the discount to a maximum of 50%

  // Filter out items under $10
  var filteredPrices = itemPrices.where((price) => price >= 10).toList();
  print("Filtered Prices (items >= \$10): $filteredPrices");

  // Apply a 10% discount to all items
  var discountedPrices = applyDiscount(filteredPrices, (price) => price * 0.90);
  print("Prices after 10% discount: $discountedPrices");

  // Calculate the total price after discount
  double totalPrice = calculateTotal(discountedPrices, taxRate);
  print("Total Price after tax: \$${totalPrice.toStringAsFixed(2)}");

  // Calculate factorial-based discount with a cap
  double specialDiscount = calculateFactorialDiscount(filteredPrices.length, maxDiscountPercentage);
  double finalPriceWithSpecialDiscount = totalPrice * (1 - specialDiscount / 100);
  print("Final Price after special discount: \$${finalPriceWithSpecialDiscount.toStringAsFixed(2)}");
}

// Function to calculate the total price after tax
double calculateTotal(List<double> prices, [double taxRate = 0.0]) {
  double total = prices.fold(0, (sum, price) => sum + price);
  return total * (1 + taxRate);
}

// Higher-order function to apply a discount
List<double> applyDiscount(List<double> prices, double Function(double) discountFunction) {
  return prices.map(discountFunction).toList();
}

// Recursive function to calculate factorial-based discount with a cap
double calculateFactorialDiscount(int n, double maxDiscountPercentage) {
  if (n <= 1) return 1.0; // Base case: 0! = 1! = 1
  double factorial = n * calculateFactorialDiscount(n - 1, maxDiscountPercentage);
  // Calculate discount as factorial percentage but cap it to maxDiscountPercentage
  return factorial > maxDiscountPercentage ? maxDiscountPercentage : factorial;
}
