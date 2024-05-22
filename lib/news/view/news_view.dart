import 'package:bloc_exercise/news/cubit/news_cubit.dart';
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
              return Column(
                children: [
                  const Text("Get News"),
                  //IconButton(onPressed: () => context.bloc<NewsCubit>().loadNews(), icon: const Icon(Icons.download))
                ],
              );
            } else if (state is NewsLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else if (state is NewsCompleted) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  const ListTile();
                  return null;
                },
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
