import 'package:admin/controllers/department_controller.dart';
import 'package:admin/models/Devices.dart';
import 'package:admin/models/MyFiles.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/RowadHospital/today_requests_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'file_info_card.dart';

class MyFiles extends StatefulWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  _MyFilesState createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Consumer<DepartmentController>(
        builder: (context, departmentController, child) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today requests",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              ElevatedButton.icon(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding * 1.5,
                          vertical: defaultPadding /
                              (Responsive.isMobile(context) ? 2 : 1),
                        ),
                      ),
                      onPressed: ()=>Navigator.of(context).pushNamed(TodayRequestsScreen.id),
                      icon: Icon(Icons.add),
                      label: Text("See all"),
                    ),
            ],
          ),
          SizedBox(height: defaultPadding),
          departmentController.isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Responsive(
            mobile: Container(),
          // mobile:FileInfoCardGridView(
          // // crossAxisCount: _size.width < 650 ? 2 : 4,
          // // childAspectRatio: _size.width < 650 ? 1.3 : 1,
          // devices: departmentController.allDevices,
          // ),
            tablet: FileInfoCardGridView(
              devices: departmentController.allDevices,
            ),
            desktop: FileInfoCardGridView(
              // childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
              devices: departmentController.allDevices,
            ),
          ),
        ],
      );
    });
  }
}

class FileInfoCardGridView extends StatelessWidget {
  FileInfoCardGridView({
    Key? key,
    required this.devices,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  List<Device> devices=[];

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 160.0,
      width: double.infinity,
      child: ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: devices.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => FileInfoCard(device: devices[index],),
          ),
    );

    // return GridView.builder(
    //   physics: NeverScrollableScrollPhysics(),
    //   shrinkWrap: true,
    //   itemCount: devices.length,
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: crossAxisCount,
    //     crossAxisSpacing: defaultPadding,
    //     mainAxisSpacing: defaultPadding,
    //     childAspectRatio: childAspectRatio,
    //   ),
    //   itemBuilder: (context, index) => FileInfoCard(device: devices[index],),
    // );
  }
}
