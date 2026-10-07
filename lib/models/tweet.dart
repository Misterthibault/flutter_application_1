class Tweet {
  const Tweet({
    required this.name,
    required this.handle,
    required this.verified,
    required this.time,
    required this.content,
    required this.comments,
    required this.retweets,
    required this.likes,
    required this.views,
    required this.profilePictureUrl,
  });

  final String name;
  final String handle;
  final bool verified;
  final String time;
  final String content;
  final String comments;
  final String retweets;
  final String likes;
  final String views;
  final String profilePictureUrl;

  static final List<Tweet> sampleTweets = [
    const Tweet(
      name: 'axel Martin',
      handle: '@alexmartin',
      verified: true,
      time: '2 h',
      content:
          'Hac spiritus cuncta in sane pacari sane est raris diversis praedatricibus sunt inrequietis audaciam ex erigentes diversis peius saepe bella.',
      comments: '12',
      retweets: '24',
      likes: '186',
      views: '3.4K',
      profilePictureUrl: 'https://i.pravatar.cc/100?img=33',
    ),
    const Tweet(
      name: 'Camille Dupont',
      handle: '@camille_dev',
      verified: false,
      time: '4 h',
      content:
          'Hac spiritus cuncta in sane pacari sane est raris diversis praedatricibus sunt inrequietis audaciam ex erigentes diversis peius saepe bella.',
      comments: '8',
      retweets: '17',
      likes: '92',
      views: '1.2K',
      profilePictureUrl: 'https://i.pravatar.cc/100?img=33',
    ),
    const Tweet(
      name: 'Tech & Découvertes',
      handle: '@techdecouvertes',
      verified: true,
      time: '6 h',
      content:
          'Cum tutela in alacriter consurgentem qui hastisque occurrere habitus parans.',
      comments: '36',
      retweets: '51',
      likes: '728',
      views: '18K',
      profilePictureUrl: 'https://i.pravatar.cc/100?img=33',
    ),
  ];
}
