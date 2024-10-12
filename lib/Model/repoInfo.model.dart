// ----------------------------Branch Model Start--------------------
class Branch {
  final String name;
  final Commit commit;
  final bool isProtected;

  Branch({
    required this.name,
    required this.commit,
    required this.isProtected,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      name: json['name'],
      commit: Commit.fromJson(json['commit']),
      isProtected: json['protected'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'commit': commit.toJson(),
      'protected': isProtected,
    };
  }
}

class Commit {
  final String sha;
  final String url;

  Commit({
    required this.sha,
    required this.url,
  });

  factory Commit.fromJson(Map<String, dynamic> json) {
    return Commit(
      sha: json['sha'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sha': sha,
      'url': url,
    };
  }
}

// ----------------------------Branch Model End--------------------


