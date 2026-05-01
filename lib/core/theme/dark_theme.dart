import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  textTheme: TextTheme(
    bodySmall: TextStyle(
      color: Color(0xFF15B86C),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFFC6C6C6),
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
    ),
    //for Done task
    titleLarge: TextStyle(
      color: Color(0xFFA0A0A0),
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFFA0A0A0),
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      color: Color(0xFFFFFCFC),
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      color: Color(0xFFFFFFFF),
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
    ),
    labelMedium: TextStyle(color: Colors.white, fontSize: 16),
    labelSmall: TextStyle(
      fontSize: 20,
      color: Color(0xFFFFFCFC),
      fontWeight: FontWeight.w400,
    ),
  ),

  ///--------------------------------
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

  ///-------------------------------elevatedButtonTheme
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

  ///------------------------------------------------
  scaffoldBackgroundColor: Color(0xFF181818),

  ///-----------------------------------------------
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF181818),
    titleTextStyle: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
    centerTitle: true,
  ),

  ///-------------------------------------TextFormField-------------
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      color: Color(0xFF6D6D6D),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    filled: true,
    fillColor: Color(0xFF282828),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(16),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: .5),
      borderRadius: BorderRadius.circular(16),
    ),
  ),

  ///----------------------------------------- الديفولت بتاع الدارك container
  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0xFF282828),
    secondary: Color(0xFFC6C6C6),
  ),

  ///--------------------------------ChekBOX-----------------------------
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xFF6E6E6E), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),

  ///--------------------------------ICONTheme-----------------
  iconTheme: IconThemeData(color: Color(0xFFC6C6C6)),

  ///----------------------------------
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
      color: Color(0xFFFFFCFC),
    ),
  ),

  ///--------------------------Divider
  dividerTheme: DividerThemeData(color: Color(0xFFCAC4D0)),

  ///-----------------الكرسر اللي بيحدد بيه تعديل الداتا -----------
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.green,
    selectionHandleColor: Colors.white,
  ),

  ///------------------------Buttom Nafigation-------------
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xFFC6C6C6),
    selectedItemColor: Color(0xFF15B86C),
    backgroundColor: Color(0xFF181818),
  ),
  splashFactory: NoSplash.splashFactory,

  ///بيحوش الافكت وانت بتدوس في الزراير
  ///-----------------PopupMenue-------------------------------
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFF181818),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Color(0xFF15B86C), width: 1),
      
    ),
    menuPadding: EdgeInsets.all(16),
    elevation: 5,
    shadowColor: Color(0xFF15B86C),
    labelTextStyle: WidgetStateProperty.all(TextStyle(
      fontSize: 20,fontWeight: FontWeight.w400
    ))
  ),
  ///---------------------TextButtom---------------------------
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
     foregroundColor: WidgetStateProperty.all(Color(0xFFFFFCFC)),

    )
  )
);
