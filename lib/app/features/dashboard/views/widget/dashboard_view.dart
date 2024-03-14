import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:project_management/app/features/dashboard/models/connection.dart';
import 'package:project_management/app/features/dashboard/models/proxy_node.dart';
import 'package:project_management/app/features/dashboard/models/server_node.dart';
import 'package:project_management/app/features/dashboard/models/shortcut.dart';
import 'package:project_management/app/shared_components/radio_buttton.dart';
import 'package:project_management/app/shared_components/search_field.dart';

class DashboardView extends StatefulWidget {
  DashboardView({super.key, required this.pageName});
  final String pageName;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    switch (widget.pageName) {
      case "Dashboard":
        return const _DashboardView()
            .animate(delay: const Duration(microseconds: 300))
            .fade();
      case "Node":
        return const _NodeView()
            .animate(delay: const Duration(microseconds: 300))
            .fade();
      case "Shortcut":
        return const _ShortcutView()
            .animate(delay: const Duration(microseconds: 300))
            .fade(duration: Duration(microseconds: 300));
      case "Connection":
        return const _ConnectionView()
            .animate(delay: const Duration(microseconds: 300))
            .fade();
      case "Rule":
        return const _RuleView()
            .animate(delay: const Duration(microseconds: 300))
            .fade();
      case "Log":
        return const _LogView()
            .animate(delay: const Duration(microseconds: 300))
            .fade();
      case "Setting":
        return const _SettingView()
            .animate(delay: const Duration(microseconds: 300))
            .fade();
      default:
        return const _DashboardView().animate().fade();
    }
  }
}

class _DashboardView extends StatefulWidget {
  const _DashboardView({super.key});

  @override
  State<_DashboardView> createState() => __DashboardViewState();
}

class __DashboardViewState extends State<_DashboardView> {
  final TextEditingController _textController = TextEditingController();
  List<ServerNode> serverNodeList = [];

  @override
  void initState() {
    for (var i = 0; i < 100; i++) {
      serverNodeList.add(ServerNode(
          "server$i",
          "serverUrl$i",
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
          i.toDouble(),
          100));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopInput(),
          const SizedBox(
            height: 10,
          ),
          _buildSubscribeItemList(),
        ],
      ),
    );
  }

  Widget _buildTopInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 7,
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: const Icon(EvaIcons.copy),
                hintText: "Input Server cnf url",
                isDense: true,
                fillColor: Theme.of(context).cardColor,
              ),
              controller: _textController,
            )),
        Flexible(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // 调整圆角的半径
                ),
              ),
              child: const Text("导入"),
            )),
        Flexible(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // 调整圆角的半径
                ),
              ),
              child: const Text("新建"),
            ))
      ],
    );
  }

  Widget _buildSubscribeItemList() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.9,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 120,
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: serverNodeList.length, // 你想要显示的 TextField 数量
        itemBuilder: (BuildContext context, int index) {
          return _builSubscribeItem(serverNodeList[index]);
        },
      ),
    );
  }

  Widget _builSubscribeItem(ServerNode serverNode) {
    return ElevatedButton(
      onPressed: () {
        for (var sn in serverNodeList) {
          sn.active = false;
        }
        setState(() {
          serverNode.active = !serverNode.active;
        });
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: serverNode.active
            ? Theme.of(context).primaryColor
            : Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // 调整圆角的半径
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(serverNode.serverName),
                    IconButton(onPressed: () {}, icon: Icon(Icons.refresh))
                  ],
                )),
            Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(serverNode.serverUrl),
                  ],
                )),
            Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "${serverNode.currentTraffic} / ${serverNode.totalTraffic}gb"),
                    Text(serverNode.updateTime)
                  ],
                )),
            Flexible(
                child: LinearProgressIndicator(
              value: serverNode.currentTraffic / serverNode.totalTraffic,
            ))
          ],
        ),
      ).animate(delay: const Duration(microseconds: 500)).fade(),
    );
  }
}

class _NodeView extends StatefulWidget {
  const _NodeView({super.key});

  @override
  State<_NodeView> createState() => __NodeViewState();
}

