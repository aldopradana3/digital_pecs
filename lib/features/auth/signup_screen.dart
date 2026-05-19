import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/routes/app_routes.dart';
import '../../core/color/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class DaftarScreen extends StatefulWidget {
  const DaftarScreen({super.key});

  @override
  State<DaftarScreen> createState() => _DaftarScreenState();
}

class _DaftarScreenState extends State<DaftarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _namaController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordKonfirmasiController = TextEditingController();

  bool _rememberMe = false;
  bool _isLoading = false;
  bool _isPasswordHidden = true;
  bool _isPasswordKonfirmasiHidden = true;
  bool _isSubmitted = false;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _namaFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordKonfirmasiFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      setState(() {});
    });
    _namaFocusNode.addListener(() {
      setState(() {});
    });
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
    _passwordKonfirmasiFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _namaFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordKonfirmasiFocusNode.dispose();

    _emailController.dispose();
    _namaController.dispose();
    _passwordController.dispose();
    _passwordKonfirmasiController.dispose();

    super.dispose();
  }

  Future<void> _daftar() async {
    setState(() {
      _isSubmitted = true;
    });

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    setState(() => _isLoading = false);

    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,

      title: 'Berhasil',
      desc: 'Akun berhasil didaftarkan',

      btnOkText: 'OK',

      btnOkOnPress: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
              (route) => false,
        );
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 6.h),

                      // Logo
                      Center(
                        child: Image.asset('assets/icon/icon_pecs.png', height: 17.h),
                      ),
                      SizedBox(height: 5.h),

                      // Judul
                      Text(
                        'Daftar Sekarang Sebagai Orang Tua',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.biru,
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2), // posisi bayangan
                              blurRadius: 5, // tingkat blur
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Halo! ',
                              style: GoogleFonts.poppins(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.abu_abu,
                              ),
                            ),
                            TextSpan(
                              text: 'Daftar',
                              style: GoogleFonts.poppins(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.abu_abu,
                              ),
                            ),
                            TextSpan(
                              text: ' untuk melanjutkan',
                              style: GoogleFonts.poppins(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.abu_abu,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5.h),
                      Column(
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
                                  color: _namaFocusNode.hasFocus
                                      ? Colors.black
                                      : AppColors.abu_abu,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 6.h,
                                  child: SvgPicture.asset(
                                    'assets/icon/icon_user.svg',
                                    height: 2.75.h,
                                  ),
                                ),

                                Expanded(
                                  child: TextFormField(
                                    controller: _namaController,
                                    focusNode: _namaFocusNode,
                                    keyboardType: TextInputType.name,
                                    autovalidateMode: _isSubmitted
                                        ? AutovalidateMode.onUserInteraction
                                        : AutovalidateMode.disabled,
                                    decoration: InputDecoration(
                                      hintText: 'Masukkan nama lengkap anda',

                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.abu_abu,
                                      ),

                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),

                                    style: GoogleFonts.poppins(
                                      fontSize: 15.sp,
                                      color: AppColors.abu_abu,
                                      fontWeight: FontWeight.w600,
                                    ),

                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Nama tidak boleh kosong';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alamat Email',
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
                                  color: _emailFocusNode.hasFocus
                                      ? Colors.black
                                      : AppColors.abu_abu,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 6.h,
                                  child: SvgPicture.asset(
                                    'assets/icon/icon_email.svg',
                                    height: 2.h,
                                  ),
                                ),

                                Expanded(
                                  child: TextFormField(
                                    controller: _emailController,
                                    focusNode: _emailFocusNode,
                                    keyboardType: TextInputType.emailAddress,
                                    autovalidateMode: _isSubmitted
                                        ? AutovalidateMode.onUserInteraction
                                        : AutovalidateMode.disabled,
                                    decoration: InputDecoration(
                                      hintText: 'Masukkan alamat email anda',

                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.abu_abu,
                                      ),

                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),

                                    style: GoogleFonts.poppins(
                                      fontSize: 15.sp,
                                      color: AppColors.abu_abu,
                                      fontWeight: FontWeight.w600,
                                    ),

                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Email tidak boleh kosong';
                                      }

                                      if (!RegExp(
                                        r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$',
                                      ).hasMatch(value)) {
                                        return 'Format email tidak valid';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
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
                                  color: _passwordFocusNode.hasFocus
                                      ? Colors.black
                                      : AppColors.abu_abu,
                                  width: 1.5,
                                ),
                              ),
                            ),

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 6.h,
                                  child: SvgPicture.asset(
                                    'assets/icon/icon_password.svg',
                                    height: 2.5.h,
                                  ),
                                ),

                                Expanded(
                                  child: TextFormField(
                                    controller: _passwordController,
                                    focusNode: _passwordFocusNode,
                                    obscureText: _isPasswordHidden,
                                    autovalidateMode: _isSubmitted
                                        ? AutovalidateMode.onUserInteraction
                                        : AutovalidateMode.disabled,
                                    decoration: InputDecoration(
                                      hintText: 'Masukkan password anda',

                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.abu_abu,
                                      ),

                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),

                                    style: GoogleFonts.poppins(
                                      fontSize: 15.sp,
                                      color: AppColors.abu_abu,
                                      fontWeight: FontWeight.w600,
                                    ),

                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Password tidak boleh kosong';
                                      }

                                      if (value.length < 6) {
                                        return 'Password minimal 6 karakter';
                                      }

                                      return null;
                                    },
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isPasswordHidden = !_isPasswordHidden;
                                    });
                                  },

                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 1.5.h),

                                    child: Icon(
                                      _isPasswordHidden
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      size: 2.7.h,
                                      color: AppColors.abu_abu,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Konfirmasi Password',
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
                                  color: _passwordKonfirmasiFocusNode.hasFocus
                                      ? Colors.black
                                      : AppColors.abu_abu,
                                  width: 1.5,
                                ),
                              ),
                            ),

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 6.h,
                                  child: SvgPicture.asset(
                                    'assets/icon/icon_password.svg',
                                    height: 2.5.h,
                                  ),
                                ),

                                Expanded(
                                  child: TextFormField(
                                    controller: _passwordKonfirmasiController,
                                    focusNode: _passwordKonfirmasiFocusNode,
                                    obscureText: _isPasswordKonfirmasiHidden,
                                    autovalidateMode: _isSubmitted
                                        ? AutovalidateMode.onUserInteraction
                                        : AutovalidateMode.disabled,
                                    decoration: InputDecoration(
                                      hintText: 'Konfirmasi password anda',

                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.abu_abu,
                                      ),

                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),

                                    style: GoogleFonts.poppins(
                                      fontSize: 15.sp,
                                      color: AppColors.abu_abu,
                                      fontWeight: FontWeight.w600,
                                    ),

                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Password tidak boleh kosong';
                                      }

                                      if (value != _passwordController.text) {
                                        return 'Password tidak sama';
                                      }

                                      return null;
                                    },
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isPasswordKonfirmasiHidden = !_isPasswordKonfirmasiHidden;
                                    });
                                  },

                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 1.5.h),

                                    child: Icon(
                                      _isPasswordKonfirmasiHidden
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      size: 2.7.h,
                                      color: AppColors.abu_abu,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),

                      SizedBox(
                        height: 5.h,
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                            FocusScope.of(context).unfocus();

                            _daftar();
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.biru,
                            disabledBackgroundColor: Colors.grey,
                            foregroundColor: Colors.white,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),

                          child: _isLoading
                              ? SizedBox(
                            width: 2.h,
                            height: 2.h,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                              : Text(
                            'Daftar',
                            style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    bottom: 2.5.h,
                    top: 2.h,
                    left: 3.h,
                    right: 3.h
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        'Sudah punya akun? ',
                        style: GoogleFonts.poppins(
                          fontSize: 13.2.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.abu_abu,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.login,
                              (route) => false,
                        );
                      },

                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),

                      child: Text(
                        'Masuk sekarang',
                        style: GoogleFonts.poppins(
                          fontSize: 13.2.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.biru,
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
