import 'package:cinema_booking/domain/entities/film.dart';
import 'package:cinema_booking/domain/entities/films_session.dart';
import 'package:cinema_booking/view/model/bloc.dart';
import 'package:cinema_booking/view/model/events_bloc.dart';
import 'package:cinema_booking/view/model/states_bloc.dart';
import 'package:cinema_booking/view/pages/films/session_wiev_page.dart';
import 'package:cinema_booking/view/themes/ui_components/films/comment_add_form.dart';
import 'package:cinema_booking/view/themes/ui_components/films/comments_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_share/social_share.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FilmInfo extends StatelessWidget {
  final Film film;
  final String stringDate;

  const FilmInfo({Key? key, required this.film, required this.stringDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: GridTile(
                header: Container(
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Theme.of(context).colorScheme.background
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                                margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Icon(Icons.arrow_back, size: 30)),
                          ),
                          Text(
                            'About Film',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          InkWell(
                            onTap: () => context
                                .read<AppAuthBloc>()
                                .add(AddRemoveFavoriteEvent(filmId: film.id)),
                            child: Container(
                              margin: const EdgeInsets.only(top: 5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: BlocBuilder<AppAuthBloc, AppState>(
                                  builder: (context, state) {
                                return Icon(
                                  Icons.favorite,
                                  color: state.favoriteMovies.contains(film.id)
                                      ? const Color(0xFFffca37)
                                      : null,
                                  size: 30,
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                footer: Container(
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.transparent,
                      Theme.of(context).colorScheme.background
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          film.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '${film.year} | ${film.genre} | ${film.language} | ${film.stringDuration}',
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xFFffca37),
                            ),
                            Text(
                              '${film.rating} | ${film.age}+',
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                child: Image.network(
                  film.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            YouTubeTrailer(link: film.trailer),
            const SizedBox(
              height: 10,
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width / 2,
            //   decoration: BoxDecoration(
            //       color: Colors.white.withOpacity(0.7),
            //       borderRadius: BorderRadius.circular(15)),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       InkWell(
            //         onTap: () => SocialShare.shareTwitter(
            //             'Check out ${film.name}, here is trailer: ${film.trailer}'),
            //         child: const Icon(
            //           FontAwesomeIcons.twitter,
            //           color: Color(0xFF1DA1F2),
            //           size: 40,
            //         ),
            //       ),
            //       InkWell(
            //         onTap: () => SocialShare.shareOptions(
            //             'Check out ${film.name}, here is trailer: ${film.trailer}'),
            //         child: const GradientIcon(
            //           icon: FontAwesomeIcons.instagram,
            //           size: 40,
            //           gradient: LinearGradient(
            //             begin: Alignment.topRight,
            //             end: Alignment.bottomRight,
            //             colors: [
            //               Colors.purple,
            //               Colors.pink,
            //               Colors.orange,
            //             ],
            //           ),
            //         ),
            //       ),
            //       InkWell(
            //         onTap: () => SocialShare.shareTelegram(
            //             'Check out ${film.name}, here is trailer: ${film.trailer}'),
            //         child: const Icon(
            //           Icons.telegram,
            //           color: Color(0xFF2AABEE),
            //           size: 40,
            //         ),
            //       ),
            //
            //       // Icon(FontAwesomeIcons.instagram, ),
            //     ],
            //   ),
            // ),
            InkWell(
              onTap: () => SocialShare.shareOptions(
                  'Check out ${film.name}, here is trailer: ${film.trailer}'),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Share',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Icon(FontAwesomeIcons.shareNodes),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                film.plot,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  textAlign: TextAlign.left,
                  'Cast: ${film.starring}\nCountry: ${film.country}\nDirector: ${film.director}\nScreenwriter: ${film.screenwriter}\n©${film.studio}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Available sessions:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future:
                  context.read<AppAuthBloc>().state.dioClient.getFilmSessions(
                        film.id,
                        stringDate,
                      ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SessionView(
                                  session: snapshot.data![index],
                                  filmName: film.name,
                                );
                              },
                            ),
                          ).then(
                            (value) => context.read<AppAuthBloc>().add(
                                  ClearSeatsEvent(),
                                ),
                          ),
                          child: SessionCard(session: snapshot.data![index]),
                        );
                      },
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Reviews:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            AddCommentWidget(filmId: film.id),
            CommentBlock(filmId: film.id),
          ],
        ),
      ),
    );
  }
}

class YouTubeTrailer extends StatefulWidget {
  const YouTubeTrailer({Key? key, required this.link}) : super(key: key);
  final String link;

  @override
  State<YouTubeTrailer> createState() => _YouTubeTrailerState();
}

class _YouTubeTrailerState extends State<YouTubeTrailer> {
  late YoutubePlayerController _controller;
  bool isMuted = true;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.link) ?? '',
      flags: const YoutubePlayerFlags(autoPlay: true, mute: true),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      bottomActions: [
        ProgressBar(
          isExpanded: true,
        ),
        InkWell(
          onTap: () {
            if (isMuted) {
              _controller.unMute();
              isMuted = false;
            } else {
              _controller.mute();
              isMuted = true;
            }
            setState(() {});
          },
          child: Icon(
            isMuted ? Icons.volume_up_rounded : Icons.volume_mute_rounded,
            size: 30,
          ),
        )
      ],
    );
  }
}

class SessionCard extends StatelessWidget {
  const SessionCard({Key? key, required this.session}) : super(key: key);
  final FilmSession session;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.primary),
        height: MediaQuery.of(context).size.height / 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              session.type,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              session.stringDate,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '\$${session.minPrice}',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ]
              .map<Widget>((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: e,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
