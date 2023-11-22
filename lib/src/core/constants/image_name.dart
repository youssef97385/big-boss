

enum ImageName {
  logo,
}

// ignore: avoid_classes_with_only_static_members
class ImageNameHelper {
  static String getValue(ImageName path) {
    switch (path) {
      case ImageName.logo:
        return 'assets/images/logo.png';

    }
  }
}
