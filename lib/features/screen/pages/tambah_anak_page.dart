import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../core/color/app_colors.dart';
import '../../../data/app_data.dart';

class TambahAnakPage extends StatefulWidget {
  final VoidCallback onGoBack;

  const TambahAnakPage({
    super.key,
    required this.onGoBack,
  });

  @override
  State<TambahAnakPage> createState() => _TambahAnakPageState();
}

class _TambahAnakPageState extends State<TambahAnakPage> {

  late TextEditingController namaController;
  late TextEditingController emailController;
  late TextEditingController nomorHpController;
  late TextEditingController alamatController;
  late TextEditingController tglLahirController;
  String tglLahirValue = "";

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController();
    emailController = TextEditingController();
    nomorHpController = TextEditingController();
    alamatController = TextEditingController();
    tglLahirController = TextEditingController();
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    nomorHpController.dispose();
    alamatController.dispose();
    tglLahirController.dispose();
    super.dispose();
  }

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
                      FocusScope.of(context).unfocus();
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
                    "Tambah Anak",
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
                                      controller: namaController,
                                      keyboardType: TextInputType.name,
                                      minLines: 1,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        hintText: 'Masukkan Nama Anak',
                                        isDense: true,
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.abu_abu,
                                        ),
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
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      minLines: 1,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        hintText: "Masukkan Email Anak",
                                        isDense: true,
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.abu_abu,
                                        ),
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
                                      controller: nomorHpController,
                                      keyboardType: TextInputType.phone,
                                      minLines: 1,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        hintText: "Masukkan Nomor Hp Anak",
                                        isDense: true,
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.abu_abu,
                                        ),
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
                                      controller: alamatController,
                                      keyboardType: TextInputType.streetAddress,
                                      minLines: 1,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        hintText: "Masukkan Alamat Anak",
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.abu_abu,
                                        ),
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
                                      controller: tglLahirController,
                                      readOnly: true,
                                      onTap: () async {
                                        FocusScope.of(context).unfocus();

                                        final pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now(),
                                        );

                                        if (pickedDate != null) {
                                          tglLahirValue =
                                          "${pickedDate.day.toString().padLeft(2, '0')}-"
                                              "${pickedDate.month.toString().padLeft(2, '0')}-"
                                              "${pickedDate.year}";

                                          tglLahirController.text = formatTanggalIndonesia(
                                            tglLahirValue,
                                          );
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Masukkan Tanggal Lahir Anak",
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.abu_abu,
                                        ),
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
                  FocusScope.of(context).unfocus();

                  List<String> errors = [];

                  if (namaController.text.trim().isEmpty) {
                    errors.add("• Nama anak belum diisi");
                  }

                  if (emailController.text.trim().isEmpty) {
                    errors.add("• Email anak belum diisi");
                  }

                  if (nomorHpController.text.trim().isEmpty) {
                    errors.add("• Nomor HP anak belum diisi");
                  }

                  if (alamatController.text.trim().isEmpty) {
                    errors.add("• Alamat anak belum diisi");
                  }

                  if (tglLahirValue.isEmpty) {
                    errors.add("• Tanggal lahir anak belum diisi");
                  }

                  if (errors.isNotEmpty) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.scale,
                      title: 'Data Belum Lengkap',
                      desc: errors.join('\n'),
                      btnOkText: 'OK',
                      btnOkOnPress: () {},
                    ).show();

                    return;
                  }

                  print("===== DATA ANAK =====");
                  print("Nama         : ${namaController.text}");
                  print("Email        : ${emailController.text}");
                  print("Nomor HP     : ${nomorHpController.text}");
                  print("Alamat       : ${alamatController.text}");
                  print("TanggalLahir : $tglLahirValue");
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.hijau,
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
                        "assets/icon/icon_simpan.svg",
                        height: 2.5.h,
                        color: Colors.white,
                      ),
                      SizedBox(width: 1.h),
                      Text(
                        "Simpan Anak",
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