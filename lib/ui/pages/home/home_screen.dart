import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/di/di.dart';
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/resources/resources.dart';
import 'package:webant_internship/ui/widgets/widgets.dart';
import 'package:webant_internship/usecases/get_images_usecase.dart';

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
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;
    final textTheme = context.textTheme;
    final size = context.screenSize;

    return BlocProvider(
      create: (context) => ImageBloc(
        imagesUseCase: GetImagesUseCase(
          repository: injection(),
        ),
        localization: localization,
      )..add(const ImageEvent.getImages()),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.18),
          child: AppBar(
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
                Tab(text: localization.newMedia),
                Tab(text: localization.popular),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              CupertinoSliverRefreshControl(
                onRefresh: () async {},
              ),
              SliverFillRemaining(
                child: Center(
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: BlocBuilder<ImageBloc, ImageState>(
                      builder: (context, state) {
                        if (state.status == Status.loading) {
                          return const CustomLoader(
                            radius: 40,
                          );
                        }

                        if (state.status == Status.failure) {
                          return CustomError(message: state.error);
                        }

                        return ImageList(media: state.media);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
