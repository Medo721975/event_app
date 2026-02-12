import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c17_fri/core/firebase_functions.dart';
import 'package:evently_c17_fri/providers/home_page_provider.dart';
import 'package:evently_c17_fri/screens/event_details/event_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  DateFormat formatter = DateFormat('dd MMM');
  static const Color _primaryNavy  = Color(0xFF1A237E);
  static const Color _chipWhite    = Color(0xFFFFFFFF);
  static const Color _borderColor  = Color(0xFFD6DAF0);
  static const Color _cardBg       = Color(0xFFF0F0F0);
  static const Map<String, IconData> _categoryIcons = {
    "All"        : Icons.grid_view_rounded,
    "eating"     : Icons.restaurant_outlined,
    "sport"      : Icons.directions_bike_outlined,
    "exhibition" : Icons.museum_outlined,
    "bookclub"   : Icons.menu_book_outlined,
    "birthday"   : Icons.cake_outlined,
    "gaming"     : Icons.sports_esports_outlined,
    "workshop"   : Icons.build_outlined,
    "meeting"    : Icons.groups_outlined,
    "holiday"    : Icons.beach_access_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageProvider()..getStreamTasks(),
      builder: (context, child) {
        var provider      = Provider.of<HomePageProvider>(context);
        var providerWatch = context.watch<HomePageProvider>();

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.categories.length,
                  separatorBuilder: (c, i) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final bool isSelected =
                        index == provider.selectedCategoryIndex;
                    final String cat = provider.categories[index];
                    final IconData icon =
                        _categoryIcons[cat] ?? Icons.event_outlined;

                    return GestureDetector(
                      onTap: () => provider.changeCategory(index),
                      child: Chip(
                        avatar: Icon(
                          icon,
                          size: 18,
                          color: isSelected ? Colors.white : _primaryNavy,
                        ),
                        label: Text(
                          cat[0].toUpperCase() + cat.substring(1),
                        ),
                        backgroundColor:
                        isSelected ? _primaryNavy : _chipWhite,
                        side: BorderSide(
                          color: isSelected ? _primaryNavy : _borderColor,
                          width: 1.2,
                        ),
                        labelStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : _primaryNavy,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 18),
              Expanded(
                child: provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : provider.errorMessage.isNotEmpty
                    ? Center(child: Text(provider.errorMessage))
                    : providerWatch.tasks.isEmpty
                    ? const Center(child: Text("No Tasks"))
                    : ListView.separated(
                  separatorBuilder: (context, index) =>
                  const SizedBox(height: 12),
                  itemCount: providerWatch.tasks.length,
                  itemBuilder: (context, index) {
                    final task = providerWatch.tasks[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          EventDetailScreen.routeName,
                          arguments: task,
                        );
                      },
                      child: SizedBox(
                        height: 210,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                              BorderRadius.circular(18),
                              child: Image.asset(
                                "assets/images/${task.category}.png",
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Container(
                                    padding:
                                    const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(
                                          18),
                                      color: _cardBg,
                                    ),
                                    child: Text(
                                      formatter.format(
                                        DateTime
                                            .fromMillisecondsSinceEpoch(
                                          task.date,
                                        ),
                                      ),
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight:
                                        FontWeight.w600,
                                        color: _primaryNavy,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    padding:
                                    const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(
                                          18),
                                      color: _cardBg,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          task.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                            color:
                                            _primaryNavy,
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            task.isFavorite =
                                            !task.isFavorite;
                                            FirebaseFunctions
                                                .updateTask(task);
                                          },
                                          child: Icon(
                                            task.isFavorite
                                                ? Icons.favorite
                                                : Icons
                                                .favorite_border,
                                            color: task.isFavorite
                                                ? _primaryNavy
                                                : _primaryNavy
                                                .withOpacity(
                                                0.4),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}