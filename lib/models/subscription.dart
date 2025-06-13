class Subscription {
  final String id;
  final String userId;
  final String razorpaySubscriptionId;
  final String razorpayPaymentId;
  final String razorpaySignature;
  final String status;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? nextBillingDate;
  final String planId;
  final int totalCount;
  final int remainingCount;
  final DateTime createdAt;

  Subscription({
    required this.id,
    required this.userId,
    required this.razorpaySubscriptionId,
    required this.razorpayPaymentId,
    required this.razorpaySignature,
    required this.status,
    this.startDate,
    this.endDate,
    this.nextBillingDate,
    required this.planId,
    required this.totalCount,
    required this.remainingCount,
    required this.createdAt,
  });

  factory Subscription.fromMap(Map<String, dynamic> map) {
    return Subscription(
      id: map['id'],
      userId: map['user_id'],
      razorpaySubscriptionId: map['razorpay_subscription_id'],
      razorpayPaymentId: map['razorpay_payment_id'],
      razorpaySignature: map['razorpay_signature'],
      status: map['status'],
      startDate: map['start_date'] != null ? DateTime.tryParse(map['start_date']) : null,
      endDate: map['end_date'] != null ? DateTime.tryParse(map['end_date']) : null,
      nextBillingDate: map['next_billing_date'] != null ? DateTime.tryParse(map['next_billing_date']) : null,
      planId: map['plan_id'],
      totalCount: map['total_count'],
      remainingCount: map['remaining_count'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'razorpay_subscription_id': razorpaySubscriptionId,
      'razorpay_payment_id': razorpayPaymentId,
      'razorpay_signature': razorpaySignature,
      'status': status,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'next_billing_date': nextBillingDate?.toIso8601String(),
      'plan_id': planId,
      'total_count': totalCount,
      'remaining_count': remainingCount,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
