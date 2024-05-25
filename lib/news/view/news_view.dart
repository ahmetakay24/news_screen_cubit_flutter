import 'package:bloc_exercise/news/cubit/news_cubit.dart';
import 'package:bloc_exercise/news/repository/news_service.dart';
import 'package:bloc_exercise/news/view/widgets/news_appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit(SampleNewsRepository()),
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) => Scaffold(
        appBar: const NewsAppBar(),
        body: BlocConsumer<NewsCubit, NewsState>(
          listener: (context, state) {
            if (state is NewsError) {
              Scaffold.of(context).showBottomSheet(
                (context) {
                  return const Text("Error");
                },
              );
            }
          },
          builder: (context, state) {
            if (state is NewsInitial) {
              return Center(
                child: Column(
                  children: [
                    const Text("Get News"),
                    IconButton(onPressed: () => context.read<NewsCubit>().loadNews(), icon: const Icon(Icons.download))
                  ],
                ),
              );
            } else if (state is NewsLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else if (state is NewsCompleted) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: buildNewsList(context, state),
              );
            } else {
              final error = state as NewsError;
              return Center(
                child: Text(error.message),
              );
            }
          },
        ),
      );

  Widget buildNewsList(BuildContext context, NewsCompleted state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView.builder(
        itemCount: state.news?.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const Spacer(flex: 7),
                    Expanded(
                      flex: 29,
                      child: Text(
                        state.news![index].title.toString(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
                      ),
                    ),
                    const Spacer(flex: 3),
                    const Expanded(
                      child: Divider(
                        height: 10,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(flex: 3),
                    Expanded(
                      flex: 40,
                      child: CachedNetworkImage(
                        imageUrl: state.news![index].banner_image.toString(),
                        placeholder: (context, url) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Image.network(
                              "https://cdn.pixabay.com/photo/2014/04/02/17/08/globe-308065_960_720.png");
                        },
                      ),
                    ),
                    const Spacer(flex: 1),
                    Expanded(
                      flex: 20,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 100,
                            child: Text(
                              "Date : ${DateTimeFormat.format(DateTime.parse(state.news![index].time_published.toString()), format: 'D, M j, H:i')}",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                            ),
                          ),
                          const Spacer(),
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: VerticalDivider(),
                            ),
                          ),
                          const Spacer(flex: 5),
                          Expanded(
                            flex: 99,
                            child: Row(
                              children: [
                                Text(
                                  "For more :",
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(state.news![index].url.toString());
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    } else {
                                      throw "Could not open $url";
                                    }
                                  },
                                  child: Text(
                                    "Click",
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
