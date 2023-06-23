import 'package:flutter/cupertino.dart';
import 'package:image_picker_plus/image_picker_plus.dart' as plus;
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/resources/resources.dart';

class ImagePickerHelper {
  static Future<plus.SelectedImagesDetails?> showImagePicker(BuildContext context) async {
    final localization = context.localizations;

    plus.ImagePickerPlus picker = plus.ImagePickerPlus(context);

    return await picker.pickImage(
      multiImages: false,
      source: plus.ImageSource.gallery,
      galleryDisplaySettings: plus.GalleryDisplaySettings(
        appTheme: plus.AppTheme(
          focusColor: AppColors.primaryColor,
        ),
        maximumSelection: 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        tabsTexts: plus.TabsTexts(
          photoText: localization.photo,
          galleryText: localization.gallery,
          deletingText: localization.delete,
          acceptAllPermissions: localization.acceptPermissions,
        ),
      ),
    );
  }
}
