import 'package:evently_c17_fri/models/task_model.dart';
import 'package:evently_c17_fri/providers/add_event_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  static const String routeName = "AddEventScreen";

  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  TimeOfDay? _selectedTime;

  static const Color _scaffoldBg    = Color(0xFFEEF0FF);
  static const Color _primaryNavy   = Color(0xFF1A237E);
  static const Color _cardWhite     = Color(0xFFFFFFFF);
  static const Color _labelColor    = Color(0xFF1A237E);
  static const Color _hintColor     = Color(0xFFB0B8D8);
  static const Color _borderColor   = Color(0xFFD6DAF0);

  final List<String> categories = [
    "eating",
    "sport",
    "exhibition",
    "bookclub",
    "birthday",
    "gaming",
    "workshop",
    "meeting",
    "holiday",
  ];

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddEventProvider(),
      builder: (context, child) {
        var provider = Provider.of<AddEventProvider>(context);
        return Scaffold(
          backgroundColor: _scaffoldBg,
          appBar: AppBar(
            backgroundColor: _scaffoldBg,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: _primaryNavy),
            title: Text(
              "Add Event",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _primaryNavy,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: _cardWhite,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: _primaryNavy.withOpacity(0.07),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        "assets/images/${categories[provider.selectedCategoryIndex]}.png",
                      ),
                    ),
                  ),

                  SizedBox(height: 18),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => provider.changeCategory(index),
                        child: Chip(
                          label: Text(categories[index]),
                          backgroundColor: index == provider.selectedCategoryIndex
                              ? _primaryNavy
                              : _cardWhite,
                          side: BorderSide(
                            color: index == provider.selectedCategoryIndex
                                ? _primaryNavy
                                : _borderColor,
                            width: 1.2,
                          ),
                          labelStyle: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: index == provider.selectedCategoryIndex
                                ? _cardWhite
                                : _primaryNavy,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      separatorBuilder: (c, i) => SizedBox(width: 12),
                      itemCount: categories.length,
                    ),
                  ),

                  SizedBox(height: 18),
                  Text(
                    "Title",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: _labelColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  TextField(
                    controller: titleController,
                    style: GoogleFonts.poppins(fontSize: 14, color: _primaryNavy),
                    decoration: InputDecoration(
                      hintText: "Event Title",
                      hintStyle: GoogleFonts.poppins(fontSize: 14, color: _hintColor),
                      filled: true,
                      fillColor: _cardWhite,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: _borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: _borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: _primaryNavy, width: 1.6),
                      ),
                    ),
                  ),

                  SizedBox(height: 18),
                  Text(
                    "Description",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: _labelColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  TextField(
                    maxLines: 5,
                    controller: descriptionController,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(fontSize: 14, color: _primaryNavy),
                    decoration: InputDecoration(
                      hintText: "Event Description....",
                      hintStyle: GoogleFonts.poppins(fontSize: 14, color: _hintColor),
                      filled: true,
                      fillColor: _cardWhite,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: _borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: _borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: _primaryNavy, width: 1.6),
                      ),
                    ),
                  ),

                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_month_outlined,
                              color: _primaryNavy, size: 22),
                          SizedBox(width: 8),
                          Text(
                            "Event Date",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: _primaryNavy,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          DateTime? chosenDate = await showDatePicker(
                            context: context,
                            initialDate: provider.selectedDate,
                            firstDate: DateTime.now(),
                            lastDate:
                            DateTime.now().add(Duration(days: 365)),
                          );
                          provider.changeDate(chosenDate ?? DateTime.now());
                        },
                        child: Text(
                          provider.selectedDate.toString().substring(0, 10),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: _primaryNavy,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: _primaryNavy,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time_outlined,
                              color: _primaryNavy, size: 22),
                          SizedBox(width: 8),
                          Text(
                            "Event Time",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: _primaryNavy,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: _selectedTime ?? TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              _selectedTime = pickedTime;
                            });
                          }
                        },
                        child: Text(
                          _selectedTime == null
                              ? "Choose time"
                              : _selectedTime!.format(context),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: _primaryNavy,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: _primaryNavy,
                          ),
                        ),
                      ),
                    ], 
                  ),

                  SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        provider.addEvent(
                          TaskModel(
                            title: titleController.text,
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            description: descriptionController.text,
                            category:
                            categories[provider.selectedCategoryIndex],
                            date: provider.selectedDate.millisecondsSinceEpoch,
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryNavy,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        "Add Event",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
