part of dashboard;

class DashboardController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  RxString page = "Dashboard".obs;

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  void setPage(String page) {
    this.page.value = page;
  }

  ProjectCardData getSelectedProject() {
    return ProjectCardData(
      percent: 1,
      projectImage: const AssetImage(ImageRasterPath.logo1),
      projectName: "Ciproxy",
      releaseTime: DateTime.now(),
    );
  }
}
