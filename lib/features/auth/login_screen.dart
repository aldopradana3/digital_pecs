import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api/api_service.dart';
import '../../core/routes/app_routes.dart';
import '../../core/color/app_colors.dart';
import '../../data/app_data.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _rememberMe = false;
  bool _isLoading = false;
  bool _isPasswordHidden = true;
  bool _isSubmitted = false;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      setState(() {});
    });
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  Future<void> _login(
      String email,
      String password,
      ) async {
    setState(() {
      _isSubmitted = true;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    bool success = false;

    try {
      success = await ApiService.login(
        email: email,
        password: password,
      );

      print("=================================");
      print("LOGIN RESULT : $success");
      print("TOKEN : ${User.token}");
      print("USERNAME : ${User.username}");
      print("EMAIL : ${User.email}");
      print("ROLE : ${User.role}");
      print("=================================");
    } catch (e) {
      print("LOGIN ERROR");
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (success) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.main,
      );
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: 'Login Gagal',
        desc: ApiService.lastMessage.isNotEmpty
            ? ApiService.lastMessage
            : 'Email atau password salah',
        btnOkOnPress: () {},
      ).show();
    }
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

                      Center(
                        child: Image.asset('assets/icon/icon_pecs.png', height: 17.h),
                      ),
                      SizedBox(height: 5.h),

                      Text(
                        'Selamat Datang Kembali',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.biru,
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 5,
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
                              text: 'Masuk',
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

                      Row(
                        children: [
                          SizedBox(
                            width: 2.h,
                            height: 2.h,
                            child: Checkbox(
                              value: _rememberMe,
                              checkColor: Colors.white,
                              activeColor: AppColors.biru,
                              onChanged: (val) {
                                setState(() => _rememberMe = val!);
                              },
                            ),
                          ),
                          SizedBox(width: 1.5.h),
                          Text(
                            'Ingat Saya',
                            style: GoogleFonts.poppins(
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.biru,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),


                      SizedBox(
                        height: 5.h,
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                            FocusScope.of(context).unfocus();

                            _login(_emailController.text, _passwordController.text);
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
                            'Masuk',
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
                      'Belum punya akun orang tua? ',
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
                      Navigator.pushNamed(
                        context,
                        AppRoutes.daftar,
                      );
                      print("Token sekarang: ${User.token}");
                      print("Header sekarang: ${ApiService.headers}");
                    },

                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),

                    child: Text(
                      'Daftar sekarang',
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
