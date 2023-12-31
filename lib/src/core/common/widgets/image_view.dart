import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../app/logic/app_settings.dart';
import '../../../injection.dart';
import '../../constants/const.dart';
import 'logo_view.dart';

class ImageBuilder extends StatelessWidget {
  late final String? imageUrl;
  final double? width;
  final BoxFit? fit;
  ImageBuilder({
    this.imageUrl,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) return errorPlaceholder();

    if (kIsWeb) {
      return imageProviderForWeb();
    } else {
      return imageProviderForMobile();
    }
  }

  Widget imageProviderForWeb() {
    return Image.network(
      imageUrl!,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            color: Colors.black,
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 0)
                : null,
          ),
        );
      },
    );
  }

  Widget imageProviderForMobile() {
    return CachedNetworkImage(
      width: width,
      imageUrl: imageUrl ?? '',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) => loadingImage(),
      errorWidget: (context, url, error) => errorPlaceholder(),
    );
  }

  Widget errorPlaceholder() {
    return Container(
      decoration: const BoxDecoration(),
      child: Center(
        child: LogoView(),
      ),
    );
  }

  Widget loadingImage({double height = 80, double width = 80}) {
    return SizedBox(
      height: 200.0,
    );
  }
}
