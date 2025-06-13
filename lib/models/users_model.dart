class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String city;
  final String pincode;
  final String state;
  final String profilePicUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.pincode,
    required this.state,
    required this.profilePicUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['user_id'],
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      address: map['address_line'] ?? '',
      city: map['city'] ?? '',
      pincode: map['postal_code'] ?? '',
      state: map['state'] ?? '',
      profilePicUrl: map['profile_pic_url'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone_number': phoneNumber,
      'address': address,
      'city': city,
      'pincode': pincode,
      'state': state,
    };
  }

  UserModel copyWith({
    String? name,
    String? phoneNumber,
    String? address,
    String? city,
    String? pincode,
    String? state,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
      state: state ?? this.state,
      profilePicUrl: profilePicUrl,
    );
  }
}