class __NodeViewState extends State<_NodeView> {
  List<String> labelList = ["全局", "规则", "直连"];
  int currentIndex = 0;
  List<ProxyNode> proxyNodeList = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 100; i++) {
      proxyNodeList.add(ProxyNode("新加波-Vess-1", "www.example.com", "2.2.2.2"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          _buildSelectGroup(),
          const SizedBox(
            height: 10,
          ),
          _buildChooseItem(),
          const SizedBox(
            height: 10,
          ),
          _buildNodeList(),
        ],
      ),
    );
  }

  Widget _buildSelectGroup() {
    return Row(
      children: List.generate(
          labelList.length,
          (index) => RadiuoButton(
              onPressed: () {
                setState(() {
                  currentIndex = index;
                });
              },
              label: labelList[index],
              index: index,
              currentIndex: currentIndex)),
    );
  }

  Widget _buildChooseItem() {
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.disc_full)),
        IconButton(onPressed: () {}, icon: Icon(Icons.scanner)),
        IconButton(onPressed: () {}, icon: Icon(Icons.traffic)),
        Expanded(child: SearchField())
      ],
    );
  }

  Widget _buildNodeList() {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      height: MediaQuery.sizeOf(context).height * 0.9,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 80,
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: proxyNodeList.length, // 你想要显示的 TextField 数量
        itemBuilder: (BuildContext context, int index) {
          return _buildPorxyNodeItem(proxyNodeList[index]);
        },
      ),
    );
  }

  Widget _buildPorxyNodeItem(ProxyNode proxyNode) {
    return ElevatedButton(
      onPressed: () {
        for (var sn in proxyNodeList) {
          sn.active = false;
        }
        setState(() {
          proxyNode.active = !proxyNode.active;
        });
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        backgroundColor: proxyNode.active
            ? Theme.of(context).primaryColor
            : Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // 调整圆角的半径
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Text(proxyNode.nodeName),
              ],
            ),
            Row(
              children: [
                Text(proxyNode.hostName),
                Expanded(child: Container()),
                const Icon(Icons.wifi),
                Text("${proxyNode.delay}ms"),
              ],
            ),
            Row(
              children: [
                Text(proxyNode.ip),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ShortcutView extends StatefulWidget {
  const _ShortcutView({super.key});

  @override
  State<_ShortcutView> createState() => __ShortcutViewState();
}

class __ShortcutViewState extends State<_ShortcutView> {
  List<Shortcut> shortcutList = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 100; i++) {
      shortcutList.add(Shortcut("Github", "www.github.com"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          _buildTopHeadher(),
          const SizedBox(
            height: 10,
          ),
          _buildShortCutList()
        ],
      ),
    );
  }

  Widget _buildTopHeadher() {
    return Row(
      children: [
        RadiuoButton(
          onPressed: () {},
          index: 0,
          currentIndex: 0,
          label: "扫描",
        ),
        const SizedBox(
          width: 10,
        ),
        RadiuoButton(
          onPressed: () {},
          index: 0,
          currentIndex: 0,
          label: "添加",
        )
      ],
    );
  }

  Widget _buildShortCutList() {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      height: MediaQuery.sizeOf(context).height * 0.9,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 150,
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: shortcutList.length, // 你想要显示的 TextField 数量
        itemBuilder: (BuildContext context, int index) {
          return _buildShortcutItem(shortcutList[index]);
        },
      ),
    );
  }

  Widget _buildShortcutItem(Shortcut shortcut) {
    return GestureDetector(
        child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).cardColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(flex: 8, child: Icon(shortcut.scIcon)),
                Expanded(
                  child: Container(),
                ),
                Flexible(flex: 2, child: Text(shortcut.scName)),
                const Flexible(
                  flex: 1,
                  child: Divider(
                    height: 2,
                  ),
                ),
                Flexible(
                    flex: 2,
                    child: TextButton(
                        onPressed: () {}, child: Text("${shortcut.delay}ms")))
              ],
            )));
  }
}

class _ConnectionView extends StatefulWidget {
  const _ConnectionView({super.key});

  @override
  State<_ConnectionView> createState() => __ConnectionViewState();
}

