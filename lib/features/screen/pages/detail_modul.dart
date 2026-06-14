import 'dart:ui';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../core/color/app_colors.dart';
import '../../../data/app_data.dart';

class DetailModulPage extends StatefulWidget {
  final VoidCallback onGoBack;
  final String idModul;
  final String namaModul;

  const DetailModulPage({
    super.key,
    required this.onGoBack,
    required this.idModul,
    required this.namaModul,
  });

  @override
  State<DetailModulPage> createState() => _DetailModulPageState();
}

class _DetailModulPageState extends State<DetailModulPage>
    with TickerProviderStateMixin {
  Anak? selectedAnak;
  late FlutterTts flutterTts;
  File? _pickedImageDialog; // ← tambah ini
  final TextEditingController searchController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  List<Anak> filteredAnak = [];
  bool _dropdownOpen = false;

  // Items yang bisa dihapus (copy dari selectedAnak.items)
  List<ItemAnak> _displayItems = [];

  // Index item yang sedang di-hold (mode hapus)
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    filteredAnak = List.from(daftarAnak);
  }

  @override
  void dispose() {
    for (final c in _animControllers.values) {
      c.dispose();
    }
    flutterTts.stop();
    searchController.dispose();
    _closeDropdown();
    super.dispose();
  }

  Future<void> speak(String text) async {
    await flutterTts.stop();
    await flutterTts.setLanguage("id-ID");
    await flutterTts.speak(text);
  }

  // ─── DROPDOWN OVERLAY ───────────────────────────────────────────

  void _toggleDropdown() {
    if (_dropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    searchController.clear();
    filteredAnak = List.from(daftarAnak);

    _overlayEntry = _buildOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);

    setState(() => _dropdownOpen = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) setState(() => _dropdownOpen = false);
  }

  OverlayEntry _buildOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _closeDropdown,
        child: Stack(
          children: [
            Positioned(
              width: size.width - 4.h, // ikuti lebar layar - padding
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, 5.h + 0.5.h), // tepat di bawah button
                child: _DropdownList(
                  searchController: searchController,
                  filteredAnak: filteredAnak,
                  onSearch: (value) {
                    _overlayEntry?.markNeedsBuild();
                  },
                  onSelect: (anak) {
                    // Dispose semua controller lama
                    for (final c in _animControllers.values) {
                      c.dispose();
                    }
                    _animControllers.clear();
                    _scaleAnimations.clear();

                    setState(() {
                      selectedAnak = anak;
                      _displayItems = List.from(anak.items);
                      _isEditMode = false;
                    });
                    _closeDropdown();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── HAPUS ITEM ─────────────────────────────────────────────────

  void _enterEditMode() {
    HapticFeedback.mediumImpact(); // getar seperti HP
    setState(() => _isEditMode = true);
  }

  void _exitEditMode() {
    setState(() => _isEditMode = false);
  }

  void _deleteItem(int index) {
    HapticFeedback.lightImpact();
    setState(() {
      _displayItems.removeAt(index);
      // Dispose dan hapus controller item yang dihapus
      _animControllers[index]?.dispose();
      _animControllers.remove(index);
      _scaleAnimations.remove(index);
    });
  }

  void _showAddItemDialog() {
    final namaController = TextEditingController();

    // Reset dulu setiap kali dialog dibuka
    setState(() => _pickedImageDialog = null);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              "Tambah Item",
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
                      // Update KEDUANYA: state utama dan state dialog
                      setState(() => _pickedImageDialog = File(picked.path));
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
                        color: _pickedImageDialog != null
                            ? AppColors.biru
                            : Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: _pickedImageDialog != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox.expand(
                              child: Image.file(
                                _pickedImageDialog!,
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

                // ── Nama ──
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                    labelText: "Nama",
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
                  setState(() => _pickedImageDialog = null);
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
                  if (_pickedImageDialog == null) return;

                  setState(() {
                    _displayItems.add(
                      ItemAnak(
                        nama: namaController.text.trim(),
                        gambar: _pickedImageDialog!.path,
                      ),
                    );
                    _pickedImageDialog = null; // reset setelah tambah
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

  // ─── GRID ITEM CARD ─────────────────────────────────────────────

  final Map<int, AnimationController> _animControllers = {};
  final Map<int, Animation<double>> _scaleAnimations = {};

  Widget _buildItemCard(ItemAnak item, int index) {
    // Buat controller jika belum ada
    if (!_animControllers.containsKey(index)) {
      final controller = AnimationController(
        vsync: this, // ← perlu TickerProviderStateMixin
        duration: const Duration(milliseconds: 120),
      );
      _animControllers[index] = controller;
      _scaleAnimations[index] = Tween<double>(
        begin: 1.0,
        end: 0.88,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    }

    final scaleAnim = _scaleAnimations[index]!;
    final controller = _animControllers[index]!;

    return GestureDetector(
      onTap: () {
        if (_isEditMode) {
          _exitEditMode();
        } else {
          speak(item.nama);
        }
      },
      onLongPressStart: (_) async {
        if (_isEditMode) return;
        // Animasi mengecil
        await controller.forward();
        // Getar
        HapticFeedback.mediumImpact();
        // Kembali ke ukuran normal
        await controller.reverse();
        // Masuk edit mode
        _enterEditMode();
      },
      child: ScaleTransition(
        scale: scaleAnim,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // ── Card ──
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.biru, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: item.gambar.isNotEmpty
                          ? item.gambar.startsWith('http')
                                ? SizedBox.expand(
                                    child: Image.network(
                                      item.gambar,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Center(
                                        child: Icon(
                                          Icons.image_not_supported_outlined,
                                          color: Colors.grey.shade300,
                                          size: 4.h,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox.expand(
                                    child: Image.file(
                                      File(item.gambar),
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Center(
                                        child: Icon(
                                          Icons.image_not_supported_outlined,
                                          color: Colors.grey.shade300,
                                          size: 4.h,
                                        ),
                                      ),
                                    ),
                                  )
                          : Center(
                              child: Icon(
                                Icons.image_outlined,
                                color: Colors.grey.shade300,
                                size: 4.h,
                              ),
                            ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.h),
                    child: Text(
                      item.nama,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: AppColors.biru,
                        height: 1
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Tombol hapus pojok kiri atas ──
            if (_isEditMode)
              Positioned(
                top: -1.h,
                left: -1.h,
                child: GestureDetector(
                  onTap: () => _deleteItem(index),
                  child: Container(
                    width: 3.h,
                    height: 3.h,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icon/icon_hapus.svg",
                        width: 2.h,
                        height: 2.h,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddCard() {
    return GestureDetector(
      onTap: _isEditMode ? _exitEditMode : _showAddItemDialog,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.biru,
            width: 1.5,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.06),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            "assets/icon/icon_plus.svg",
            width: 4.h,
            height: 4.h,
            color: AppColors.biru,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    final int totalCount = _isEditMode
        ? _displayItems.length
        : _displayItems.length + 1;
    return GestureDetector(
      // Tap di luar → batalkan mode hapus
      onTap: () {
        if (_isEditMode) _exitEditMode();
        if (_dropdownOpen) _closeDropdown();
      },
      child: Scaffold(
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
                    width: 24.h,
                    padding: EdgeInsets.symmetric(horizontal: 1.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.biru,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      widget.namaModul,
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

        body: Stack(
          children: [
            // ── Konten utama ──
            Padding(
              padding: EdgeInsets.all(2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pilih Anak',
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.biru,
                    ),
                  ),

                  // ── DROPDOWN BUTTON ──
                  CompositedTransformTarget(
                    link: _layerLink,
                    child: GestureDetector(
                      onTap: _toggleDropdown,
                      child: Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.biru,
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
                                      color: AppColors.biru,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    selectedAnak?.nama ?? "Pilih Anak",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.biru,
                                    ),
                                  ),
                                ),
                                AnimatedRotation(
                                  turns: _dropdownOpen ? 0.25 : -0.25,
                                  duration: const Duration(milliseconds: 200),
                                  child: SvgPicture.asset(
                                    "assets/icon/icon_back.svg",
                                    width: 2.h,
                                    height: 2.h,
                                    color: AppColors.biru,
                                  ),
                                ),
                                SizedBox(width: 2.5.h),
                              ],
                            ),
                            SizedBox(height: 0.5.h),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 2.h),

                  // ── GRID (scroll hanya di sini) ──
                  // ── GRID (scroll hanya di sini) ──
                  if (selectedAnak != null)
                    Expanded(
                      // ← Expanded langsung di Column utama
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(1.5.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.biru, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: GridView.builder(
                          itemCount: totalCount,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.95,
                              ),
                          itemBuilder: (context, index) {
                            if (index == _displayItems.length)
                              return _buildAddCard();
                            return _buildItemCard(_displayItems[index], index);
                          },
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.person_search_outlined,
                              size: 7.h,
                              color: AppColors.biru.withOpacity(0.3),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              "Silahkan pilih anak\nterlebih dahulu",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.biru.withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  if (selectedAnak != null) ...[
                    SizedBox(height: 2.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
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
                                "Hapus Modul",
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
                  ],
                ],
              ),
            ),

            // ── Blur overlay saat edit mode ──
            if (_isEditMode)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _exitEditMode,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(color: Colors.black.withOpacity(0.15)),
                  ),
                ),
              ),

            // ── Grid di atas blur saat edit mode ──
            if (_isEditMode && selectedAnak != null)
              Positioned(
                left: 2.h,
                right: 2.h,
                // sesuaikan top agar posisi grid sama
                top: 9.h + 2.h,
                // appbar height + padding
                bottom: 2.h,
                child: Container(
                  padding: EdgeInsets.all(1.5.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GridView.builder(
                    itemCount: totalCount,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.75,
                        ),
                    itemBuilder: (context, index) {
                      if (index == _displayItems.length) {
                        return _buildAddCard();
                      }
                      return _buildItemCard(_displayItems[index], index);
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─── WIDGET DROPDOWN LIST (terpisah agar bisa rebuild sendiri) ───────────────

class _DropdownList extends StatefulWidget {
  final TextEditingController searchController;
  final List<Anak> filteredAnak;
  final ValueChanged<String> onSearch;
  final ValueChanged<Anak> onSelect;

  const _DropdownList({
    required this.searchController,
    required this.filteredAnak,
    required this.onSearch,
    required this.onSelect,
  });

  @override
  State<_DropdownList> createState() => _DropdownListState();
}

class _DropdownListState extends State<_DropdownList> {
  late List<Anak> _list;

  @override
  void initState() {
    super.initState();
    _list = List.from(widget.filteredAnak);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(1.5.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Search field
            TextField(
              controller: widget.searchController,
              decoration: InputDecoration(
                constraints: BoxConstraints(maxHeight: 5.h),
                hintText: "Cari anak...",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.biru,
                ),
                prefixIcon: Icon(Icons.search, size: 2.5.h),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 4.75.h,
                  maxHeight: 5.h,
                ),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 1.2.h,
                  horizontal: 2.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.biru,
              ),
              onChanged: (value) {
                setState(() {
                  if (value.trim().isEmpty) {
                    _list = List.from(
                      widget.filteredAnak,
                    ); // ← kembalikan semua
                  } else {
                    _list = widget.filteredAnak
                        .where(
                          (a) => a.nama.toLowerCase().contains(
                            value.toLowerCase(),
                          ),
                        )
                        .toList();
                  }
                });
                widget.onSearch(value);
              },
            ),

            SizedBox(height: 1.h),

            // List anak
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 30.h),
              child: _list.isEmpty
                  ? Padding(
                      padding: EdgeInsets.all(2.h),
                      child: Text(
                        "Anak tidak ditemukan",
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: AppColors.biru,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: _list.length,
                      padding: EdgeInsets.zero,
                      separatorBuilder: (_, __) =>
                          Divider(height: 1, color: Colors.grey.shade200),
                      itemBuilder: (context, index) {
                        final anak = _list[index];
                        return InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () => widget.onSelect(anak),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 1.h,
                              vertical: 1.2.h,
                            ),
                            child: Text(
                              anak.nama,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                color: AppColors.biru,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
