import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../core/color/app_colors.dart';

class MariBermainPage extends StatefulWidget {
  final VoidCallback onGoBack;
  const MariBermainPage({
    super.key,
    required this.onGoBack,
  });

  @override
  State<MariBermainPage> createState() => _MariBermainPageState();
}

class _MariBermainPageState extends State<MariBermainPage> {
  final FlutterTts flutterTts = FlutterTts();

  int currentPage = 0;

  final List<Map<String, dynamic>> categories = [
    {
      "title": "Makanan & Minuman",
      "items": [
        "Nasi",
        "Susu",
        "Roti",
        "Air",
        "Bakso",
        "Teh",
        "Jus",
        "Mie",
        "Buah",
        "Koko Krunch",
      ],
    },
    {
      "title": "Kegiatan",
      "items": [
        "Tidur",
        "Mandi",
        "Belajar",
        "Bermain",
        "Makan",
        "Menulis",
        "Membaca",
        "Lari",
        "Menyapu",
      ],
    },
    {
      "title": "Tempat",
      "items": [
        "Sekolah",
        "Rumah",
        "Pasar",
        "Taman",
        "Kantin",
        "Kamar",
        "Masjid",
        "Pantai",
        "Kebun",
      ],
    },
  ];

  Future<void> speak(String text) async {
    await flutterTts.setLanguage("id-ID");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  void showInfoPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              "https://picsum.photos/400/500",
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    final currentData = categories[currentPage];

    return WillPopScope(
      onWillPop: () async {

        widget.onGoBack();

        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(9.h),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
              child: Row(
                children: [
                  // BACK BUTTON
                  GestureDetector(
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

                  SizedBox(width: 4.h),

                  // TITLE
                  Expanded(
                    child: Container(
                      height: 4.5.h,
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
                        currentData["title"],
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 1.65.h,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 4.h),

                  // INFO BUTTON
                  GestureDetector(
                    onTap: showInfoPopup,
                    child: Container(
                      width: 4.5.h,
                      height: 4.5.h,
                      decoration: BoxDecoration(
                        color: AppColors.kuning,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icon/icon_tanda_tanya.svg",
                          width: 2.25.h,
                          height: 2.25.h,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        body: Padding(
          padding: EdgeInsets.all(1.5.h),
          child: Column(
            children: [
              // TOMBOL BESAR
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: Row(
                  children: [
                    // SAYA
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          speak("Saya");
                        },
                        child: Container(
                          height: 17.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://picsum.photos/300/300?1",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                            ),
                            child: Text(
                              "SAYA",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 2.h,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 4.h),

                    // MAU
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          speak("Mau");
                        },
                        child: Container(
                          height: 17.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://picsum.photos/300/300?2",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                            ),
                            child: Text(
                              "MAU",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 2.h,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 3.h),

              // GRID BUTTON
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.biru, width: 3),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(1.2.h),
                    child: GridView.builder(
                      itemCount: currentData["items"].length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            childAspectRatio: 0.95,
                          ),
                      itemBuilder: (context, index) {
                        final item = currentData["items"][index];

                        return GestureDetector(
                          onTap: () {
                            speak(item);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://picsum.photos/200?random=$index$currentPage",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 0.5.h),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                              ),
                              child: Text(
                                item,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 1.5.h,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 2.5.h),

              // NAVIGATION BUTTON
              Row(
                children: [
                  // PREVIOUS
                  Expanded(
                    child: ElevatedButton(
                      onPressed: currentPage == 0
                          ? null
                          : () {
                        setState(() {
                          currentPage--;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.biru,
                        padding: EdgeInsets.symmetric(
                          vertical: 1.25.h,
                          horizontal: 1.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icon/icon_back.svg",
                            width: 2.h,
                            height: 2.h,
                            color: Colors.white,
                          ),

                          SizedBox(width: 1.5.h),

                          Text(
                            "Sebelumnya",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 1.5.h,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 2.h),

      // NEXT
                  Expanded(
                    child: ElevatedButton(
                      onPressed: currentPage == categories.length - 1
                          ? null
                          : () {
                        setState(() {
                          currentPage++;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.biru,
                        padding: EdgeInsets.symmetric(
                          vertical: 1.25.h,
                          horizontal: 1.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Selanjutnya",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 1.65.h,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          SizedBox(width: 1.5.h),

                          RotatedBox(
                            quarterTurns: 2,
                            child: SvgPicture.asset(
                              "assets/icon/icon_back.svg",
                              width: 2.h,
                              height: 2.h,
                              color: Colors.white,
                            ),
                          ),
                        ],
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
