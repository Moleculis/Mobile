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
