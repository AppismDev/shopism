
import 'package:flutter/material.dart';


extension NumberExtension on BuildContext {
  double get veryLowValue => dynamicHeight(0.005);

  double get lowValue => dynamicHeight(0.015);

  double get mediumValue => dynamicHeight(0.03);

  double get highValue => dynamicHeight(0.05);
}

extension MediaQueryExtensions on BuildContext {
  double dynamicWidth(double value) => MediaQuery.of(this).size.width * value;

  double dynamicHeight(double value) => MediaQuery.of(this).size.height * value;

}


extension ContextExtension on BuildContext {
    ThemeData get theme => Theme.of(this);

}

extension PaddingExtension  on BuildContext {
  //All
  EdgeInsets get paddingAllVeryLow => EdgeInsets.all(veryLowValue);

  EdgeInsets get paddingAllLow => EdgeInsets.all(lowValue);

  EdgeInsets get paddingAllMedium => EdgeInsets.all(mediumValue);

  EdgeInsets get paddingAllHigh => EdgeInsets.all(highValue);

  //Horizontal
  EdgeInsets get paddingHorizontalLow => EdgeInsets.symmetric(horizontal: lowValue);

  EdgeInsets get paddingHorizontalMedium => EdgeInsets.symmetric(horizontal: mediumValue);

  EdgeInsets get paddingHorizontalHigh => EdgeInsets.symmetric(horizontal: highValue);

  //Vertical

  EdgeInsets get paddingVerticalLow => EdgeInsets.symmetric(vertical: lowValue);

  EdgeInsets get paddingVerticalMedium => EdgeInsets.symmetric(vertical: mediumValue);

  EdgeInsets get paddingVerticalHigh => EdgeInsets.symmetric(vertical: highValue);

  //Only top
  EdgeInsets get paddingOnlyTopVeryLow => EdgeInsets.only(top: veryLowValue);

  EdgeInsets get paddingOnlyTopLow => EdgeInsets.only(top: lowValue);

  EdgeInsets get paddingOnlyTopMedium => EdgeInsets.only(top: mediumValue);

  EdgeInsets get paddingOnlyTopHigh => EdgeInsets.only(top: highValue);

  //Only bottom

  EdgeInsets get paddingOnlyBottomLow => EdgeInsets.only(bottom: lowValue);

  EdgeInsets get paddingOnlyBottomVeryLow => EdgeInsets.only(bottom: veryLowValue);

  EdgeInsets get paddingOnlyBottomMedium => EdgeInsets.only(bottom: mediumValue);

  EdgeInsets get paddingOnlyBottomHigh => EdgeInsets.only(bottom: highValue);

  //Only left

  EdgeInsets get paddingOnlyLeftLow => EdgeInsets.only(left: lowValue);

  EdgeInsets get paddingOnlyLeftMedium => EdgeInsets.only(left: mediumValue);

  EdgeInsets get paddingOnlyLeftHigh => EdgeInsets.only(left: highValue);

  //Only right

  EdgeInsets get paddingOnlyRightLow => EdgeInsets.only(right: lowValue);

  EdgeInsets get paddingOnlyRightVeryLow => EdgeInsets.only(right: veryLowValue);

  EdgeInsets get paddingOnlyRightMedium => EdgeInsets.only(right: mediumValue);

  EdgeInsets get paddingOnlyRightHigh => EdgeInsets.only(right: highValue);


}

