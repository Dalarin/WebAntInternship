import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/resources/resources.dart';
import 'package:webant_internship/ui/widgets/widgets.dart';

import 'bloc/image_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final _controller = ScrollController();
  late final TabController _tabController;

  int _currentTabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_tabListener);
    _controller.addListener(_scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.offset == _controller.position.maxScrollExtent) {
      final bloc = context.read<ImageBloc>();
      if (bloc.state.status != Status.loading) {
        final bloc = context.read<ImageBloc>();
        bloc.add(
          ImageEvent.getImages(
            isNewRequest: false,
            isPopular: _currentTabIndex == 1,
            isNewMedia: _currentTabIndex == 0,
          ),
        );
      }
    }
  }

  void _tabListener() {
    _currentTabIndex = _tabController.index;
    final bloc = context.read<ImageBloc>();


    if (bloc.state.status != Status.loading) {
      bloc.add(
        ImageEvent.getImages(
          isPopular: _currentTabIndex == 1,
          isNewMedia: _currentTabIndex == 0,
          isNewRequest: true,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;
    final textTheme = context.textTheme;
    final size = context.screenSize;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.18),
        child: AppBar(
          scrolledUnderElevation: 0.0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 40,
            ),
            child: CustomTextField(
              controller: TextEditingController(),
              hint: localization.search,
              suffixIcon: const Icon(
                Icons.search,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.black,
            unselectedLabelColor: AppColors.inactiveColor,
            labelStyle: textTheme.headlineSmall,
            tabs: [
              const Tab(text: 'Релиз'),
              Tab(text: localization.popular),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: RefreshIndicator(
            onRefresh: () async {
              _tabListener();
            },
            child: SingleChildScrollView(
              controller: _controller,
              child: BlocBuilder<ImageBloc, ImageState>(
                builder: (context, state) {
                  if (state.status == Status.failure) {
                    return CustomError(
                      message: state.errorEnum.message(context.localizations),
                    );
                  }

                  return Column(
                    children: [
                      ImageList(media: state.media),
                      Builder(
                        builder: (context) {
                          if (state.status == Status.loading) {
                            return CustomLoader(
                              radius: state.media.isNotEmpty ? 20 : 40,
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
