import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lethologica_app/features/home/home.dart';
import 'package:lethologica_app/gen/fonts.gen.dart';
import 'package:lethologica_theme/lethologica_theme.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _searchController = TextEditingController();
  final _loadingNotifier = SearchLoadingNotifier();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (previous, current) => previous.query != current.query,
      listener: (context, state) async {
        if (state.query.isEmpty) {
          _searchController.clear();
          FocusScope.of(context).unfocus();
        }
        switch (state.query.status) {
          case HomeQueryStatus.idle:
            _loadingNotifier.stop();
          case HomeQueryStatus.loading:
            _loadingNotifier.start();
          case HomeQueryStatus.queried:
            await context
                .push('/definition', extra: state.query.word)
                .then((value) => context.read<HomeCubit>().queryCleared());
          case HomeQueryStatus.error:
          // TODO: Handle this case.
        }
      },
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: _BottomAppBar(),
          floatingActionButton: state.query.isTyping
              ? FloatingActionButton(
                  backgroundColor: state.visibleVocabulary.isNotEmpty
                      ? context.colorScheme.secondaryContainer
                      : null,
                  onPressed: () => context.read<HomeCubit>().search(),
                  child: const Icon(Icons.search),
                )
              : null,
          body: SafeArea(
            child: Column(
              children: [
                _SearchBar(
                  state: state,
                  searchController: _searchController,
                  loadingNotifier: _loadingNotifier,
                ),
                _Vocabulary(state: state),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: EdgeInsets.symmetric(horizontal: once),
      height: 60,
      child: Row(
        children: [
          Text(
            'Lethologica',
            style: context.textTheme.headlineMedium!
                .copyWith(fontFamily: FontFamily.cookie),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => context.push('/settings'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.state,
    required TextEditingController searchController,
    required SearchLoadingNotifier loadingNotifier,
  })  : _searchController = searchController,
        _loadingNotifier = loadingNotifier;

  final HomeState state;
  final TextEditingController _searchController;
  final SearchLoadingNotifier _loadingNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(once),
      child: SearchBar(
        controller: _searchController,
        hintText: 'Search',
        textInputAction: TextInputAction.search,
        leading: SearchLoading(
          onPressed: () {},
          notifier: _loadingNotifier,
        ),
        trailing: [
          if (!state.query.isEmpty)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => context.read<HomeCubit>().queryCleared(),
            ),
        ],
        onChanged: (value) => context.read<HomeCubit>().queryChanged(value),
        onSubmitted: (value) => context.read<HomeCubit>().search(),
      ),
    );
  }
}

class _Vocabulary extends StatelessWidget {
  const _Vocabulary({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: state.visibleVocabulary.isEmpty && state.query.isTyping
          ? const Text(
              'Could not find in vocabulary? Try looking it up.',
              style: TextStyle(color: Colors.grey),
            )
          : ListView.builder(
              itemCount: state.visibleVocabulary.length,
              itemBuilder: (context, index) {
                final word = state.visibleVocabulary[index];
                return WordWidget(
                  word: word,
                  onDismissed: () => context.read<HomeCubit>().delete(word),
                );
              },
            ),
    );
  }
}
