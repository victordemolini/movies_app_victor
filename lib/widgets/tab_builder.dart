import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app_victor/models/actor.dart';
import 'package:movies_app_victor/screens/actors_details_screen.dart';

class TabBuilder extends StatelessWidget {
  const TabBuilder({
    required this.future,
    Key? key,
  }) : super(key: key);
  final Future<List<Actor>?> future;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 12.0),
      child: FutureBuilder<List<Actor>?>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int itemcount = snapshot.data!.length > 6 ? 6 : snapshot.data!.length;

            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.6,
              ),
              itemCount: itemcount,
              itemBuilder: (context, index) {
                Actor actor = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Get.to(ActorsDetailsScreen(actorId: actor.id));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500/${actor.profilePath}',
                      height: 300,
                      width: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                      const Icon(
                        Icons.broken_image,
                        size: 180,
                      ),
                      loadingBuilder: (_, __, ___) {
                        if (___ == null) return __;
                        return const FadeShimmer(
                          width: 180,
                          height: 250,
                          highlightColor: Color(0xff22272f),
                          baseColor: Color(0xff20252d),
                        );
                      },
                    ),
                  ),
                );
              },
            );

          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
