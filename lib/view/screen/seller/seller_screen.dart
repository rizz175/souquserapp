import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/seller_model.dart';

import 'package:flutter_sixvalley_ecommerce/helper/product_type.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/animated_custom_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/guest_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/rating_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/search_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/chat_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/products_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SellerScreen extends StatelessWidget {
  final SellerModel seller;
  SellerScreen({@required this.seller});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).removeFirstLoading();
    Provider.of<ProductProvider>(context, listen: false).clearSellerData();
    Provider.of<ProductProvider>(context, listen: false)
        .initSellerProductList(seller.id.toString(), 1, context);
    ScrollController _scrollController = ScrollController();

    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        children: [
          SearchWidget(
            hintText: 'Search product...',
            onTextChanged: (String newText) =>
                Provider.of<ProductProvider>(context, listen: false)
                    .filterData(newText),
            onClearPressed: () {},
          ),
          Expanded(
            child: ListView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(0),
              children: [
                // Banner
                Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder,
                      height: 120,
                      fit: BoxFit.cover,
                      image:
                          '${Provider.of<SplashProvider>(context, listen: false).baseUrls.shopImageUrl}/banner/${seller.shop != null ? seller.shop.image : ''}',
                      imageErrorBuilder: (c, o, s) => Image.asset(
                          Images.placeholder,
                          height: 120,
                          fit: BoxFit.cover),
                    ),
                  ),
                ),

                Container(
                  color: Theme.of(context).highlightColor,
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(children: [
                    // Seller Info
                    Row(children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: FadeInImage.assetNetwork(
                              placeholder: Images.placeholder,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                              image:
                                  '${Provider.of<SplashProvider>(context, listen: false).baseUrls.sellerImageUrl}/${seller.image}',
                              imageErrorBuilder: (c, o, s) => Image.asset(
                                  Images.placeholder,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          if (seller.shop.isVerified)
                            Positioned(
                                left: 0,
                                bottom: 2,
                                child: Icon(
                                  Icons.verified,
                                  color: Colors.blue,
                                )),
                        ],
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                      ShopInfo(
                        false,
                        seller: seller,
                      ),
                      Spacer(),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (!Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .isLoggedIn()) {
                                showAnimatedDialog(context, GuestDialog(),
                                    isFlip: true);
                              } else if (seller != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            ChatScreen(seller: seller)));
                              }
                            },
                            icon: Image.asset(Images.chat_image,
                                color: ColorResources.SELLER_TXT,
                                height: Dimensions.ICON_SIZE_DEFAULT),
                          ),
                          InkWell(
                            onTap: () {},
                            child: FaIcon(FontAwesomeIcons.thumbsUp),
                          ),
                          Text(seller.shop.likes.toString())
                        ],
                      ),
                    ]),
                    if (seller.shop.discription != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: AlignmentDirectional.bottomStart,
                            child: Text(seller.shop.discription)),
                      )
                  ]),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: ProductView(
                      isHomePage: false,
                      productType: ProductType.SELLER_PRODUCT,
                      scrollController: _scrollController,
                      sellerId: seller.id.toString()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShopInfo extends StatelessWidget {
  const ShopInfo(
    this.isFromProduct, {
    Key key,
    @required this.seller,
  }) : super(key: key);

  final SellerModel seller;
  final bool isFromProduct;

  @override
  Widget build(BuildContext context) {
    if (seller?.shop == null) {
      return SizedBox();
    }
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isFromProduct) ...[
              Text(
                seller.fName + ' ' + seller.lName,
                style: titilliumSemiBold.copyWith(
                    fontSize: Dimensions.FONT_SIZE_LARGE),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: RatingBar(
                  rating: seller.shop.rate,
                ),
              ),
            ],
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (seller.shop.phone != null && seller.shop.phone.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        launch("tel:${seller.shop.phone}");
                      },
                      child: FaIcon(
                        FontAwesomeIcons.phone,
                        size: 15,
                      ),
                    ),
                  ),
                if (seller.shop.facebook != null &&
                    seller.shop.facebook.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        launch(seller.shop.facebook);
                      },
                      child: FaIcon(
                        FontAwesomeIcons.facebook,
                        size: 15,
                      ),
                    ),
                  ),
                if (seller.shop.tiktok != null && seller.shop.tiktok.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        launch(seller.shop.tiktok);
                      },
                      child: FaIcon(
                        FontAwesomeIcons.tiktok,
                        size: 15,
                      ),
                    ),
                  ),
                if (seller.shop.instagram != null &&
                    seller.shop.instagram.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        launch(seller.shop.instagram);
                      },
                      child: FaIcon(
                        FontAwesomeIcons.instagram,
                        size: 15,
                      ),
                    ),
                  ),
                if (seller.shop.whatsapp != null &&
                    seller.shop.whatsapp.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        launch(
                            "https://api.whatsapp.com/send?phone=${seller.shop.whatsapp}");
                      },
                      child: FaIcon(
                        FontAwesomeIcons.whatsapp,
                        size: 15,
                      ),
                    ),
                  ),
                if (seller.shop.twitter != null &&
                    seller.shop.twitter.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        launch(seller.shop.twitter);
                      },
                      child: FaIcon(
                        FontAwesomeIcons.twitter,
                        size: 15,
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),

      ],
    );
  }
}
