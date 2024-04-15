class VersionsResponse {
  String? latestVersion;
  int? latestVersionCode;
  String? url;
  String? releaseNotes;
  String? iosLatestVersion;
  int? iosLatestVersionCode;
  String? iosUrl;
  String? iosReleaseNotes;

  VersionsResponse(
      {this.latestVersion,
      this.latestVersionCode,
      this.url,
      this.releaseNotes,
      this.iosLatestVersion,
      this.iosLatestVersionCode,
      this.iosUrl,
      this.iosReleaseNotes});

  VersionsResponse.fromJson(Map<String, dynamic> json) {
    latestVersion = json['latestVersion'];
    latestVersionCode = json['latestVersionCode'];
    url = json['url'];
    releaseNotes = json['releaseNotes'];
    iosLatestVersion = json['ios_latestVersion'];
    iosLatestVersionCode = json['ios_latestVersionCode'];
    iosUrl = json['ios_url'];
    iosReleaseNotes = json['ios_releaseNotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latestVersion'] = this.latestVersion;
    data['latestVersionCode'] = this.latestVersionCode;
    data['url'] = this.url;
    data['releaseNotes'] = this.releaseNotes;
    data['ios_latestVersion'] = this.iosLatestVersion;
    data['ios_latestVersionCode'] = this.iosLatestVersionCode;
    data['ios_url'] = this.iosUrl;
    data['ios_releaseNotes'] = this.iosReleaseNotes;
    return data;
  }
}
