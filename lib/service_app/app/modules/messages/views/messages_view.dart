import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/chat_info_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/chat_provider.dart';
import 'package:flutter_sixvalley_ecommerce/service_app/app/models/message_model.dart';
import 'package:flutter_sixvalley_ecommerce/service_app/app/models/user_model.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/not_loggedin_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/notifications_button_widget.dart';
import '../controllers/messages_controller.dart';
import '../widgets/message_item_widget.dart';
import 'package:provider/provider.dart';

class MessagesView extends GetView<MessagesController> {
  bool isFirstTime = true;

  Widget conversationsList(List<UniqueShops> souqChat) {
    if (souqChat == null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: CircularProgressIndicator()),
      );
    } else
      return Obx(
        () {
          if (controller.messages.isNotEmpty || souqChat.isNotEmpty) {
            final _messages = [...controller.messages];
            _messages.addAll(souqChat.map((e) => Message.customFromSouq(e)));
            _messages
                .sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
            return ListView.separated(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: _messages.length + 1,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 7);
                },
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  if (index == _messages.length) {
                    return Obx(() {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Center(
                          child: new Opacity(
                            opacity: controller.isLoading.value ? 1 : 0,
                            child: new CircularProgressIndicator(),
                          ),
                        ),
                      );
                    });
                  } else {
                    return MessageItemWidget(
                      message: _messages.elementAt(index),
                      // onDismissed: (conversation) async {
                      //   await controller
                      //       .deleteMessage(controller.messages.elementAt(index));
                      // },
                    );
                  }
                });
          } else {
            return CircularLoadingWidget(
              height: Get.height,
              onCompleteText: "Messages List Empty".tr,
            );
          }
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    bool isGuestMode =
        !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (isFirstTime) {
      if (!isGuestMode) {
        Provider.of<ChatProvider>(context, listen: false).initChatInfo(context);
      }
      isFirstTime = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chats".tr,
          style: Get.textTheme.headline6,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Get.theme.hintColor),
          onPressed: () => {Scaffold.of(context).openDrawer()},
        ),
        // actions: [
        // NotificationsButtonWidget(),
        // ],
      ),
      body: isGuestMode
          ? NotLoggedInWidget()
          : RefreshIndicator(onRefresh: () async {
              controller.messages.clear();
              controller.lastDocument = new Rx<DocumentSnapshot>(null);
              controller.listenForMessages();
              Provider.of<ChatProvider>(context, listen: false)
                  .initChatInfo(context);
            }, child: Consumer<ChatProvider>(builder: (context, prov, _) {
              return conversationsList(prov.uniqueShopList);
            })),
    );
  }
}
