import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/seller_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/animated_custom_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/guest_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/rating_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/title_row.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/chat_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/seller/seller_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SellerView extends StatelessWidget {
  final String sellerId;
  SellerView({@required this.sellerId});

  @override
  Widget build(BuildContext context) {
    Provider.of<SellerProvider>(context, listen: false)
        .initSeller(sellerId, context);

    return Consumer<SellerProvider>(
      builder: (context, seller, child) {
        return Container(
          margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          color: Theme.of(context).cardColor,
          child: Column(children: [
            TitleRow(
                title: getTranslated('seller', context), isDetailsPage: true),
            Row(children: [
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            SellerScreen(seller: seller.sellerModel))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      seller.sellerModel != null
                          ? '${seller.sellerModel.fName ?? ''} ${seller.sellerModel.lName ?? ''}'
                          : '',
                      style: titilliumSemiBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: ColorResources.SELLER_TXT),
                    ),
                    ShopInfo(
                      true,
                      seller: seller.sellerModel,
                    ),
                    if (seller?.sellerModel?.shop?.rate != null)
                      RatingBar(rating: seller.sellerModel.shop.rate)
                  ],
                ),
              ),
              Spacer(),
              Column(
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: FaIcon(FontAwesomeIcons.thumbsUp),
                      ),
                      Text(seller.sellerModel.shop.likes.toString())
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      if (!Provider.of<AuthProvider>(context, listen: false)
                          .isLoggedIn()) {
                        showAnimatedDialog(context, GuestDialog(),
                            isFlip: true);
                      } else if (seller.sellerModel != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    ChatScreen(seller: seller.sellerModel)));
                      }
                    },
                    icon: Image.asset(Images.chat_image,
                        color: ColorResources.SELLER_TXT,
                        height: Dimensions.ICON_SIZE_DEFAULT),
                  ),
                ],
              ),
            ]),
          ]),
        );
      },
    );
  }
}
