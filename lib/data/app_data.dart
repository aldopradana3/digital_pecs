class UserLogin {
  static String email = '';
  static String password = '';
}

class Siswa {
  final String id;
  final String nama;
  final String email;
  final String nomorHp;
  final String alamat;
  final String tglLahir;

  Siswa({
    required this.id,
    required this.nama,
    required this.email,
    required this.nomorHp,
    required this.alamat,
    required this.tglLahir,
  });
}

final List<Siswa> dataDiriSiswa = [
  Siswa(
    id: '69',
    nama: 'Budi Santoso',
    email: 'budi.santoso@gmail.com',
    nomorHp: '08123456789',
    alamat: 'Jl. Merdeka No. 10, Surabaya',
    tglLahir: '06-12-2026',
  ),
];

class DaftarSiswa {
  final String id;
  final String nama;
  final String email;
  final String nomorHp;
  final String alamat;
  final String tglLahir;

  DaftarSiswa({
    required this.id,
    required this.nama,
    required this.email,
    required this.nomorHp,
    required this.alamat,
    required this.tglLahir,
  });
}

final List<DaftarSiswa> daftarSiswa = [
  DaftarSiswa(
    id: '4',
    nama: 'Budi Santoso',
    email: 'budi.santoso@gmail.com',
    nomorHp: '08123456789',
    alamat: 'Jl. Merdeka No. 10, Surabaya',
    tglLahir: '06-12-2026',
  ),

  DaftarSiswa(
    id: '5',
    nama: 'Owi The Ratapan',
    email: 'owiratapan@gmail.com',
    nomorHp: '0898765421',
    alamat: 'Solo, Saya akan lawan',
    tglLahir: '15-04-1998',
  ),

  DaftarSiswa(
    id: '6',
    nama: 'Owo The MBG Initialist',
    email: 'owimbg@gmail.com',
    nomorHp: '0847658746',
    alamat:
        'Haee antek antek asing jhhvuvgvgvg hg g gg gh ghvgvgvyugyuibhj hk gh gh gh gy gh hbm gjvgyvyuvyuibj jbuybh ghk gkc gv gh bn gkvgy ugvtyvyivvhjvvbnvbnvhvhuygh j g h gh h gh h h  vvhjyuguguiglknklnoihlnjk mn vhujvuvhjvhjhhj',
    tglLahir: '17-08-1945',
  ),
];

String formatTanggalIndonesia(String tanggal) {
  final parts = tanggal.split('-');

  const bulan = {
    '01': 'Januari',
    '02': 'Februari',
    '03': 'Maret',
    '04': 'April',
    '05': 'Mei',
    '06': 'Juni',
    '07': 'Juli',
    '08': 'Agustus',
    '09': 'September',
    '10': 'Oktober',
    '11': 'November',
    '12': 'Desember',
  };

  return '${parts[0]} ${bulan[parts[1]]} ${parts[2]}';
}

class Modul {
  final String id;
  final String nama;
  final String gambar;

  Modul({required this.id, required this.nama, required this.gambar});
}

final List<Modul> daftarModul = [
  Modul(
    id: '1',
    nama: 'Keselamatan Kerja',
    gambar: 'https://picsum.photos/id/1011/600/400',
  ),
  Modul(
    id: '2',
    nama: 'Pemadaman Kebakaran',
    gambar: 'https://picsum.photos/id/1015/600/400',
  ),
  Modul(
    id: '3',
    nama: 'Penggunaan APAR',
    gambar: 'https://picsum.photos/id/1025/600/400',
  ),
];

class ItemAnak {
  final String nama;
  final String gambar;

  ItemAnak({
    required this.nama,
    required this.gambar,
  });
}

class Anak {
  final String nama;
  final List<ItemAnak> items;

  Anak({
    required this.nama,
    required this.items,
  });
}

