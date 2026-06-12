import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../core/color/app_colors.dart';
import '../../../data/app_data.dart';

class DetailAnakPage extends StatefulWidget {
  final String idSiswa;
  final String namaSiswa;
  final String emailSiswa;
  final String nomorHpSiswa;
  final String alamatSiswa;
  final String tglLahirSiswa;
  final VoidCallback onGoBack;

  const DetailAnakPage({
    super.key,
    required this.idSiswa,
    required this.namaSiswa,
    required this.emailSiswa,
    required this.nomorHpSiswa,
    required this.alamatSiswa,
    required this.tglLahirSiswa,
    required this.onGoBack,
  });

  @override
  State<DetailAnakPage> createState() => _DetailAnakPageState();
}

class _DetailAnakPageState extends State<DetailAnakPage> {
  @override
  void initState() {
    super.initState();
  }


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
                      widget.onGoBack();
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
                    "Detail Anak",
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
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Anak',
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
                                      initialValue: widget.namaSiswa,
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
                                      initialValue: widget.emailSiswa,
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
                                      initialValue: widget.nomorHpSiswa,
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
                                      initialValue: widget.alamatSiswa,
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
                        SizedBox(height: 1.5.h,),
                        Text(
                          'Tanggal Lahir',
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
                                      initialValue: formatTanggalIndonesia(
                                        widget.tglLahirSiswa,
                                      ),
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
                        SizedBox(height: 1.5.h,)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () {
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
                        "assets/icon/icon_hapus.svg",
                        height: 2.5.h,
                        color: Colors.white,
                      ),
                      SizedBox(width: 1.h),
                      Text(
                        "Hapus Anak",
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
