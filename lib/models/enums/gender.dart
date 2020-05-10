enum Gender { male, female }

extension GenderName on Gender {
  String get name {
    switch (this) {
      case Gender.male:
        return 'MALE';
      case Gender.female:
        return 'FEMALE';
    }
    return null;
  }

  String get assetName {
    switch (this) {
      case Gender.male:
        return 'male';
      case Gender.female:
        return 'female';
    }
    return null;
  }
}

extension GenderExtension on String{
  Gender get gender {
    if (this == 'MALE') {
      return Gender.male;
    }
    if (this == 'FEMALE') {
      return Gender.female;
    }
    return null;
  }
}
