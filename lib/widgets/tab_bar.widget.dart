import 'package:flutter/material.dart';
import 'package:shopify_app/widgets/selected_color.dart';
import 'package:shopify_app/widgets/selected_size.widget.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({super.key});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context)
                .colorScheme
                .copyWith(surfaceVariant: Colors.transparent),
          ),
          child: TabBar(
            unselectedLabelColor: Color(0xff727c8e),
            indicatorSize: TabBarIndicatorSize.label,
            controller: tabController,
            labelColor: Color(0xffff6969),
            labelPadding: EdgeInsets.symmetric(horizontal: 1.0),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color(0xffffffff),
            ),
            tabs: <Widget>[
              Text(
                'Product',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                'Details',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              // Content for Tab 1
              Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'SELECT COLOR',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color(0xff515c6f).withOpacity(0.502),
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                    // SelectedColor(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'SELECT SIZE (US)',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color(0xff515c6f).withOpacity(0.502),
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                    // SelectedSize(),
                  ],
                ),
              ),

              // Content for Tab 2
              Container(
                child: Center(
                  child: Text('Tab 2 Content'),
                ),
              ),
              // Content for Tab 3
              Container(
                child: Center(
                  child: Text('Tab 3 Content'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
