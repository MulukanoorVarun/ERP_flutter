class VersionsResponse {
  String? latestVersion;
  int? latestVersionCode;
  String? url;
  String? releaseNotes;

  VersionsResponse(
      {this.latestVersion,
        this.latestVersionCode,
        this.url,
        this.releaseNotes});

  VersionsResponse.fromJson(Map<String, dynamic> json) {
    latestVersion = json['latestVersion'];
    latestVersionCode = json['latestVersionCode'];
    url = json['url'];
    releaseNotes = json['releaseNotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latestVersion'] = this.latestVersion;
    data['latestVersionCode'] = this.latestVersionCode;
    data['url'] = this.url;
    data['releaseNotes'] = this.releaseNotes;
    return data;
  }
}
