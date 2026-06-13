import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../core/color/app_colors.dart';
import '../../../data/app_data.dart';

class KelolaModulPage extends StatelessWidget {
  final Function(String idModul, String namaModul) onOpenDetailModul;
  final VoidCallback onGoBack;

  const KelolaModulPage({
    super.key,
    required this.onOpenDetailModul,
    required this.onGoBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(9.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // BACK BUTTON
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      onGoBack();
                    },
                    child: Container(
                      width: 4.5.h,
                      height: 4.5.h,
                      decoration: BoxDecoration(
                        color: AppColors.hijau,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icon/icon_back.svg",
                          width: 2.h,
                          height: 2.h,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                // TITLE
                Container(
                  height: 4.5.h,
                  width: 21.h,
                  padding: EdgeInsets.symmetric(horizontal: 1.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.biru,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    "Kelola Modul",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 1.65.h,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(2.h),
        child: Column(
          children: [
            ...daftarModul.map((modul) {
              return Padding(
                padding: EdgeInsets.only(bottom: 1.5.h),
                child: InkWell(
                  onTap: () {
                    onOpenDetailModul(modul.id, modul.nama);
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: 2.5.h,
                      top: 1.75.h,
                      bottom: 1.75.h,
                      right: 3.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.biru,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            modul.gambar,
                            width: 8.h,
                            height: 8.h,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(width: 1.25.h),

                        Expanded(
                          child: Text(
                            modul.nama,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 2.h),
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: SvgPicture.asset(
                            "assets/icon/icon_back.svg",
                            width: 2.2.h,
                            height: 2.2.h,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
