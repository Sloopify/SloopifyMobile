// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:equatable/equatable.dart';

enum UploadPictureStatus { init, loading, done, noInternet, networkError }

class UploadPictureState extends Equatable {
  final File? image;
  final File? coverImage;
  final UploadPictureStatus uploadPictureStatus;
  final String errorMessage;
  const UploadPictureState({
    required this.coverImage,
    required this.image,
    required this.uploadPictureStatus,
    required this.errorMessage,
  });

  factory UploadPictureState.empty() {
    return UploadPictureState(
      coverImage: null,
      image: null,
      uploadPictureStatus: UploadPictureStatus.init,
      errorMessage: '',
    );
  }
  @override
  List<Object> get props => [
    image.hashCode,
    uploadPictureStatus,
    errorMessage,
    coverImage.hashCode
  ];

  UploadPictureState copyWith({
    File? image,
    UploadPictureStatus? uploadPictureStatus,
    String? errorMessage,
    File? coverImage
  }) {
    return UploadPictureState(
      coverImage: coverImage??this.coverImage,
      image: image ?? this.image,
      uploadPictureStatus: uploadPictureStatus ?? this.uploadPictureStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
