import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify_app/models/cart.model.dart';
import 'package:shopify_app/models/product.model.dart';
import 'package:shopify_app/providers/cart.provider.dart';
import 'package:shopify_app/providers/product.provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalPrice = 0;
  @override
  Widget build(BuildContext pageContext) {
    return Scaffold(
      backgroundColor: Color(0xffF5F6F8),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Color(0xffff6969), size: 18),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Cart Page',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Color(0xff515c6f),
                ),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder(
          stream: Provider.of<CartProvider>(context).cartStream,
          builder: (ctx, aSnapShot) {
            if (aSnapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (aSnapShot.hasError) {
              return const Center(
                child: Text('Error While Getting Data'),
              );
            }

            if (aSnapShot.hasData) {
              var cartData = Cart.fromJson(
                  Map<String, dynamic>.from(aSnapShot.data?.data() ?? {}));

              if (cartData.items?.isEmpty ?? false) {
                return const Center(
                  child: Text('No Data Found'),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cartData.items?.length,
                          itemBuilder: (ctx, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FutureBuilder(
                                    future:
                                        Provider.of<ProductProvider>(context)
                                            .getProductById(
                                                productId: cartData
                                                    .items![index].productId!),
                                    builder: (context, snap) {
                                      if (snap.data != null) {
                                        Provider.of<CartProvider>(context,
                                                listen: false)
                                            .onAddProductToProductsList(
                                                snap.data!, cartData);

                                        Provider.of<CartProvider>(
                                          context,
                                        ).calculateTotal(cartData);
                                      }
                                      return Card(
                                        child: ListTile(
                                          leading: snap.data?.image != null
                                              ? CachedNetworkImage(
                                                  imageUrl:
                                                      snap.data?.image ?? '',
                                                  fit: BoxFit.contain,
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Center(
                                                        child:
                                                            Icon(Icons.error),
                                                      ),
                                                  progressIndicatorBuilder: (_,
                                                          __, progress) =>
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(50.0),
                                                        child:
                                                            CircularProgressIndicator(
                                                          value:
                                                              progress.progress,
                                                        ),
                                                      ))
                                              : const SizedBox.shrink(),
                                          title: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              snap.hasData
                                                  ? Flexible(
                                                      child: Text(
                                                          snap.data?.name ??
                                                              'No Name Found'),
                                                    )
                                                  : const SizedBox(
                                                      height: 50,
                                                      width: 50,
                                                      child: FittedBox(
                                                          child:
                                                              CircularProgressIndicator())),
                                            ],
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (cartData.items?[index]
                                                      .selectedVarints !=
                                                  null)
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                          ' ${cartData.items?[index].selectedVarints?.keys.map((e) => '${e} : ${cartData.items?[index].selectedVarints?[e]}')}'),
                                                    )
                                                  ],
                                                ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    if (snap.data?.price !=
                                                        null)
                                                      Flexible(
                                                        child: Text(
                                                          'Price: ${snap.data?.price}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .green),
                                                        ),
                                                      )
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  InkWell(
                                                      onTap: () => Provider.of<
                                                                  CartProvider>(
                                                              context,
                                                              listen: false)
                                                          .onIncreaseItemQuantityInCart(
                                                              context: context,
                                                              itemId: cartData
                                                                  .items![index]
                                                                  .itemId!,
                                                              cart: cartData),
                                                      child: const Icon(
                                                          Icons.add)),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 14,
                                                        vertical: 10),
                                                    child: Text(cartData
                                                            .items?[index]
                                                            .quantity
                                                            .toString() ??
                                                        '0'),
                                                  ),
                                                  InkWell(
                                                      onTap: () => Provider.of<
                                                                  CartProvider>(
                                                              context,
                                                              listen: false)
                                                          .onDecreaseItemQuantityInCart(
                                                              context: context,
                                                              itemId: cartData
                                                                  .items![index]
                                                                  .itemId!,
                                                              cart: cartData),
                                                      child: const Icon(
                                                          Icons.remove)),
                                                ],
                                              )
                                            ],
                                          ),
                                          trailing: IconButton(
                                              onPressed: () =>
                                                  Provider.of<CartProvider>(
                                                          context,
                                                          listen: false)
                                                      .onRemoveProductFromCart(
                                                          context: pageContext,
                                                          itemId: cartData
                                                              .items![index]
                                                              .itemId!,
                                                          cart: cartData),
                                              icon: const Icon(Icons.delete)),
                                        ),
                                      );
                                    }),
                              )),
                    ),
                    PhysicalModel(
                      color: Colors.white,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ValueListenableBuilder(
                                  valueListenable: Provider.of<CartProvider>(
                                    context,
                                  ).totalNotifier,
                                  builder: (context, value, __) {
                                    return Text(
                                      'Total : ${value}',
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 22),
                                    );
                                  }),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: () {},
                                child: const Text('Buy Now',
                                    style: TextStyle(color: Colors.white)))
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
            }

            return const SizedBox.shrink();
          }),
    );
  }
}
