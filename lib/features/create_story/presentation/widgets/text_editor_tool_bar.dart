// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../blocs/story_cubit/story_cubit.dart';
// import '../blocs/story_cubit/story_state.dart';
//
// class TextEditorToolbar extends StatelessWidget {
//   const TextEditorToolbar({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final storyCubit = context.read<StoryCubit>();
//     return BlocBuilder<StoryCubit, StoryState>(
//       buildWhen:
//           (previous, current) =>
//               previous.currentEditingTextElement !=
//               current.currentEditingTextElement,
//       builder: (context, state) {
//         final currentStyle =
//             state.currentEditingTextElement?.textStyle ?? const TextStyle();
//         final currentBgColor =
//             state.currentEditingTextElement?.backgroundColor ??
//             Colors.transparent;
//         return Container(
//           padding: const EdgeInsets.all(8.0),
//           color: Colors.black54,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     Icons.format_bold,
//                     color:
//                         currentStyle.fontWeight == FontWeight.bold
//                             ? Colors.blue
//                             : Colors.white,
//                   ),
//                   onPressed: storyCubit.toggleBold,
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     Icons.format_italic,
//                     color:
//                         currentStyle.fontStyle == FontStyle.italic
//                             ? Colors.blue
//                             : Colors.white,
//                   ),
//                   onPressed: storyCubit.toggleItalic,
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     Icons.format_underline,
//                     color:
//                         currentStyle.decoration == TextDecoration.underline
//                             ? Colors.blue
//                             : Colors.white,
//                   ),
//                   onPressed: storyCubit.toggleUnderline,
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     Icons.color_lens,
//                     color: currentStyle.color ?? Colors.white,
//                   ),
//                   onPressed:
//                       () => _showColorPicker(
//                         context,
//                         storyCubit,
//                         currentStyle.color ?? Colors.white,
//                         isTextColor: true,
//                       ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.format_color_fill, color: currentBgColor),
//                   onPressed:
//                       () => _showColorPicker(
//                         context,
//                         storyCubit,
//                         currentBgColor,
//                         isTextColor: false,
//                       ),
//                 ),
//                 _buildFontFamilyDropdown(storyCubit, currentStyle.fontFamily),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildFontFamilyDropdown(
//     StoryCubit storyCubit,
//     String? currentFontFamily,
//   ) {
//     final List<String> fontFamilies = [
//       "Roboto",
//       "Open Sans",
//       "Lato",
//       "Montserrat",
//       "Oswald",
//       "Playfair Display",
//     ]; // Example fonts
//     return DropdownButton<String>(
//       value: currentFontFamily ?? "Roboto",
//       dropdownColor: Colors.black87,
//       onChanged: (String? newValue) {
//         if (newValue != null) {
//           storyCubit.changeFontFamily(newValue);
//         }
//       },
//       items:
//           fontFamilies.map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(
//                 value,
//                 style: GoogleFonts.getFont(value).copyWith(color: Colors.white),
//               ),
//             );
//           }).toList(),
//     );
//   }
//
//   void _showColorPicker(
//     BuildContext context,
//     StoryCubit storyCubit,
//     Color currentColor, {
//     required bool isTextColor,
//   }) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         Color pickerColor = currentColor;
//         return AlertDialog(
//           title: Text(
//             isTextColor ? 'Select Text Color' : 'Select BackgroundColor',
//           ),
//           content: SingleChildScrollView(
//             child: ColorPicker(
//               pickerColor: pickerColor,
//               onColorChanged: (color) {
//                 pickerColor = color;
//               },
//               enableAlpha: false,
//               displayThumbColor: true,
//               paletteType: PaletteType.hsvWithSaturation,
//             ),
//           ),
//           actions: <Widget>[
//             ElevatedButton(
//               child: const Text('Got it'),
//               onPressed: () {
//                 if (isTextColor) {
//                   storyCubit.changeTextColor(pickerColor);
//                 } else {
//                   storyCubit.changeTextBackgroundColor(pickerColor);
//                 }
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
