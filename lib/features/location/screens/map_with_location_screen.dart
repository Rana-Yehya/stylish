import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:stylish/core/constants/app_colors.dart';
import 'package:stylish/core/widgets/button/custom_button.dart';

class MapWithLocationScreen extends StatefulWidget {
  const MapWithLocationScreen({super.key});

  @override
  State<MapWithLocationScreen> createState() => _MapWithLocationScreenState();
}

class _MapWithLocationScreenState extends State<MapWithLocationScreen> {
  late final MapController mapController;

  @override
  void initState() {
    mapController = MapController();
    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: LatLng(30.006623019884017, 30.975357948328504),
              ),
              children: [
                TileLayer(
                  // maxZoom: 5,
                  urlTemplate:
                      "https://api.mapbox.com/styles/v1/ranaymohamed/clvu5n3bw01zp01oc526w68rz/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicmFuYXltb2hhbWVkIiwiYSI6ImNsdnU0emZ5ZzE0azgya255ajBkMGVxZWkifQ.ofnZh_HQfe31u--xKaeFDg",
                  additionalOptions: {
                    "accessToken":
                        "pk.eyJ1IjoicmFuYXltb2hhbWVkIiwiYSI6ImNsdnU0emZ5ZzE0azgya255ajBkMGVxZWkifQ.ofnZh_HQfe31u--xKaeFDg",

                    //  "":
                  },
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 50,
                      height: 50,
                      point: LatLng(30.006623019884017, 30.975357948328504),
                      child: Icon(
                        Icons.location_pin,
                        size: 40,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 150.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Your order is un progress',
                      style: TextStyle(
                        color: Color(0xFF6E7179),
                        fontSize: 18.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'We will notify you when your order\'s status changes',
                      style: TextStyle(
                        color: Color(0xFF6E7179),
                        fontSize: 12.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    customButton(
                      onTap: () async {
                        context.pushReplacement('/main');
                      },
                      text: "Go To Main Menu",
                      //assetName: AppImages.google,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
