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
    alamat: 'Haee antek antek asing jhhvuvgvgvg hg g gg gh ghvgvgvyugyuibhj hk gh gh gh gy gh hbm gjvgyvyuvyuibj jbuybh ghk gkc gv gh bn gkvgy ugvtyvyivvhjvvbnvbnvhvhuygh j g h gh h gh h h  vvhjyuguguiglknklnoihlnjk mn vhujvuvhjvhjhhj',
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
