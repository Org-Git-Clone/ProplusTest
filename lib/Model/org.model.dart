class OrganizationModel {
  final String login;
  final int id;
  final String nodeId;
  final String url;
  final String reposUrl;
  final String eventsUrl;
  final String hooksUrl;
  final String issuesUrl;
  final String membersUrl;
  final String publicMembersUrl;
  final String avatarUrl;
  final String? description;

  var name;

  OrganizationModel({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.url,
    required this.reposUrl,
    required this.eventsUrl,
    required this.hooksUrl,
    required this.issuesUrl,
    required this.membersUrl,
    required this.publicMembersUrl,
    required this.avatarUrl,
    this.description,
  });

  // Factory method to create an instance from JSON
  factory OrganizationModel.fromJson(Map<String, dynamic> json) {
    return OrganizationModel(
      login: json['login'],
      id: json['id'],
      nodeId: json['node_id'],
      url: json['url'],
      reposUrl: json['repos_url'],
      eventsUrl: json['events_url'],
      hooksUrl: json['hooks_url'],
      issuesUrl: json['issues_url'],
      membersUrl: json['members_url'],
      publicMembersUrl: json['public_members_url'],
      avatarUrl: json['avatar_url'],
      description: json['description'],
    );
  }

  // Method to convert the model instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'id': id,
      'node_id': nodeId,
      'url': url,
      'repos_url': reposUrl,
      'events_url': eventsUrl,
      'hooks_url': hooksUrl,
      'issues_url': issuesUrl,
      'members_url': membersUrl,
      'public_members_url': publicMembersUrl,
      'avatar_url': avatarUrl,
      'description': description,
    };
  }
}
