import 'package:ebook/services/favorite/favorite_service.dart';
import 'package:ebook/state_management/favorite/favorite_bloc.dart';
import 'package:ebook/ui/custom_widgets/custom_widgets.dart';
import 'package:ebook/ui/custom_widgets/loading/favorite_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
      ),
      body: RepositoryProvider<FavoriteService>(
        create: (context) => FavoriteService(),
        child: BlocProvider<FavoriteBloc>(
          create: (context) =>
              FavoriteBloc(favoriteService: context.read<FavoriteService>())
                ..add(LoadFavoriteEvent()),
          child: Builder(builder: (context) {
            return BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
              if (state is FavoriteLoadingState) {
                return const FavoriteLoading();
              }
              if (state is FavoriteErrorState) {
                return RefreshIndicator(
                    onRefresh: () async {
                      context.read<FavoriteBloc>().add(RefreshFavoriteEvent());
                    },
                    child: Center(
                      child: ListView(
                          padding: const EdgeInsets.all(20.0),
                          children: const [
                            Center(child: Text('Opps! Try again later!'))
                          ]),
                    ));
              }
              if (state is FavoriteLoadedState) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<FavoriteBloc>().add(RefreshFavoriteEvent());
                  },
                  child: state.listBooksFavorite.isEmpty
                      ? ListView(
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      (MediaQuery.of(context).size.height / 4)),
                              child: const CustomEmptyPage(
                                  icon: Icons.article,
                                  message: 'No Favorite',
                                  message1: 'Browse Books'),
                            )
                          ],
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(15),
                          itemCount: state.listBooksFavorite.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CustomFavoriteCard(
                                dataFavoriteBook:
                                    state.listBooksFavorite[index]);
                          },
                        ),
                );
              } else {
                return const Center(
                  child: Text("Opps! Something Went Wrong outside the state!"),
                );
              }
            });
          }),
        ),
      ),
    );
  }
}
