import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/top_seller_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/top_seller_chat_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/products_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TopSellerProductScreen extends StatelessWidget {
  final TopSellerModel topSeller;
  final int topSellerId;
  TopSellerProductScreen({@required this.topSeller, this.topSellerId});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).clearSellerData();
    Provider.of<ProductProvider>(context, listen: false)
        .initSellerProductList(topSellerId.toString(), 1, context);
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
                          '${Provider.of<SplashProvider>(context, listen: false).baseUrls.shopImageUrl}/banner/${topSeller.banner != null ? topSeller.banner : ''}',
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
                                  '${Provider.of<SplashProvider>(context, listen: false).baseUrls.shopImageUrl}/${topSeller.image}',
                              imageErrorBuilder: (c, o, s) => Image.asset(
                                  Images.placeholder,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          if (topSeller.isVerified)
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            topSeller.name,
                            style: titilliumSemiBold.copyWith(
                                fontSize: Dimensions.FONT_SIZE_LARGE),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: RatingBar(
                              rating: topSeller.rate,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (topSeller.phone != null &&
                                  topSeller.phone.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      launch("tel:${topSeller.phone}");
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.phone,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              if (topSeller.facebook != null &&
                                  topSeller.facebook.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      launch(topSeller.facebook);
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.facebook,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              if (topSeller.tiktok != null &&
                                  topSeller.tiktok.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      launch(topSeller.tiktok);
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.tiktok,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              if (topSeller.instagram != null &&
                                  topSeller.instagram.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      launch(topSeller.instagram);
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.instagram,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              if (topSeller.whatsapp != null &&
                                  topSeller.whatsapp.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      launch(
                                          "https://api.whatsapp.com/send?phone=${topSeller.whatsapp}");
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.whatsapp,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              if (topSeller.twitter != null &&
                                  topSeller.twitter.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      launch(topSeller.twitter);
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
                              } else if (topSeller != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => TopSellerChatScreen(
                                            topSeller: topSeller)));
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
                          Text(topSeller.likes.toString())
                        ],
                      ),
                    ]),
                    if (topSeller.discription != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: AlignmentDirectional.bottomStart,
                            child: Text(topSeller.discription)),
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
                      sellerId: topSeller.id.toString()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
