class ServiceOrderModel {
  int? id;
  String? extraPrice;
  String? status;
  String? statusReason;
  String? paymentStatus;
  String? orderTracking;
  String? totalAmount;
  String? serviceLocation;
  String? vendorDeductionAmount;
  String? workDescription;
  String? createdAt;
  String? updatedAt;
  List<String>? imageUrls;
  String? submissionStatus;
  int? vendor;
  int? customer;
  int? service;
  int? bid;
  String? customerCoupon;
  String? vendorCoupon;
  List<int>? selectedSubServices;

  ServiceOrderModel(
      {this.id,
        this.extraPrice,
        this.status,
        this.statusReason,
        this.paymentStatus,
        this.orderTracking,
        this.totalAmount,
        this.serviceLocation,
        this.vendorDeductionAmount,
        this.workDescription,
        this.createdAt,
        this.updatedAt,
        this.imageUrls,
        this.submissionStatus,
        this.vendor,
        this.customer,
        this.service,
        this.bid,
        this.customerCoupon,
        this.vendorCoupon,
        this.selectedSubServices});

  ServiceOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    extraPrice = json['extra_price'];
    status = json['status'];
    statusReason = json['status_reason'];
    paymentStatus = json['payment_status'];
    orderTracking = json['order_tracking'];
    totalAmount = json['total_amount'];
    serviceLocation = json['service_location'];
    vendorDeductionAmount = json['vendor_deduction_amount'];
    workDescription = json['work_description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageUrls = json['image_urls'].cast<String>();
    submissionStatus = json['submission_status'];
    vendor = json['vendor'];
    customer = json['customer'];
    service = json['service'];
    bid = json['bid'];
    customerCoupon = json['customer_coupon'];
    vendorCoupon = json['vendor_coupon'];
    selectedSubServices = json['selected_sub_services'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['extra_price'] = this.extraPrice;
    data['status'] = this.status;
    data['status_reason'] = this.statusReason;
    data['payment_status'] = this.paymentStatus;
    data['order_tracking'] = this.orderTracking;
    data['total_amount'] = this.totalAmount;
    data['service_location'] = this.serviceLocation;
    data['vendor_deduction_amount'] = this.vendorDeductionAmount;
    data['work_description'] = this.workDescription;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_urls'] = this.imageUrls;
    data['submission_status'] = this.submissionStatus;
    data['vendor'] = this.vendor;
    data['customer'] = this.customer;
    data['service'] = this.service;
    data['bid'] = this.bid;
    data['customer_coupon'] = this.customerCoupon;
    data['vendor_coupon'] = this.vendorCoupon;
    data['selected_sub_services'] = this.selectedSubServices;
    return data;
  }
}
