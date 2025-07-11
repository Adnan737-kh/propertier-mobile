import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propertier/App/Services/Model/FixedServicesModel.dart';
import 'package:propertier/App/Services/Model/services_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';

Widget servicesBox(BuildContext context, var service,
    {required VoidCallback onClick}) {
  return GestureDetector(
    onTap: onClick,
    child: SizedBox(
      width: context.getSize.width * 0.3,
      child: Column(
        children: [
          Container(
            height: 95,
            width: 95,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: border(),
                boxShadow: [boxShadow()],
                image: DecorationImage(
                  image: NetworkImage(
                    (service.images != null && service.images!.isNotEmpty)
                        ? service.images!.first
                        : 'https://via.placeholder.com/150', // fallback placeholder
                  ),
                  fit: BoxFit.cover,
                ),
            ),
          ),
          getHeight(context, 0.008),
          CustomText(
              title: service.title ?? "",
              fontSize: 12,
              fontWeight: FontWeight.w500)
        ],
      ),
    ),
  );
}

Widget fixedPriceServicesBox(BuildContext context, FixedServicesModel service,
    {required VoidCallback onClick}) {
  if (kDebugMode) {
    print("image ${service.service?.imageUrl}");
  }
  return GestureDetector(
    onTap: onClick,
    child: SizedBox(
      width: context.getSize.width * 0.3,
      child: Column(
        children: [
          Container(
            height: 95,
            width: 95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: border(),
              boxShadow: [boxShadow()],
              color: Colors.white, // Fallback background
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SvgPicture.network(
                service.service?.imageUrl ?? "",
                fit: BoxFit.cover,
                placeholderBuilder: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          getHeight(context, 0.008),
          CustomText(
              title: service.title ?? "",
              fontSize: 12,
              fontWeight: FontWeight.w500)
        ],
      ),
    ),
  );
}

Widget topSellingServices2(BuildContext context, ServicesModel services,
    {required VoidCallback onClick}) {
  return GestureDetector(
    onTap: onClick,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: context.getSize.width * 0.008),
      child: Column(
        children: [
          Container(
            height: context.getSize.height * 0.15,
            width: context.getSize.width * 0.6,
            decoration: BoxDecoration(
                boxShadow: [boxShadow()],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: const DecorationImage(
                    image: NetworkImage(Constant.dummyImage2),
                    fit: BoxFit.cover)),
          ),
          Container(
              padding: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.024,
                  vertical: context.getSize.height * 0.012),
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [boxShadow()]),
              width: context.getSize.width * 0.6,
              child: CustomText(
                  title: services.title,
                  fontSize: 12,
                  fontWeight: FontWeight.w500))
        ],
      ),
    ),
  );
}
