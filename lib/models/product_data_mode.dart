//
/// Model class for ProductData like what the users add to the cart or whatever;
//
class ProductModel {
  final String userId;
  final String email;

  ProductModel({required this.userId, required this.email});

  factory ProductModel.fromMap(Map<String, dynamic> data, String documentId) {
    final String userId = data['userId'];
    final String email = data['email'];

    return ProductModel(userId: userId, email: email);
  }

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'email': email};
  }
}
