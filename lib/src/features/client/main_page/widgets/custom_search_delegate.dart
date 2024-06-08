import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sapar/src/core/resources/resources.dart';
import 'package:sapar/src/features/app/router/app_router.dart';
import 'package:sapar/src/features/auth/model/place_dto.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<PlaceDTO> places;
  final List<String> searchHistory;
  final VoidCallback onClearHistory;

  CustomSearchDelegate(
    this.places,
    this.searchHistory, {
    required this.onClearHistory,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
          color: AppColors.kMainGreen,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: AppColors.kMainGreen),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final String trimmedQuery = query.trim().toLowerCase();
    if (trimmedQuery.isEmpty) {
      return const Center(
        child: Text(
          'No results found',
          style: TextStyle(color: AppColors.kMainGreen),
        ),
      );
    }
    final List<PlaceDTO> searchResults = places
        .where((item) => item.name.toLowerCase().contains(trimmedQuery))
        .toList();
    // Add the search query to history if it's not already there
    if (!searchHistory.contains(trimmedQuery) && trimmedQuery.isNotEmpty) {
      searchHistory.add(trimmedQuery);
    }
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index].name),
          onTap: () {
            close(context, searchResults[index].name);
            context.router.push(ProductRoute(place: searchResults[index]));
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final String trimmedQuery = query.trim().toLowerCase();
    if (trimmedQuery.isEmpty) {
      return Column(
        children: [
          if (searchHistory.isNotEmpty)
            ListTile(
              title: const Text(
                'Clear History',
                style: TextStyle(color: AppColors.kMainGreen),
              ),
              onTap: onClearHistory,
            ),
          Expanded(
            child: ListView.builder(
              itemCount: searchHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading:
                      const Icon(Icons.history, color: AppColors.kMainGreen),
                  title: Text(searchHistory[index]),
                  onTap: () {
                    query = searchHistory[index];
                    showResults(context);
                  },
                );
              },
            ),
          ),
        ],
      );
    }
    final List<PlaceDTO> suggestionList = places
        .where((item) => item.name.toLowerCase().contains(trimmedQuery))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index].name),
          onTap: () {
            query = suggestionList[index].name;
            showResults(context);
          },
        );
      },
    );
  }
}
