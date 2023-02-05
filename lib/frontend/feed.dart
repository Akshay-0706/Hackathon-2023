import 'package:flutter/material.dart';
import 'package:hackathon/backend/Api/news_api.dart';
import 'package:hackathon/frontend/models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  NewsData? news;

  @override
  void initState() {
    NewsApi.getNews().then((value) {
      setState(() {
        news = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Feed'),
          centerTitle: true,
          backgroundColor: Color(0xff1a5f7a),
          elevation: 5,
          // arrow back ios
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            // IconButton(
            //   icon: const Icon(Icons.search),
            //   onPressed: () {},
            // ),
          ],
        ),
        backgroundColor: Color(0xff1a5f7a),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            news == null
                ? Column(
                    children: [
                      SizedBox(
                        height: 300,
                      ),
                      Center(child: CircularProgressIndicator()),
                    ],
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: PostWidget(news!.articles![index]),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class PostWidget extends StatefulWidget {
  const PostWidget(this.article, {super.key});

  final Articles article;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    // Card to show news data
    return InkWell(
      onTap: () {
        if (widget.article.url != null) {
          launchUrl(Uri.parse(widget.article.url!));
        }
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.article.urlToImage ?? '',
                  errorBuilder: (context, error, stackTrace) => Image.network(
                    'https://www.dailyexcelsior.com/wp-content/uploads/2023/01/Eco-friendly.jpg',
                    height: 210,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 210,
                ),
              ),
              SizedBox(
                height: 13,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.article.title!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: isLiked ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                  ),
                ],
              ),

              Text(
                widget.article.content!,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff798395),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),

              // Text(
              //   'Author',
              //   style: TextStyle(
              //     fontSize: 15,
              //   ),
              // ),

              // // Published At
              // Text(
              //   'Published At',
              //   style: TextStyle(
              //     fontSize: 15,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
