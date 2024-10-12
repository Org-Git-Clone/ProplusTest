class CommitInfo {
  final String sha;
  final String nodeId;
  final Commit commit;
  final String url;
  final String htmlUrl;
  final String commentsUrl;
  final User author;
  final User committer;
  final List<Parent> parents;

  CommitInfo({
    required this.sha,
    required this.nodeId,
    required this.commit,
    required this.url,
    required this.htmlUrl,
    required this.commentsUrl,
    required this.author,
    required this.committer,
    required this.parents,
  });

  factory CommitInfo.fromJson(Map<String, dynamic> json) {
    return CommitInfo(
      sha: json['sha'],
      nodeId: json['node_id'],
      commit: Commit.fromJson(json['commit']),
      url: json['url'],
      htmlUrl: json['html_url'],
      commentsUrl: json['comments_url'],
      author: User.fromJson(json['author']),
      committer: User.fromJson(json['committer']),
      parents: (json['parents'] as List)
          .map((parent) => Parent.fromJson(parent))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sha': sha,
      'node_id': nodeId,
      'commit': commit.toJson(),
      'url': url,
      'html_url': htmlUrl,
      'comments_url': commentsUrl,
      'author': author.toJson(),
      'committer': committer.toJson(),
      'parents': parents.map((parent) => parent.toJson()).toList(),
    };
  }
}

class Commit {
  final Author author;
  final Author committer;
  final String message;
  final Tree tree;
  final String url;
  final int commentCount;
  final Verification verification;

  Commit({
    required this.author,
    required this.committer,
    required this.message,
    required this.tree,
    required this.url,
    required this.commentCount,
    required this.verification,
  });

  factory Commit.fromJson(Map<String, dynamic> json) {
    return Commit(
      author: Author.fromJson(json['author']),
      committer: Author.fromJson(json['committer']),
      message: json['message'],
      tree: Tree.fromJson(json['tree']),
      url: json['url'],
      commentCount: json['comment_count'],
      verification: Verification.fromJson(json['verification']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author.toJson(),
      'committer': committer.toJson(),
      'message': message,
      'tree': tree.toJson(),
      'url': url,
      'comment_count': commentCount,
      'verification': verification.toJson(),
    };
  }
}

class Author {
  final String name;
  final String email;
  final String date;

  Author({
    required this.name,
    required this.email,
    required this.date,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'],
      email: json['email'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'date': date,
    };
  }
}

class Tree {
  final String sha;
  final String url;

  Tree({
    required this.sha,
    required this.url,
  });

  factory Tree.fromJson(Map<String, dynamic> json) {
    return Tree(
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

class Verification {
  final bool verified;
  final String reason;
  final String? signature;
  final String? payload;

  Verification({
    required this.verified,
    required this.reason,
    this.signature,
    this.payload,
  });

  factory Verification.fromJson(Map<String, dynamic> json) {
    return Verification(
      verified: json['verified'],
      reason: json['reason'],
      signature: json['signature'],
      payload: json['payload'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'verified': verified,
      'reason': reason,
      'signature': signature,
      'payload': payload,
    };
  }
}

class User {
  final String login;
  final int id;
  final String nodeId;
  final String avatarUrl;
  final String url;
  final String htmlUrl;
  final bool siteAdmin;

  User({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.url,
    required this.htmlUrl,
    required this.siteAdmin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      id: json['id'],
      nodeId: json['node_id'],
      avatarUrl: json['avatar_url'],
      url: json['url'],
      htmlUrl: json['html_url'],
      siteAdmin: json['site_admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'id': id,
      'node_id': nodeId,
      'avatar_url': avatarUrl,
      'url': url,
      'html_url': htmlUrl,
      'site_admin': siteAdmin,
    };
  }
}

class Parent {
  final String sha;
  final String url;
  final String htmlUrl;

  Parent({
    required this.sha,
    required this.url,
    required this.htmlUrl,
  });

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      sha: json['sha'],
      url: json['url'],
      htmlUrl: json['html_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sha': sha,
      'url': url,
      'html_url': htmlUrl,
    };
  }
}
