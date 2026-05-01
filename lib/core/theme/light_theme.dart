import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  ///--------------------------Text---------------------
  textTheme: TextTheme(
    bodySmall: TextStyle(
      color: Color(0xFF15B86C),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFF3A4640),
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF3A4640),
    ),
    //for Done task
    titleLarge: TextStyle(
      color: Color(0xFF6A6A6A),
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
      //لون الخط اللي ع الكلمه
      decorationColor: Color(0xFF6A6A6A),
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
    ),
    labelMedium: TextStyle(color: Colors.black, fontSize: 16),
    labelSmall: TextStyle(
      fontSize: 20,
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
    ),
  ),
  //------------Switch theme-----------------
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF15B86C);
      }
      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white; // وهيا شغاله لونها ابيض
      }
      return Color(0xFF9E9E9E); // لون الدايره اللي متظلله
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 2;
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent; //لو شغال مش عايز لون
      }
      return Color(0xFF9E9E9E);
    }),
  ),
  //------------------------------------ElevatedButtom------------------
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xFF15B86C)),
      foregroundColor: WidgetStateProperty.all(Color(0xFFFFFCFC)),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      fixedSize: WidgetStateProperty.all(
        Size(double.infinity, 40),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),


    ),
  ),
  //-------------------Scafold---------
  scaffoldBackgroundColor: Color(0xFFF6F7F9),
  //---------------------------------AppBareTheme---------------------
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF6F7F9),
    titleTextStyle: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    iconTheme: IconThemeData(color: Color(0xFF161F1B)),
    centerTitle: true,
  ),
  //------------------TextFormField-----------------------
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    focusColor: Color(0xFFD1DAD6),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: .5),
      borderRadius: BorderRadius.circular(16),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: .5),
      borderRadius: BorderRadius.circular(16),
    ),
    hintStyle: TextStyle(
      color: Color(0xFF9E9E9E),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: .5),
      borderRadius: BorderRadius.circular(16),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: .5),
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  //-----------------------------------Contaner
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xFFFFFFFF),
    secondary: Color(0xFF161F1B),
  ),

  ///----------------------------ChekBoX-----------------
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xFFD1DAD6), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),

  ///----------------------------IconTheme------------------------Camera in profile screen
  iconTheme: IconThemeData(color: Color(0xFFA0A0A0)),

  ///--------------------------floating action Buttom-------------
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xFFFFFCFC),
    extendedTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
  ),

  ///-----------------------listtile
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF3A4640),
    ),
  ),

  ///--------------------DividerTheme
  dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6)),

  ///-----------------الكرسر اللي بيحدد بيه تعديل الداتا -----------
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.green,
    selectionHandleColor: Colors.black,
  ),

  ///------------------------Buttom Nafigation-------------
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xFF3A4640),
    selectedItemColor: Color(0xFF15B86C),
    backgroundColor: Color(0xFFF6F7F9),
  ),
  splashFactory: NoSplash.splashFactory,

  ///بيحوش الافكت وانت بتدوس في الزراير
  ///-----------------PopupMenue-------------------------------
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFFF6F7F9),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Color(0xFF15B86C), width: 1),
    ),
    menuPadding: EdgeInsets.all(16),
    elevation: 5,
    shadowColor: Color(0xFF15B86C),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Color(0xFF161F1B),
      ),
    ),
  ),

  ///---------------------TextButtom---------------------------
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.black)),
  ),
);
