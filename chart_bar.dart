import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double totalAmount;
  final double totalPctAmount;

  ChartBar(this.label, this.totalAmount, this.totalPctAmount);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, Constraints) {
      return Column(children: [
        SizedBox(
          height: Constraints.maxHeight * 0.15,
          child: FittedBox(
            child: Text('\$${totalAmount.toStringAsFixed(0)}'),
          ),
        ),
        SizedBox(
          height: Constraints.maxHeight * 0.05,
        ),
        SizedBox(
          height: Constraints.maxHeight * 0.6,
          width: 10,
          child: Stack(
            children: [
              SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              FractionallySizedBox(
                heightFactor: totalPctAmount,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Constraints.maxHeight * 0.05,
        ),
        Container(
            height: Constraints.maxHeight * 0.15,
            child: FittedBox(child: Text(label))),
      ]);
    });
  }
}
