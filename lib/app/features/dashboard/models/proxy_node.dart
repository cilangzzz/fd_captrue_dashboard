class ProxyNode {
  final String nodeName;
  final String hostName;
  final String ip;
  String delay = "999";
  bool active = false;

  ProxyNode(this.nodeName, this.hostName, this.ip);
}
