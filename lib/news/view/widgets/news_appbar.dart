import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NewsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: CachedNetworkImage(
        imageUrl: "https://avatars.slack-edge.com/2020-04-21/1069616724710_52d32ecfe70c3c33b443_512.png",
      ),
      title: const Text("News"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}