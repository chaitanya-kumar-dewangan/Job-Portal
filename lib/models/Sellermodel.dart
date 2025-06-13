// class Seller {
//   final String id;
//   final String segment;
//   final List<String> aadhaarUrls;
//   final String storeName;
//   final String businessPanNumber;
//   final String gstNumber;
//   final String gstType;
//   final String addressLine1;
//   final String storeCity;
//   final String storeState;
//   final String storePostalCode;
//   final String storeAddressUrl;
//   final String storeLandmark;
//   final String addressDocUrl;
//   final String bankDocUrl;
//   final String bankName;
//   final String bankIfscCode;
//   final String accountNumber;
//   final String createdAt;
//   final bool isActivate;
//   final double latitude;
//   final double longitude;
//   final String sellerName;
//   final String sellerContact;
//   final String sellerEmail;
//   final String sellerAddress;
//   final String sellerCity;
//   final String sellerState;
//   final String sellerPostalCode;
//   final String profileUrl;
//   final String bankAccountName;
//   final String sellerDistrict;
//   final String storeDistrict;
//   final String aadhaarNumber;
//
//   Seller({
//     required this.id,
//     required this.segment,
//     required this.aadhaarUrls,
//     required this.storeName,
//     required this.businessPanNumber,
//     required this.gstNumber,
//     required this.gstType,
//     required this.addressLine1,
//     required this.storeCity,
//     required this.storeState,
//     required this.storePostalCode,
//     required this.storeAddressUrl,
//     required this.storeLandmark,
//     required this.addressDocUrl,
//     required this.bankDocUrl,
//     required this.bankName,
//     required this.bankIfscCode,
//     required this.accountNumber,
//     required this.createdAt,
//     required this.isActivate,
//     required this.latitude,
//     required this.longitude,
//     required this.sellerName,
//     required this.sellerContact,
//     required this.sellerEmail,
//     required this.sellerAddress,
//     required this.sellerCity,
//     required this.sellerState,
//     required this.sellerPostalCode,
//     required this.profileUrl,
//     required this.bankAccountName,
//     required this.sellerDistrict,
//     required this.storeDistrict,
//     required this.aadhaarNumber,
//   });
//
//   // Factory method to create a Seller instance from a map (e.g., from a database or API response)
//   factory Seller.fromMap(Map<String, dynamic> map) {
//     return Seller(
//       id: map['id'] ?? '',
//       segment: map['segment'] ?? '',
//       aadhaarUrls: List<String>.from(map['aadhaar_urls'] ?? []),
//       storeName: map['store_name'] ?? '',
//       businessPanNumber: map['business_pan_number'] ?? '',
//       gstNumber: map['gst_number'] ?? '',
//       gstType: map['gst_type'] ?? '',
//       addressLine1: map['address_line_1'] ?? '',
//       storeCity: map['store_city'] ?? '',
//       storeState: map['store_state'] ?? '',
//       storePostalCode: map['store_postal_code'] ?? '',
//       storeAddressUrl: map['store_address_url'] ?? '',
//       storeLandmark: map['store_landmark'] ?? '',
//       addressDocUrl: map['address_doc_url'] ?? '',
//       bankDocUrl: map['bank_doc_url'] ?? '',
//       bankName: map['bank_name'] ?? '',
//       bankIfscCode: map['bank_ifsc_code'] ?? '',
//       accountNumber: map['account_number'] ?? '',
//       createdAt: map['created_at'] ?? '',
//       isActivate: map['is_activate'] ?? false,
//       latitude: map['latitude']?.toDouble() ?? 0.0,
//       longitude: map['longitude']?.toDouble() ?? 0.0,
//       sellerName: map['seller_name'] ?? '',
//       sellerContact: map['seller_contact'] ?? '',
//       sellerEmail: map['seller_email'] ?? '',
//       sellerAddress: map['seller_address'] ?? '',
//       sellerCity: map['seller_city'] ?? '',
//       sellerState: map['seller_state'] ?? '',
//       sellerPostalCode: map['seller_postal_code'] ?? '',
//       profileUrl: map['profile_urls'] ?? '',
//       bankAccountName: map['bank_account_name'] ?? '',
//       sellerDistrict: map['seller_district'] ?? '',
//       storeDistrict: map['store_district'] ?? '',
//       aadhaarNumber: map['aadhaar_number'] ?? '',
//     );
//   }
//
//   // Method to convert the Seller instance into a map (e.g., for inserting into a database)
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'segment': segment,
//       'aadhaar_urls': aadhaarUrls,
//       'store_name': storeName,
//       'business_pan_number': businessPanNumber,
//       'gst_number': gstNumber,
//       'gst_type': gstType,
//       'address_line_1': addressLine1,
//       'store_city': storeCity,
//       'store_state': storeState,
//       'store_postal_code': storePostalCode,
//       'store_address_url': storeAddressUrl,
//       'store_landmark': storeLandmark,
//       'address_doc_url': addressDocUrl,
//       'bank_doc_url': bankDocUrl,
//       'bank_name': bankName,
//       'bank_ifsc_code': bankIfscCode,
//       'account_number': accountNumber,
//       'created_at': createdAt,
//       'is_activate': isActivate,
//       'latitude': latitude,
//       'longitude': longitude,
//       'seller_name': sellerName,
//       'seller_contact': sellerContact,
//       'seller_email': sellerEmail,
//       'seller_address': sellerAddress,
//       'seller_city': sellerCity,
//       'seller_state': sellerState,
//       'seller_postal_code': sellerPostalCode,
//       'profile_urls': profileUrl,
//       'bank_account_name': bankAccountName,
//       'seller_district': sellerDistrict,
//       'store_district': storeDistrict,
//       'aadhaar_number': aadhaarNumber,
//     };
//   }
// }


class Seller {
  final String id;
  final String storeName;
  final String addressLine1;
  final String storeCity;
  final String storeState;
  final String storePostalCode;
  final String storeLandmark;
  final String sellerName;
  final String sellerContact;
  final String sellerEmail;
  final String storeDistrict;

  Seller({
    required this.id,
    required this.storeName,
    required this.addressLine1,
    required this.storeCity,
    required this.storeState,
    required this.storePostalCode,
    required this.storeLandmark,
    required this.sellerName,
    required this.sellerContact,
    required this.sellerEmail,
    required this.storeDistrict,
  });

  factory Seller.fromMap(Map<String, dynamic> map) {
    return Seller(
      id: map['id'] ?? '',
      storeName: map['store_name'] ?? '',
      addressLine1: map['address_line_1'] ?? '',
      storeCity: map['store_city'] ?? '',
      storeState: map['store_state'] ?? '',
      storePostalCode: map['store_postal_code'] ?? '',
      storeLandmark: map['store_landmark'] ?? '',
      sellerName: map['seller_name'] ?? '',
      sellerContact: map['seller_contact'] ?? '',
      sellerEmail: map['seller_email'] ?? '',
      storeDistrict: map['store_district'] ?? '',
    );
  }
}
