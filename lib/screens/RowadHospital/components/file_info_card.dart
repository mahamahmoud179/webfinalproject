import 'package:admin/models/Devices.dart';
import 'package:admin/models/MyFiles.dart';
import 'package:admin/screens/RowadHospital/components/device_history_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key? key,
    required this.device,
  }) : super(key: key);

  final Device device;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('requests').where("device_id", isEqualTo: device.id).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return InkWell(
          onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DeviceHistoryScreen( departmentID: device.departmentID,deviceID: device.id, deviceName: device.name))),
          child: Container(
            height: 150.0,
            width: 150.0,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius:  BorderRadius.circular(10),
              image: DecorationImage(image: NetworkImage(device.image!),fit: BoxFit.cover),
            ),
            child: Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor.withOpacity(0.8),
                borderRadius:  BorderRadius.circular(10),
                image: DecorationImage(image: NetworkImage(device.image!),fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(defaultPadding * 0.75),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),

                  ),
                  Text(
                    device.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${snapshot.data!.docs.length} Requests",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.white70),
                      ),
                      Container()
                      // Text(
                      //   info.totalStorage!,
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .caption!
                      //       .copyWith(color: Colors.white),
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
