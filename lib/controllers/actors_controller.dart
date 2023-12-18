import 'package:get/get.dart';
import 'package:movies_app_victor/api/api_service.dart';
import 'package:movies_app_victor/models/actor.dart';

class ActorsController extends GetxController {
  var isLoading = false.obs;
  var mainPopularActors = <Actor>[].obs;
  var mainSelectedActors = Rxn<Actor>();
  @override
  void onInit() async {
    super.onInit();
    await fetchPopularActors();
  }
  Future<void> fetchPopularActors() async {
    isLoading.value = true;
    var actors = await ApiService.getPopularActors();
    if (actors != null) {
      mainPopularActors.value = actors;
    }
    isLoading.value = false;
  }

  Future<void> fetchActorDetails(int actorId) async {
    isLoading.value = true;
    var actorDetails = await ApiService.getActorDetails(actorId);
    if (actorDetails != null) {
      mainSelectedActors.value = actorDetails;
    }
    isLoading.value = false;
  }
}
