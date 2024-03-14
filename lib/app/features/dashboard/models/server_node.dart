class ServerNode {
  final String serverName;
  final String serverUrl;
  final String updateTime;
  final double currentTraffic;
  final double totalTraffic;
  bool active = false;
  ServerNode(this.serverName, this.serverUrl, this.updateTime,
      this.currentTraffic, this.totalTraffic);
}
