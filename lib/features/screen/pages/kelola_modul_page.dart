import 'dart:math' as math;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../core/color/app_colors.dart';
import '../../../data/app_data.dart';

class KelolaModulPage extends StatefulWidget {
  final Function(String idModul, String namaModul) onOpenDetailModul;
  final VoidCallback onGoBack;

  const KelolaModulPage({
    super.key,
    required this.onOpenDetailModul,
    required this.onGoBack,
  });

  @override
  State<KelolaModulPage> createState() => _KelolaModulPageState();
}

class _KelolaModulPageState extends State<KelolaModulPage> {
  File? _pickedImageModul;

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {});
  }


  void _showTambahModulDialog() {
    final namaController = TextEditingController();
    setState(() => _pickedImageModul = null);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              "Tambah Modul",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: AppColors.biru,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Upload Gambar ──
                GestureDetector(
                  onTap: () async {
                    final picker = ImagePicker();
                    final picked = await picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 80,
                    );
                    if (picked != null) {
                      setState(() => _pickedImageModul = File(picked.path));
                      setDialogState(() {});
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 15.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _pickedImageModul != null
                            ? AppColors.biru
                            : Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: _pickedImageModul != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox.expand(
                        child: Image.file(
                          _pickedImageModul!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 4.h,
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          "Pilih Gambar",
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 1.5.h),

                // ── Nama Modul ──
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                    labelText: "Nama Modul",
                    labelStyle: GoogleFonts.poppins(color: AppColors.abu_abu),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.biru, width: 1.5),
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    color: AppColors.biru,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() => _pickedImageModul = null);
                  Navigator.pop(context);
                },
                child: Text(
                  "Batal",
                  style: GoogleFonts.poppins(color: AppColors.abu_abu),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.biru,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (namaController.text.trim().isEmpty) return;
                  if (_pickedImageModul == null) return;

                  setState(() {
                    daftarModul.add(
                      Modul(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        nama: namaController.text.trim(),
                        gambar: _pickedImageModul!.path,
                      ),
                    );
                    _pickedImageModul = null;
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  "Tambah",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: widget.onGoBack,
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
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColors.biru,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(2.h),
          child: Column(
            children: [
              ...daftarModul.map((modul) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 1.5.h),
                  child: InkWell(
                    onTap: () {
                      widget.onOpenDetailModul(modul.id, modul.nama);
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
                            child: modul.gambar.startsWith('http')
                                ? Image.network(
                              modul.gambar,
                              width: 8.h,
                              height: 8.h,
                              fit: BoxFit.cover,
                            )
                                : Image.file(
                              File(modul.gambar),
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
              SizedBox(height: 7.5.h),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 2.h, bottom: 2.h),
        child: InkWell(
          onTap: _showTambahModulDialog, // ← sambungkan ke dialog
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 5.5.h,
            padding: EdgeInsets.symmetric(horizontal: 1.5.h),
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
                  "Tambah Modul",
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