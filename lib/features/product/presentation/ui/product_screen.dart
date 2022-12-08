

import 'package:ecom_app/common/extensions/string_hardcoded.dart';
import 'package:ecom_app/common/styles/dimens.dart';
import 'package:ecom_app/common/widget/app_scaffold.dart';
import 'package:ecom_app/features/product/presentation/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {    
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(productControllerProvider.notifier).getProducts();
    });

    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;

      if(_scrollController.position.pixels >= maxScrollExtent) {

        final currentPage = ref.read(productControllerProvider).currentPage;
        final totalPage = ref.read(productControllerProvider).totalPage;

        if(currentPage < totalPage) {
          ref.read(productControllerProvider.notifier).getProducts();
        }
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productControllerProvider);

    if(state.isLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    if(state.products.isEmpty) {
      return Center(
        child: Text("Empty product list".hardcoded),
      );
    }

    return AppScaffold(
      title: Text('Product'.hardcoded), 
      widget: Stack(
        children: [

          AlignedGridView.count(
            itemCount: state.products.length,
            crossAxisCount: 2, 
            crossAxisSpacing: kSmall,
            mainAxisSpacing: kSmall,
            controller: _scrollController,
            itemBuilder: (context, index) {
              final data = state.products[index];

              return Card(
                elevation: kSmall,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kSmall),
                ),
                shadowColor: Colors.teal,
                child: Padding(
                  padding: const EdgeInsets.all(kSmall),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Center(
                        child: Image.network(
                          data.images,
                          height: 150.0,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: kSmall,),

                      Text(
                        data.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Colors.black87,
                        ),
                      ),

                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.all(Radius.circular(kSmall)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(kXSmall),
                          child: Text(
                            'USD ${data.price}',
                            style: Theme.of(context).textTheme.caption?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );

              
            },
          ),

          if (state.isFetching) ... [
            const Positioned(
              bottom: kSmall,
              left: 0,
              right: 0,
              child: Center(child: CircularProgressIndicator.adaptive()),
            ),
          ]

        ],
      ),
    );
  }
}