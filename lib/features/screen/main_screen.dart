import 'package:digital_pecs/core/color/app_colors.dart';
import 'package:digital_pecs/features/screen/pages/detail_anak_page.dart';
import 'package:digital_pecs/features/screen/pages/detail_modul.dart';
import 'package:digital_pecs/features/screen/pages/kelola_anak_page.dart';
import 'package:digital_pecs/features/screen/pages/mari_bermain_page.dart';
import 'package:digital_pecs/features/screen/pages/tambah_anak_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../data/app_data.dart';

import 'pages/home_page.dart';
import 'pages/akun_page.dart';
import 'pages/kelola_modul_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  /// =========================
  /// TAB CONTROLLER
  /// =========================

  late TabController _tabController;

  /// =========================
  /// CURRENT PAGE
  /// =========================

  int currentIndex = 0;

  /// =========================
  /// ACTIVE BOTTOM NAVBAR
  /// =========================

  int currentBottomNavIndex = 0;

  /// =========================
  /// HISTORY PAGE
  /// =========================

  List<int> pageHistory = [];

  /// =========================
  /// PAGE INDEX
  /// =========================

  static const int pageHome = 0;
  static const int pageMariBermain = 1;

  static const int pageKelolaAnak = 2;
  static const int pageTambahAnak = 3;
  static const int pageDetailAnak = 4;

  static const int pageKelolaModul = 5;
  static const int pageDetailModul = 6;

  static const int pageAkun = 7;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 8, vsync: this);

    _tabController.addListener(() {
      setState(() {
        currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  /// =========================
  /// GO TO PAGE
  /// =========================

  void goToPage(int index, {bool changeBottomNav = false}) {
    /// HANYA SIMPAN HISTORY
    /// UNTUK DETAIL PAGE
    if (index == pageTambahAnak ||
        index == pageDetailAnak ||
        index == pageDetailModul) {
      pageHistory.add(currentIndex);
    }

    setState(() {
      currentIndex = index;

      if (changeBottomNav) {
        currentBottomNavIndex = index;
      }

      _tabController.index = index;
    });
  }

  /// =========================
  /// NAVBAR ITEM
  /// =========================

  Widget _buildNavItem({
    required int index,
    required String label,
    required String icon,
  }) {
    /// ACTIVE BERDASARKAN TAB
    final bool isActive = currentBottomNavIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          /// CLEAR HISTORY
          pageHistory.clear();

          goToPage(index, changeBottomNav: true);
        },

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            /// ICON
            SizedBox(
              width: 3.5.h,
              height: 3.h,

              child: SvgPicture.asset(
                icon,
                fit: BoxFit.fill,

                colorFilter: ColorFilter.mode(
                  isActive ? AppColors.biru : AppColors.abu_abu2,

                  BlendMode.srcIn,
                ),
              ),
            ),

            /// LABEL
            Text(
              label,

              style: GoogleFonts.poppins(
                fontSize: 13.5.sp,

                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,

                color: isActive ? AppColors.biru : AppColors.abu_abu2,
              ),
            ),

            /// GARIS ACTIVE
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),

              curve: Curves.easeInOut,

              width: isActive ? 5.h : 0,
              height: 3,

              decoration: BoxDecoration(
                color: AppColors.biru,

                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String selectedIdSiswa = "";
  String selectedNamaSiswa = "";
  String selectedEmailSiswa = "";
  String selectedNomorHpSiswa = "";
  String selectedAlamatSiswa = "";
  String selectedTglLahirSiswa = "";

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;

    final bool isGuru = UserLogin.email == "guru@gmail.com";

    /// =========================
    /// ALL PAGES
    /// =========================

    final List<Widget> pages = [
      /// HOME
      HomePage(
        onOpenKelolaModul: () {
          goToPage(pageKelolaModul, changeBottomNav: true);
        },

        onOpenMariBermain: () {
          goToPage(pageMariBermain);
        },

        onOpenKelolaAnak: () {
          goToPage(pageKelolaAnak, changeBottomNav: true);
        },

        onOpenProfile: () {
          goToPage(pageAkun, changeBottomNav: true);
        },
      ),

      /// MARI BERMAIN
      MariBermainPage(
        onGoBack: () {
          pageHistory.clear();

          goToPage(pageHome, changeBottomNav: true);
        },
      ),

      /// KELOLA ANAK
      KelolaAnakPage(
        onOpenTambahAnak: () {
          goToPage(pageTambahAnak);
        },

        onOpenDetailAnak: (idSiswa, namaSiswa, emailSiswa, nomorHpSiswa, alamatSiswa, tglLahirSiswa) async {
          setState(() {
            selectedIdSiswa = idSiswa;
            selectedNamaSiswa = namaSiswa;
            selectedEmailSiswa = emailSiswa;
            selectedNomorHpSiswa = nomorHpSiswa;
            selectedAlamatSiswa = alamatSiswa;
            selectedTglLahirSiswa = tglLahirSiswa;
          });

          await WidgetsBinding.instance.endOfFrame;

          goToPage(pageDetailAnak);
        },
        onGoBack: () {
          pageHistory.clear();

          goToPage(pageHome, changeBottomNav: true);
        },
      ),

      /// TAMBAH ANAK
      TambahAnakPage(
        onGoBack: () {
          final previousPage = pageHistory.removeLast();

          setState(() {
            currentIndex = previousPage;

            /// UPDATE ACTIVE NAVBAR
            if (previousPage == pageHome ||
                previousPage == pageKelolaAnak ||
                previousPage == pageKelolaModul ||
                previousPage == pageAkun) {
              currentBottomNavIndex = previousPage;
            }

            _tabController.index = previousPage;
          });
        },
      ),

      /// DETAIL ANAK
      DetailAnakPage(
        idSiswa: selectedIdSiswa,
        namaSiswa: selectedNamaSiswa,
        emailSiswa: selectedEmailSiswa,
        nomorHpSiswa: selectedNomorHpSiswa,
        alamatSiswa: selectedAlamatSiswa,
        tglLahirSiswa: selectedTglLahirSiswa,
        onGoBack: () {
          final previousPage = pageHistory.removeLast();

          setState(() {
            currentIndex = previousPage;

            /// UPDATE ACTIVE NAVBAR
            if (previousPage == pageHome ||
                previousPage == pageKelolaAnak ||
                previousPage == pageKelolaModul ||
                previousPage == pageAkun) {
              currentBottomNavIndex = previousPage;
            }

            _tabController.index = previousPage;
          });
        },
      ),

      /// KELOLA MODUL
      KelolaModulPage(
        onOpenDetailModul: () {
          goToPage(pageDetailModul);
        },
      ),

      /// DETAIL MODUL
      const DetailModulPage(),

      /// AKUN
      AkunPage(),
    ];

    return WillPopScope(
      /// =========================
      /// BACK BUTTON HP
      /// =========================
      onWillPop: () async {

        FocusScope.of(context).unfocus();

        /// =========================
        /// JIKA DI HALAMAN ANAK/MODUL/AKUN
        /// =========================
        if (currentIndex == pageKelolaAnak ||
            currentIndex == pageKelolaModul ||
            currentIndex == pageAkun) {
          pageHistory.clear();

          goToPage(pageHome, changeBottomNav: true);

          return false;
        }

        /// =========================
        /// JIKA ADA HISTORY DETAIL PAGE
        /// =========================

        if (pageHistory.isNotEmpty) {
          final previousPage = pageHistory.removeLast();

          setState(() {
            currentIndex = previousPage;

            /// UPDATE ACTIVE NAVBAR
            if (previousPage == pageHome ||
                previousPage == pageKelolaAnak ||
                previousPage == pageKelolaModul ||
                previousPage == pageAkun) {
              currentBottomNavIndex = previousPage;
            }

            _tabController.index = previousPage;
          });

          return false;
        }

        /// =========================
        /// JIKA SUDAH DI HOME
        /// =========================

        return true;
      },

      child: Scaffold(
        /// =========================
        /// BODY
        /// =========================
        body: Stack(
          children: [
            /// BACKGROUND IMAGE
            Positioned(
              bottom: 0,
              right: 0,

              child: Image.asset(
                'assets/image/footer.png',

                width: 100.w,
                fit: BoxFit.contain,
              ),
            ),

            /// CONTENT
            SafeArea(
              child: TabBarView(
                controller: _tabController,

                /// SWIPE AKTIF
                physics: const NeverScrollableScrollPhysics(),

                children: pages,
              ),
            ),
          ],
        ),

        /// =========================
        /// BOTTOM NAVBAR
        /// =========================
        bottomNavigationBar: SafeArea(
          top: false,

          child: Container(
            height: 7.h,

            decoration: const BoxDecoration(
              color: Colors.white,

              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
            ),

            child: Row(
              children: isGuru
                  ? [
                      /// HOME
                      _buildNavItem(
                        index: pageHome,
                        label: "Home",
                        icon: 'assets/icon/icon_home_footer.svg',
                      ),

                      /// ANAK
                      _buildNavItem(
                        index: pageKelolaAnak,
                        label: "Anak",
                        icon: 'assets/icon/icon_anak_footer.svg',
                      ),

                      /// MODUL
                      _buildNavItem(
                        index: pageKelolaModul,
                        label: "Modul",
                        icon: 'assets/icon/icon_modul_footer.svg',
                      ),

                      /// AKUN
                      _buildNavItem(
                        index: pageAkun,
                        label: "Akun",
                        icon: 'assets/icon/icon_user_footer.svg',
                      ),
                    ]
                  : [
                      /// HOME
                      _buildNavItem(
                        index: pageHome,
                        label: "Home",
                        icon: 'assets/icon/icon_home_footer.svg',
                      ),

                      /// AKUN
                      _buildNavItem(
                        index: pageAkun,
                        label: "Akun",
                        icon: 'assets/icon/icon_user_footer.svg',
                      ),
                    ],
            ),
          ),
        ),
      ),
    );
  }
}
