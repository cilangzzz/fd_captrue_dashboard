part of dashboard;

class _Sidebar extends StatelessWidget {
  const _Sidebar({
    required this.data,
    required this.pageSwitchFunc,
    Key? key,
  }) : super(key: key);

  final ProjectCardData data;
  final Function(String) pageSwitchFunc;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(kSpacing),
            child: ProjectCard(
              data: data,
            ),
          ),
          const Divider(thickness: 1),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.5,
            child: SingleChildScrollView(
              child: SelectionButton(
                data: [
                  SelectionButtonData(
                    activeIcon: EvaIcons.grid,
                    icon: EvaIcons.gridOutline,
                    label: "Dashboard",
                  ),
                  SelectionButtonData(
                    activeIcon: EvaIcons.radio,
                    icon: EvaIcons.radio,
                    label: "Node",
                  ),
                  SelectionButtonData(
                    activeIcon: EvaIcons.archive,
                    icon: EvaIcons.archiveOutline,
                    label: "Shortcut",
                  ),
                  SelectionButtonData(
                    activeIcon: EvaIcons.repeat,
                    icon: EvaIcons.repeatOutline,
                    label: "Connection",
                    // totalNotif: 20,
                  ),
                  SelectionButtonData(
                    activeIcon: EvaIcons.book,
                    icon: EvaIcons.bookOutline,
                    label: "Rule",
                  ),
                  SelectionButtonData(
                    activeIcon: EvaIcons.calendar,
                    icon: EvaIcons.calendarOutline,
                    label: "Log",
                  ),
                  SelectionButtonData(
                    activeIcon: EvaIcons.settings,
                    icon: EvaIcons.settingsOutline,
                    label: "Setting",
                  ),
                ],
                onSelected: (index, value) {
                  this.pageSwitchFunc(value.label);
                  log("index : $index | label : ${value.label}");
                },
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          const Divider(thickness: 1),
          const SizedBox(height: kSpacing * 2),
          UpgradePremiumCard(
            backgroundColor: Theme.of(context).canvasColor.withOpacity(.4),
            onPressed: () {},
          ),
          const SizedBox(height: kSpacing),
        ],
      ),
    );
  }
}
