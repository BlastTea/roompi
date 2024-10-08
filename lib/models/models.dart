import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.g.dart';
part 'models.freezed.dart';

bool? _parseBool(dynamic data) {
  if (data is int? && data != null) return data == 1;

  if (data is String? && data != null) return int.tryParse(data) == 1;

  return data;
}

int? _parseInt(dynamic value) => value is String? && value != null
    ? int.tryParse(value)
    : value is int
        ? value
        : null;

@unfreezed
class User with _$User {
  factory User({
    @JsonKey(fromJson: _parseInt) int? id,
    String? name,
    String? email,
    @JsonKey(name: 'email_verified_at') DateTime? emailVerifiedAt,
    UserRole? role,
    String? foto,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updateAt,
    UserDetail? detail,
    @JsonKey(includeFromJson: false, includeToJson: false) Uint8List? imageData,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@Freezed(
  unionKey: 'role',
  equal: false,
  addImplicitFinal: false,
  makeCollectionsUnmodifiable: false,
)
sealed class UserDetail with _$UserDetail {
  @FreezedUnionValue('Remaja')
  factory UserDetail.remaja({
    @JsonKey(fromJson: _parseInt) int? id,
    @JsonKey(name: 'nama_orang_tua') String? namaOrangTua,
    @JsonKey(fromJson: _parseInt) int? exp,
    @JsonKey(fromJson: _parseInt) int? star,
    @JsonKey(fromJson: _parseInt) int? level,
    @JsonKey(name: 'kode_orang_tua') String? kodeOrangTua,
    @JsonKey(name: 'user_id', fromJson: _parseInt) int? userId,
    String? username,
    @JsonKey(name: 'orang_tua_id', fromJson: _parseInt) int? orangTuaId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = Remaja;

  @FreezedUnionValue('Mentor')
  factory UserDetail.mentor({
    @JsonKey(name: 'nama_lengkap') String? namaLengkap,
    String? gelar,
    @JsonKey(name: 'riwayat_pendidikan_terakhir') String? riwayatPendidikanTerakhir,
  }) = Mentor;

  @FreezedUnionValue('Parent')
  factory UserDetail.orangTua({
    @JsonKey(fromJson: _parseInt) int? id,
    @JsonKey(name: 'nama_lengkap') String? namaLengkap,
    String? kode,
    @JsonKey(name: 'user_id', fromJson: _parseInt) int? userId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = OrangTua;

  factory UserDetail.fromJson(Map<String, dynamic> json) => _$UserDetailFromJson(json);
}

@freezed
class Leaderboard with _$Leaderboard {
  factory Leaderboard({
    @JsonKey(fromJson: _parseInt) int? id,
    String? name,
    @JsonKey(fromJson: _parseInt) int? exp,
    @JsonKey(fromJson: _parseInt) int? star,
    String? foto,
  }) = _Leaderboard;

  factory Leaderboard.fromJson(Map<String, dynamic> json) => _$LeaderboardFromJson(json);
}

@freezed
class Exercise with _$Exercise {
  factory Exercise({
    @JsonKey(name: 'category_id', fromJson: _parseInt) int? categoryId,
    @JsonKey(name: 'nama_mapel') String? namaMapel,
    @JsonKey(name: 'data_bagian') List<ExercisePart>? dataBagian,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);
}

@freezed
class ExercisePart with _$ExercisePart {
  factory ExercisePart({
    @JsonKey(name: 'bagian_id', fromJson: _parseInt) int? bagianId,
    @JsonKey(name: 'nama_bagian') String? namaBagian,
    @JsonKey(name: 'data_sub_bagian') List<ExerciseSubsection>? dataSubBagian,
  }) = _ExercisePart;

  factory ExercisePart.fromJson(Map<String, dynamic> json) => _$ExercisePartFromJson(json);
}

@freezed
class ExerciseSubsection with _$ExerciseSubsection {
  factory ExerciseSubsection({
    @JsonKey(name: 'sub_bagian_id', fromJson: _parseInt) int? subBagianId,
    @JsonKey(name: 'nama_sub_bagian') String? namaSubBagian,
    @JsonKey(fromJson: _parseInt) int? nilai,
    @JsonKey(fromJson: _parseBool) bool? completed,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ExerciseSubsection;

  factory ExerciseSubsection.fromJson(Map<String, dynamic> json) => _$ExerciseSubsectionFromJson(json);
}

@freezed
class HistoryExercise with _$HistoryExercise {
  factory HistoryExercise({
    @JsonKey(fromJson: _parseInt) int? id,
    @JsonKey(name: 'remaja_id', fromJson: _parseInt) int? remajaId,
    @JsonKey(name: 'bagian_id', fromJson: _parseInt) int? bagianId,
    @JsonKey(name: 'sub_bagian_id', fromJson: _parseInt) int? subBagianId,
    @JsonKey(fromJson: _parseInt) int? nilai,
    @JsonKey(fromJson: _parseBool) bool? completed,
    @JsonKey(name: 'nama_bagian') String? namaBagian,
    @JsonKey(name: 'nama_sub_bagian') String? namaSubBagian,
  }) = _HistoryExercise;

  factory HistoryExercise.fromJson(Map<String, dynamic> json) => _$HistoryExerciseFromJson(json);
}

@freezed
class DataSoal with _$DataSoal {
  factory DataSoal({
    Soal? soal,
    List<Pilihan>? pilihan,
  }) = _DataSoal;

  factory DataSoal.fromJson(Map<String, dynamic> json) => _$DataSoalFromJson(json);
}

@freezed
class Soal with _$Soal {
  factory Soal({
    @JsonKey(fromJson: _parseInt) int? id,
    String? pertanyaan,
    @JsonKey(name: 'sub_bagian_id', fromJson: _parseInt) int? subBagianId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Soal;

  factory Soal.fromJson(Map<String, dynamic> json) => _$SoalFromJson(json);
}

@freezed
class Pilihan with _$Pilihan {
  factory Pilihan({
    @JsonKey(fromJson: _parseInt) int? id,
    String? pilihan,
    @JsonKey(fromJson: _parseInt) int? skor,
    @JsonKey(fromJson: _parseBool) bool? benar,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'soal_id', fromJson: _parseInt) int? soalId,
  }) = _Pilihan;

  factory Pilihan.fromJson(Map<String, dynamic> json) => _$PilihanFromJson(json);
}

@freezed
class Meet with _$Meet {
  factory Meet({
    @JsonKey(fromJson: _parseInt) int? id,
    String? topik,
    String? deskripsi,
    @JsonKey(name: 'jam_mulai') DateTime? jamMulai,
    @JsonKey(name: 'jam_berakhir') DateTime? jamBerakhir,
    DateTime? tanggal,
    String? link,
    String? materi,
    @JsonKey(name: 'total_remaja', fromJson: _parseInt) int? totalRemaja,
    @JsonKey(name: 'mentor_id', fromJson: _parseInt) int? mentorId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    MeetStatus? status,
    @JsonKey(name: 'nama_lengkap') String? namaLengkap,
    String? gelar,
    @JsonKey(name: 'riwayat_pendidikan_terakhir') String? riwayatPendidikanTerakhir,
    String? foto,
  }) = _Meet;

  factory Meet.fromJson(Map<String, dynamic> json) => _$MeetFromJson(json);
}

@freezed
class MentorMeet with _$MentorMeet {
  factory MentorMeet({
    @JsonKey(fromJson: _parseInt) int? id,
    String? topik,
    String? deskripsi,
    @JsonKey(name: 'jam_mulai') DateTime? jamMulai,
    @JsonKey(name: 'jam_berakhir') DateTime? jamBerakhir,
    DateTime? tanggal,
    String? link,
    String? materi,
    @JsonKey(name: 'total_remaja') int? totalRemaja,
    @JsonKey(name: 'mentor_id') int? mentorId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    MeetStatus? status,
  }) = _MentorMeet;

  factory MentorMeet.fromJson(Map<String, dynamic> json) => _$MentorMeetFromJson(json);
}

@unfreezed
class ChatbotData with _$ChatbotData {
  factory ChatbotData({
    required String text,
    @JsonKey(name: 'is_sender') required bool isSender,
    @JsonKey(name: 'sent_at') required DateTime sentAt,
  }) = _ChatbotData;

  factory ChatbotData.fromJson(Map<String, dynamic> json) => _$ChatbotDataFromJson(json);
}

@freezed
class MessageBubbleList with _$MessageBubbleList {
  const factory MessageBubbleList({required List<List<MessageBubbleData>> data}) = _MessageBubbleList;

  factory MessageBubbleList.fromChatbotData({required List<ChatbotData> chatbotData}) {
    List<List<MessageBubbleData>> results = [];
    List<MessageBubbleData> messageBubbles = [];

    for (ChatbotData data in chatbotData) {
      DateTime? lastDate;
      DateTime currentDate = data.sentAt;

      // ignore: unnecessary_null_comparison
      if (lastDate != null && (currentDate.day != lastDate.day || currentDate.month != lastDate.month || currentDate.year != lastDate.year)) messageBubbles.add(MessageBubbleData.dateTime(dateTime: lastDate));

      messageBubbles.add(
        MessageBubbleData.text(
          message: data.text,
          isSender: data.isSender,
          sentAt: data.sentAt,
        ),
      );

      lastDate = data.sentAt;
    }

    results.add(messageBubbles);

    return MessageBubbleList(data: results);
  }
}

@freezed
sealed class MessageBubbleData with _$MessageBubbleData {
  const factory MessageBubbleData.dateTime({
    DateTime? dateTime,
  }) = MessageBubbleDataDateTime;

  const factory MessageBubbleData.text({
    String? message,
    DateTime? sentAt,
    @Default(true) bool isSender,
  }) = MessageBubbleDataText;

  factory MessageBubbleData.fromJson(Map<String, dynamic> json) => _$MessageBubbleDataFromJson(json);
}

enum UserRole {
  @JsonValue('Remaja')
  remaja,
  @JsonValue('Mentor')
  mentor,
  @JsonValue('Parent')
  parent;

  String get text => switch (this) {
        remaja => 'Pelajar',
        mentor => 'Mentor',
        parent => 'Orang Tua',
      };

  String get value => switch (this) {
        remaja => 'Remaja',
        mentor => 'Mentor',
        parent => 'Parent',
      };
}

enum MeetStatus {
  @JsonValue('Sudah dipublish')
  sudahDipublish,
  @JsonValue('Belum dipublish')
  belumDipublish;

  String get text => switch (this) {
        sudahDipublish => 'Sudah Dipublish',
        belumDipublish => 'Belum Dipublish',
      };
}

enum ActivityType {
  tamanBelajarMingguan,
  pusatKegiatanBelajarMasyarakat;

  String get text => switch (this) {
        tamanBelajarMingguan => 'Taman Belajar Mingguan (TBM)',
        pusatKegiatanBelajarMasyarakat => 'Pusat Kegiatan Belajar Masyarakat (PKBM)',
      };

  int get id => switch (this) {
        tamanBelajarMingguan => 1,
        pusatKegiatanBelajarMasyarakat => 2,
      };
}

enum EqualityPackageType {
  a,
  b,
  c;

  String get text => switch (this) {
        a => 'A',
        b => 'B',
        c => 'C',
      };

  int get id => switch (this) {
        a => 1,
        b => 2,
        c => 3,
      };
}
