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
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['extra_price'] = extraPrice;
    data['status'] = status;
    data['status_reason'] = statusReason;
    data['payment_status'] =paymentStatus;
    data['order_tracking'] =orderTracking;
    data['total_amount'] = totalAmount;
    data['service_location'] = serviceLocation;
    data['vendor_deduction_amount'] = vendorDeductionAmount;
    data['work_description'] = workDescription;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['image_urls'] = imageUrls;
    data['submission_status'] =submissionStatus;
    data['vendor'] = vendor;
    data['customer'] =customer;
    data['service'] = service;
    data['bid'] = bid;
    data['customer_coupon'] =customerCoupon;
    data['vendor_coupon'] = vendorCoupon;
    data['selected_sub_services'] = selectedSubServices;
    return data;
  }
}
