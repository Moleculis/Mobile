enum Gender { male, female }

Gender genderFromString(String string) {
  return Gender.values.firstWhere(
    (element) => element.name == string,
  );
}

extension GenderName on Gender {
  String get name {
    switch (this) {
      case Gender.male:
        return 'MALE';
      case Gender.female:
        return 'FEMALE';
    }
  }

  String get assetName {
    switch (this) {
      case Gender.male:
        return 'male';
      case Gender.female:
        return 'female';
    }
  }
}

extension GenderExtension on String {
  Gender get gender {
    if (this == 'MALE') {
      return Gender.male;
    }
    return Gender.female;
  }
}
