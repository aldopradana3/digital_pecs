import 'package:digital_pecs/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../core/color/app_colors.dart';
import '../../../data/app_data.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onOpenKelolaModul;
  final VoidCallback onOpenKelolaAnak;
  final VoidCallback onOpenMariBermain;
  final VoidCallback onOpenProfile;

  const HomePage({
    super.key,
    required this.onOpenKelolaModul,
    required this.onOpenProfile,
    required this.onOpenMariBermain,
    required this.onOpenKelolaAnak,
  });

  @override
  Widget build(BuildContext context) {
    final bool isGuru = User.role == "Guru" || User.role == "SuperAdmin";

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

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.h),
        child: SizedBox.expand(
          child: Column(
            children: [
              SizedBox(height: 6.h),
              Image.asset("assets/icon/icon_pecs.png", height: 15.h),
              SizedBox(height: 4.h),
              isGuru
                  ? Column(
                      children: [
                        SizedBox(
                          width: double.infinity,

                          child: ElevatedButton(
                            onPressed: () {
                              onOpenKelolaAnak;
                              print("Token sekarang: ${User.token}");
                              print("Header sekarang: ${ApiService.headers}");
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.biru,
                              foregroundColor: Colors.white,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),

                              padding: EdgeInsets.symmetric(
                                vertical: 1.5.h,
                                horizontal: 2.h,
                              ),
                            ),

                            child: Text(
                              "Kelola Anak",
                              style: GoogleFonts.poppins(
                                fontSize: 1.75.h,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        SizedBox(
                          width: double.infinity,

                          child: ElevatedButton(
                            onPressed: onOpenKelolaModul,

                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.biru,
                              foregroundColor: Colors.white,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),

                              padding: EdgeInsets.symmetric(
                                vertical: 1.5.h,
                                horizontal: 2.h,
                              ),
                            ),

                            child: Text(
                              "Kelola Modul",
                              style: GoogleFonts.poppins(
                                fontSize: 1.75.h,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        SizedBox(
                          width: double.infinity,

                          child: ElevatedButton(
                            onPressed: onOpenProfile,

                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.biru,
                              foregroundColor: Colors.white,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),

                              padding: EdgeInsets.symmetric(
                                vertical: 1.5.h,
                                horizontal: 2.h,
                              ),
                            ),

                            child: Text(
                              "Profile",
                              style: GoogleFonts.poppins(
                                fontSize: 1.75.h,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(
                          width: double.infinity,

                          child: ElevatedButton(
                            onPressed: onOpenMariBermain,

                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.biru,
                              foregroundColor: Colors.white,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),

                              padding: EdgeInsets.symmetric(
                                vertical: 1.5.h,
                                horizontal: 2.h,
                              ),
                            ),

                            child: Text(
                              "Mari Bermain",
                              style: GoogleFonts.poppins(
                                fontSize: 1.75.h,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        SizedBox(
                          width: double.infinity,

                          child: ElevatedButton(
                            onPressed: onOpenProfile,

                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.biru,
                              foregroundColor: Colors.white,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),

                              padding: EdgeInsets.symmetric(
                                vertical: 1.5.h,
                                horizontal: 2.h,
                              ),
                            ),

                            child: Text(
                              "Profile",
                              style: GoogleFonts.poppins(
                                fontSize: 1.75.h,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
