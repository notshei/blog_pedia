class Post {
  final String idpost;
  final String judul;
  // ignore: non_constant_identifier_names
  final String isi_post;
  // ignore: non_constant_identifier_names
  final String file_gambar;
  final String username;
  final String nama;
  final String read;

  Post(
      {this.idpost,
      this.judul,
      // ignore: non_constant_identifier_names
      this.isi_post,
      // ignore: non_constant_identifier_names
      this.file_gambar,
      this.username,
      this.nama,
      this.read});

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      idpost: json['idpost'],
      judul: json['judul'],
      isi_post: json['isi_post'],
      file_gambar: json['file_gambar'],
      username: json['username'],
      nama: json['nama'],
      read: json['read'],
    );
  }
}