class __ConnectionViewState extends State<_ConnectionView> {
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopInput(),
          const SizedBox(
            height: 10,
          ),
          _buildConnectionList(),
        ],
      ),
    );
  }

  Widget _buildTopInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(flex: 7, child: SearchField()),
        Flexible(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // 调整圆角的半径
                ),
              ),
              child: const Icon(Icons.scanner),
            )),
        Flexible(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // 调整圆角的半径
                ),
              ),
              child: const Text("关闭全部"),
            ))
      ],
    );
  }

  Widget _buildConnectionList() {
    List<Connection> connectionList = [];
    for (var i = 0; i < 100; i++) {
      connectionList.add(Connection("www.example.com", "1", "1"));
    }
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.9,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 30,
          crossAxisCount: 1,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: connectionList.length, // 你想要显示的 TextField 数量
        itemBuilder: (BuildContext context, int index) {
          return _builConnectionItem(connectionList[index]);
        },
      ),
    );
  }

  Widget _builConnectionItem(Connection connection) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
          backgroundColor: Theme.of(context).cardColor),
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 5,
              child: Text(
                connection.host,
              ),
            ),
            Flexible(flex: 5, child: Text(connection.host)),
            Flexible(flex: 5, child: Text(connection.host))
          ],
        ),
      ),
    );
  }
}

class _RuleView extends StatefulWidget {
  const _RuleView({super.key});

  @override
  State<_RuleView> createState() => __RuleViewState();
}

class __RuleViewState extends State<_RuleView> {
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopInput(),
          const SizedBox(
            height: 10,
          ),
          _buildConnectionList(),
        ],
      ),
    );
  }

  Widget _buildTopInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(flex: 7, child: SearchField()),
        Flexible(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // 调整圆角的半径
                ),
              ),
              child: const Icon(Icons.scanner),
            )),
        Flexible(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // 调整圆角的半径
                ),
              ),
              child: const Text("关闭全部"),
            ))
      ],
    );
  }

  Widget _buildConnectionList() {
    List<Connection> connectionList = [];
    for (var i = 0; i < 100; i++) {
      connectionList.add(Connection("www.example.com", "1", "1"));
    }
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.9,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 30,
          crossAxisCount: 1,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: connectionList.length, // 你想要显示的 TextField 数量
        itemBuilder: (BuildContext context, int index) {
          return _builConnectionItem(connectionList[index]);
        },
      ),
    );
  }

  Widget _builConnectionItem(Connection connection) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
          backgroundColor: Theme.of(context).cardColor),
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 5,
              child: Text(
                connection.host,
              ),
            ),
            Flexible(flex: 5, child: Text(connection.host)),
            Flexible(flex: 5, child: Text(connection.host))
          ],
        ),
      ),
    );
  }
}

class _LogView extends StatefulWidget {
  const _LogView({super.key});

  @override
  State<_LogView> createState() => __LogViewState();
}

class __LogViewState extends State<_LogView> {
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopInput(),
          const SizedBox(
            height: 10,
          ),
          _buildConnectionList(),
        ],
      ),
    );
  }

  Widget _buildTopInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(flex: 7, child: SearchField()),
        Flexible(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // 调整圆角的半径
                ),
              ),
              child: const Icon(Icons.scanner),
            )),
        Flexible(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // 调整圆角的半径
                ),
              ),
              child: const Text("关闭全部"),
            ))
      ],
    );
  }

  Widget _buildConnectionList() {
    List<Connection> connectionList = [];
    for (var i = 0; i < 100; i++) {
      connectionList.add(Connection("www.example.com", "1", "1"));
    }
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.9,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 30,
          crossAxisCount: 1,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: connectionList.length, // 你想要显示的 TextField 数量
        itemBuilder: (BuildContext context, int index) {
          return _builConnectionItem(connectionList[index]);
        },
      ),
    );
  }

  Widget _builConnectionItem(Connection connection) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
          backgroundColor: Theme.of(context).cardColor),
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 5,
              child: Text(
                connection.host,
              ),
            ),
            Flexible(flex: 5, child: Text(connection.host)),
            Flexible(flex: 5, child: Text(connection.host))
          ],
        ),
      ),
    );
  }
}

class _SettingView extends StatefulWidget {
  const _SettingView({super.key});

  @override
  State<_SettingView> createState() => __SettingViewState();
}

class __SettingViewState extends State<_SettingView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("setting"),
    );
  }
}
