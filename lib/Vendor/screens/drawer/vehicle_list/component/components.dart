import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../model/VehicleModel.dart';

class CarCard extends StatelessWidget {
  final VehicleModel vehicle;

  CarCard({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car Title and Owner
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${vehicle.make ?? ''} ${vehicle.model ?? ''} (${vehicle.year ?? ''})',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  vehicle.ownerName ?? 'Unknown Owner',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Image Carousel

            // Image Carousel
            if (vehicle.images != null && vehicle.images!.isNotEmpty)
              SizedBox(
                height: 200,
                child: PageView.builder(
                  itemCount: vehicle.images!.length,
                  itemBuilder: (context, index) {
                    final image = vehicle.images![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          image.imageUrl ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.broken_image, size: 80),
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              Container(
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: Text('No Images Available'),
              ),
            SizedBox(height: 8),

            // Registration and Color
            Row(
              children: [
                Icon(Icons.confirmation_number, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Reg. No: ${vehicle.registrationNumber ?? 'N/A'}',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.color_lens, color: Colors.redAccent),
                SizedBox(width: 8),
                Text(
                  'Color: ${vehicle.color ?? 'N/A'}',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 8),

            // Capacity and Fuel Type
            Row(
              children: [
                Icon(Icons.people, color: Colors.amber),
                SizedBox(width: 8),
                Text(
                  'Capacity: ${vehicle.capacity ?? 'N/A'}',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),

            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.local_gas_station, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  'Fuel: ${vehicle.fuelType ?? 'N/A'}',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 8),

            // Transmission Type
            Row(
              children: [
                Icon(Icons.settings, color: Colors.black38),
                SizedBox(width: 8),
                Text(
                  'Transmission: ${vehicle.transmissionType ?? 'N/A'}',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Created and Updated Date
            Text(
              'Created on: ${vehicle.createdAt ?? 'N/A'}',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              'Last Updated: ${vehicle.updatedAt ?? 'N/A'}',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
