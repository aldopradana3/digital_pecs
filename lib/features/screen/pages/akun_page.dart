import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/color/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../data/app_data.dart';

class AkunPage extends StatelessWidget {
  const AkunPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        titleSpacing: 16,

        title: Row(
          children: [
            /// ICON SVG
            SvgPicture.asset(
              "assets/icon/icon_user_footer.svg",
              width: 3.h,
              height: 3.h,
              color: AppColors.biru,
            ),

            SizedBox(width: 1.5.h),

            /// TEXT
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Halo, ",
                    style: GoogleFonts.poppins(
                      fontSize: 2.h,
                      fontWeight: FontWeight.bold,
                      color: AppColors.biru,

                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),

                  TextSpan(
                    text: "Aldo",
                    style: GoogleFonts.poppins(
                      fontSize: 2.h,
                      fontWeight: FontWeight.normal,
                      color: AppColors.biru,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 2.h, right: 2.h, bottom: 2.h, top: 1.h),
        child: Column(
          children: [
            Container(
              width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 3.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Akun',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.biru,
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Padding(
                    padding: EdgeInsets.only(left: 1.5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama',
                          style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.abu_abu,
                          ),
                        ),
                        Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.abu_abu,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 6.h,
                                    height: 4.h,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/icon/icon_user.svg',
                                        height: 2.65.h,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: dataDiriSiswa[0].nama,
                                      readOnly: true,
                                      minLines: 1,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      style: GoogleFonts.poppins(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.abu_abu,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 0.5.h),
                            ],
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        Text(
                          'Email',
                          style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.abu_abu,
                          ),
                        ),
                        Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.abu_abu,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 6.h,
                                    height: 4.h,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/icon/icon_email.svg',
                                        height: 2.h,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: dataDiriSiswa[0].email,
                                      readOnly: true,
                                      minLines: 1,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      style: GoogleFonts.poppins(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.abu_abu,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 0.5.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.5.h),
                  Text(
                    'Informasi Orang Tua',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.biru,
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Padding(
                    padding: EdgeInsets.only(left: 1.5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nomor HP',
                          style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.abu_abu,
                          ),
                        ),
                        Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.abu_abu,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 6.h,
                                    height: 4.h,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/icon/icon_telpon.svg',
                                        height: 2.5.h,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: dataDiriSiswa[0].nomorHp,
                                      readOnly: true,
                                      minLines: 1,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      style: GoogleFonts.poppins(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.abu_abu,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 0.5.h),
                            ],
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        Text(
                          'Alamat',
                          style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.abu_abu,
                          ),
                        ),
                        Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.abu_abu,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 6.h,
                                    height: 4.h,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/icon/icon_alamat.svg',
                                        height: 2.5.h,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: dataDiriSiswa[0].alamat,
                                      readOnly: true,
                                      minLines: 1,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      style: GoogleFonts.poppins(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.abu_abu,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 0.5.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.5.h),
                  Text(
                    'Informasi Sekolah',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.biru,
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Padding(
                    padding: EdgeInsets.only(left: 1.5.h),
                    child: GestureDetector(
                      onTap: () async {
                        final Uri url = Uri.parse(
                          'https://maps.app.goo.gl/2KUeAe6f5E8m4W3X8',
                        );

                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 15.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Image.asset(
                          'assets/image/gambar_sekolah2.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (route) => false,
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.merah,
                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                  padding: EdgeInsets.symmetric(
                    vertical: 1.5.h,
                    horizontal: 2.h,
                  ),
                ),

                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/icon/icon_logout.svg",
                        height: 2.h,
                        color: Colors.white,
                      ),
                      SizedBox(width: 1.h),
                      Text(
                        "Keluar Akun",
                        style: GoogleFonts.poppins(
                          fontSize: 1.75.h,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }
}