final List<Anak> daftarAnak = [
  Anak(
    nama: 'Budi Santoso',
    items: [
      ItemAnak(
        nama: 'Bakso',
        gambar: 'https://picsum.photos/id/1080/300/300',
      ),
      ItemAnak(
        nama: 'Mie Ayam',
        gambar: 'https://picsum.photos/id/292/300/300',
      ),
      ItemAnak(
        nama: 'Nasi Goreng',
        gambar: 'https://picsum.photos/id/431/300/300',
      ),
      ItemAnak(
        nama: 'Sate Ayam',
        gambar: 'https://picsum.photos/id/488/300/300',
      ),
      ItemAnak(
        nama: 'Bakso',
        gambar: 'https://picsum.photos/id/1080/300/300',
      ),
      ItemAnak(
        nama: 'Mie Ayam',
        gambar: 'https://picsum.photos/id/292/300/300',
      ),
      ItemAnak(
        nama: 'Nasi Goreng',
        gambar: 'https://picsum.photos/id/431/300/300',
      ),
      ItemAnak(
        nama: 'Sate Ayam',
        gambar: 'https://picsum.photos/id/488/300/300',
      ),
      ItemAnak(
        nama: 'Bakso',
        gambar: 'https://picsum.photos/id/1080/300/300',
      ),
      ItemAnak(
        nama: 'Mie Ayam',
        gambar: 'https://picsum.photos/id/292/300/300',
      ),
      ItemAnak(
        nama: 'Nasi Goreng',
        gambar: 'https://picsum.photos/id/431/300/300',
      ),
      ItemAnak(
        nama: 'Sate Ayam',
        gambar: 'https://picsum.photos/id/488/300/300',
      ),
      ItemAnak(
        nama: 'Bakso',
        gambar: 'https://picsum.photos/id/1080/300/300',
      ),
      ItemAnak(
        nama: 'Mie Ayam',
        gambar: 'https://picsum.photos/id/292/300/300',
      ),
      ItemAnak(
        nama: 'Nasi Goreng',
        gambar: 'https://picsum.photos/id/431/300/300',
      ),
      ItemAnak(
        nama: 'Sate Ayam',
        gambar: 'https://picsum.photos/id/488/300/300',
      ),
      ItemAnak(
        nama: 'Bakso',
        gambar: 'https://picsum.photos/id/1080/300/300',
      ),
      ItemAnak(
        nama: 'Mie Ayam',
        gambar: 'https://picsum.photos/id/292/300/300',
      ),
      ItemAnak(
        nama: 'Nasi Goreng',
        gambar: 'https://picsum.photos/id/431/300/300',
      ),
      ItemAnak(
        nama: 'Sate Ayam',
        gambar: 'https://picsum.photos/id/488/300/300',
      ),
      ItemAnak(
        nama: 'Bakso',
        gambar: 'https://picsum.photos/id/1080/300/300',
      ),
      ItemAnak(
        nama: 'Mie Ayam',
        gambar: 'https://picsum.photos/id/292/300/300',
      ),
      ItemAnak(
        nama: 'Nasi Goreng',
        gambar: 'https://picsum.photos/id/431/300/300',
      ),
      ItemAnak(
        nama: 'Sate Ayam',
        gambar: 'https://picsum.photos/id/488/300/300',
      ),
    ],
  ),

  Anak(
    nama: 'Andi Pratama',
    items: [
      ItemAnak(
        nama: 'Soto',
        gambar: 'https://picsum.photos/id/493/300/300',
      ),
      ItemAnak(
        nama: 'Rawon',
        gambar: 'https://picsum.photos/id/1084/300/300',
      ),
      ItemAnak(
        nama: 'Nasi Pecel',
        gambar: 'https://picsum.photos/id/1025/300/300',
      ),
    ],
  ),

  Anak(
    nama: 'Citra Lestari',
    items: [
      ItemAnak(
        nama: 'Seblak',
        gambar: 'https://picsum.photos/id/312/300/300',
      ),
      ItemAnak(
        nama: 'Batagor',
        gambar: 'https://picsum.photos/id/433/300/300',
      ),
    ],
  ),

  Anak(
    nama: 'Dewi Anggraini',
    items: [
      ItemAnak(
        nama: 'Rendang',
        gambar: 'https://picsum.photos/id/577/300/300',
      ),
      ItemAnak(
        nama: 'Gulai Ayam',
        gambar: 'https://picsum.photos/id/578/300/300',
      ),
    ],
  ),

  Anak(
    nama: 'Eko Saputra',
    items: [
      ItemAnak(
        nama: 'Pempek',
        gambar: 'https://picsum.photos/id/579/300/300',
      ),
      ItemAnak(
        nama: 'Martabak',
        gambar: 'https://picsum.photos/id/580/300/300',
      ),
    ],
  ),

  Anak(
    nama: 'Fajar Nugroho',
    items: [
      ItemAnak(
        nama: 'Sushi',
        gambar: 'https://picsum.photos/id/581/300/300',
      ),
      ItemAnak(
        nama: 'Ramen',
        gambar: 'https://picsum.photos/id/582/300/300',
      ),
    ],
  ),
];
