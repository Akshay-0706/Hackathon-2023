import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../backend/news/api.dart';
import '../../../backend/news/model.dart';
import '../../../size.dart';

class NewsBody extends StatefulWidget {
  const NewsBody({super.key});

  @override
  State<NewsBody> createState() => _NewsBodyState();
}

class _NewsBodyState extends State<NewsBody> {
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
    Pallete pallete = Pallete(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 2,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: getWidth(34),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: getWidth(24),
                ),
              ),
            ),
          ),
          title: Text(
            "Blogs & Resources",
            style: TextStyle(
              color: pallete.primaryDark(),
              fontSize: getWidth(20),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            news == null
                ? Column(
                    children: [
                      const SizedBox(height: 300),
                      Center(
                          child: CircularProgressIndicator(
                        color: pallete.primary(),
                      )),
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
    Pallete pallete = Pallete(context);
    // Card to show news data
    return InkWell(
      onTap: () {
        if (widget.article.url != null) {
          launchUrl(Uri.parse(widget.article.url!));
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: pallete.primaryDark()),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: widget.article.urlToImage ?? '',
                  errorWidget: (context, error, stackTrace) =>
                      CachedNetworkImage(
                    imageUrl:
                        'https://www.dailyexcelsior.com/wp-content/uploads/2023/01/Eco-friendly.jpg',
                    width: double.infinity,
                    height: getHeight(200),
                    fit: BoxFit.cover,
                  ),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: getHeight(200),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.article.title!,
                      style: TextStyle(
                        fontSize: getWidth(16),
                        fontWeight: FontWeight.w400,
                        color: pallete.primaryDark(),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Text(
                widget.article.content!,
                style: TextStyle(
                  fontSize: getWidth(10),
                  fontWeight: FontWeight.w400,
                  color: pallete.primaryLight().withOpacity(0.7),
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
