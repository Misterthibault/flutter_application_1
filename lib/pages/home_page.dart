import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/tweet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedNavigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: const Padding(
            // ajoute une photo de profil CIRCULAIRE
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
          title: Image.asset('asset/logo_X.jpg', height: 30),
          backgroundColor: Colors.black,
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pour vous'),
              Tab(text: 'Abonnements'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _TweetFeed(),
            // _TweetFeed(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedNavigationIndex,
          onTap: (index) {
            setState(() => _selectedNavigationIndex = index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Recherche',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Profil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: 'Messages',
            ),
          ],
        ),
      ),
    );
  }
}

class _TweetFeed extends StatelessWidget {
  const _TweetFeed();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Tweet.sampleTweets.length,
      itemBuilder: (context, index) =>
          _TweetCard(tweet: Tweet.sampleTweets[index]),
    );
  }
}

class _TweetCard extends StatelessWidget {
  const _TweetCard({required this.tweet});

  final Tweet tweet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white24,
            child: ClipOval(
              child: Image.network(
                tweet.profilePictureUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        tweet.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (tweet.verified)
                      const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Icon(
                          Icons.verified,
                          color: Color.fromARGB(255, 125, 125, 125),
                          size: 16,
                        ),
                      ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        '${tweet.handle} · ${tweet.time}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white60),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  tweet.content,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _TweetMetric(
                      icon: Icons.chat_bubble_outline,
                      value: tweet.comments,
                    ),
                    _TweetMetric(icon: Icons.repeat, value: tweet.retweets),
                    _TweetMetric(
                      icon: Icons.favorite_border,
                      value: tweet.likes,
                    ),
                    _TweetMetric(icon: Icons.bar_chart, value: tweet.views),
                  ],
                ),
              ],
            ),
          ), // espacer en prenant tout l'espace disponible
        ],
      ),
    );
  }
}

class _TweetMetric extends StatelessWidget {
  const _TweetMetric({required this.icon, required this.value});

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color.fromARGB(153, 180, 180, 180)),  //symbole en dessous d'un tweet
        const SizedBox(width: 10),
        Text(
          value,
          style: const TextStyle(color: Color.fromARGB(153, 180, 180, 180), fontSize: 12), // chiffre après les symbole
        ),
      ],
    );
  }
}
