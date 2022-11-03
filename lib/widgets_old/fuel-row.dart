import 'package:flutter/material.dart';

enum FuelType { pb, on, lpg }

class FuelRow extends StatelessWidget {
  final FuelType fuel;
  final double price;

  const FuelRow({Key? key, required this.fuel, required this.price})
      : super(key: key);

  get fuelType {
    switch (fuel) {
      case FuelType.pb:
        return "PB";
      case FuelType.on:
        return "ON";
      case FuelType.lpg:
        return "LPG";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            SizedBox(
              width: 40,
              child: Text(
                fuelType,
              ),
            ),
            const Spacer(),
            Text(price.toStringAsFixed(2))
          ],
        ));
  }
}
