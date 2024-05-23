import 'package:bloc_exercise/news/cubit/news_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit(),
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("News"),
        ),
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
                child: ListView.builder(
                  itemCount: state.news?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.black),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              const Spacer(
                                flex: 7,
                              ),
                              Expanded(
                                flex: 20,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: CachedNetworkImage(imageUrl: state.news![index].sourceIcon.toString())),
                                    Expanded(
                                      child: Text(
                                        state.news![index].title.toString(),
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(
                                flex: 3,
                              ),
                              const Expanded(
                                child: Divider(
                                  height: 10,
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(
                                flex: 3,
                              ),
                              Expanded(
                                  flex: 40,
                                  child: Text(
                                    state.news![index].description.toString(),
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                                  )),
                              const Spacer(
                                flex: 1,
                              ),
                              const Expanded(flex: 5, child: Text("World News")),
                              Expanded(
                                  flex: 20,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            "Date : ${DateTimeFormat.format(DateTime.parse(state.news![index].pubDate.toString()), format: 'D, M j, H:i')}"),
                                      ),
                                      const Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(child: Text("For more :")),
                                            Expanded(child: TextButton(onPressed: null, child: Text("Click")))
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                              const Spacer(
                                flex: 1,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
}
