import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/blocs/image_bloc/image_bloc.dart';
import 'package:webant_internship/utils/enums.dart';
import 'package:webant_internship/widgets/error_widget.dart';
import 'package:webant_internship/widgets/image_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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

    final bloc = context.read<ImageBloc>();

    bloc.add(
      GetImages(popular: _currentTabIndex == 1, newMedia: _currentTabIndex == 0),
    );

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
          GetImages(
            popular: _currentTabIndex == 1,
            newMedia: _currentTabIndex == 0,
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
        GetImages(
          popular: _currentTabIndex == 1,
          newMedia: _currentTabIndex == 0,
          newRequest: true,
        ),
      );
    }
  }

  Future<void> _pullToRefresh() async {
    final bloc = context.read<ImageBloc>();
    bloc.add(
      GetImages(
        popular: _currentTabIndex == 1,
        newMedia: _currentTabIndex == 0,
        newRequest: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: 'New'),
              Tab(text: 'Popular'),
            ],
          ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _pullToRefresh,
            child: Center(
              child: SingleChildScrollView(
                controller: _controller,
                child: BlocBuilder<ImageBloc, ImageState>(
                  builder: (context, state) {


                    if (state.status == Status.failure) {
                      if (state.errorEnum == ErrorEnum.connection) {
                        return const CustomErrorWidget();
                      }
                    }

                    return Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
                          itemCount: state.media.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1 / .7,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return ImageListWidget(media: state.media[index]);
                          },
                        ),
                        Builder(
                          builder: (context) {
                            if (state.status == Status.loading) {
                              return const CircularProgressIndicator();
                            }
                            return const SizedBox();
                          },
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
