import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String picture;

  final String title;
  final String subtitle;

  final VoidCallback onPictureTap;
  final VoidCallback onPictureLongPress;

  final VoidCallback onTitleTap;
  final VoidCallback onSubtitleTap;

  final List<Widget> items;
  final Widget content;

  ProfilePage({
    this.picture,
    @required this.title,
    this.subtitle,
    this.onPictureTap,
    this.onPictureLongPress,
    this.onTitleTap,
    this.onSubtitleTap,
    this.content,
    this.items,
  }) : assert((items != null && content == null) ||
            (content != null && items == null));

  Widget _text(
    String text,
    TextStyle style,
    VoidCallback onTap, {
    int maxLines = 1,
  }) =>
      Tooltip(
        message: text,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(4.0),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 1.0,
              ),
              child: Text(
                text,
                maxLines: maxLines,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                softWrap: false,
                style: style,
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColorLight,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 32.0),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.44,
                    height: MediaQuery.of(context).size.width * 0.44,
                    decoration: picture != null
                        ? BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(picture),
                              fit: BoxFit.cover,
                            ),
                          )
                        : BoxDecoration(),
                    child: Material(
                      color: Colors.transparent,
                      shape: CircleBorder(),
                      child: InkWell(
                        customBorder: CircleBorder(),
                        onTap: this.onPictureTap,
                        onLongPress: this.onPictureLongPress,
                        child: Container(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                _text(
                  title,
                  Theme.of(context).textTheme.subtitle1,
                  onTitleTap,
                ),
                if (subtitle != null) const SizedBox(height: 2.0),
                if (subtitle != null)
                  _text(
                    subtitle,
                    Theme.of(context).textTheme.subtitle2,
                    onSubtitleTap,
                    maxLines: 2,
                  ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
          Expanded(
            child: items != null
                ? SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 32.0,
                    ),
                    child: Column(
                      children: items,
                    ),
                  )
                : content,
          ),
        ],
      );
}
