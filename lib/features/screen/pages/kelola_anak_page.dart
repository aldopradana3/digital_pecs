import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

import '../../../core/color/app_colors.dart';
import '../../../data/app_data.dart';

class KelolaAnakPage extends StatelessWidget {
  final VoidCallback onOpenTambahAnak;
  final Function(
    String id,
    String nama,
    String email,
    String noHp,
    String alamat,
    String tglLahir,
  )
  onOpenDetailAnak;
  final VoidCallback onGoBack;

  const KelolaAnakPage({
    super.key,
    required this.onOpenTambahAnak,
    required this.onOpenDetailAnak,
    required this.onGoBack,
  });

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
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
                    "Kelola Anak",
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
            ...daftarSiswa.map((siswa) {
              return Padding(
                padding: EdgeInsets.only(bottom: 1.5.h),
                child: InkWell(
                  onTap: () {
                    onOpenDetailAnak(
                      siswa.id,
                      siswa.nama,
                      siswa.email,
                      siswa.nomorHp,
                      siswa.alamat,
                      siswa.tglLahir,
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.5.h,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.biru,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            siswa.nama,
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
            SizedBox(height: 7.5.h,)
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          right: 2.h,
          bottom: 2.h,
        ),
        child: InkWell(
          onTap: onOpenTambahAnak,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 5.5.h,
            padding: EdgeInsets.symmetric(
              horizontal: 1.5.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.biru,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Tambah Anak",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(width: 1.h),

                SvgPicture.asset(
                  "assets/icon/icon_plus.svg",
                  width: 2.h,
                  height: 2.h,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
