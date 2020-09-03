import 'package:flutter/material.dart';
import 'package:is_friend_going_out/view/app/new.dart';

class FloatingActionButtonScreen extends StatelessWidget {
  const FloatingActionButtonScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xffdcdcdc),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewGroupEntry(),
          ),
        );
      },
      tooltip: 'Add',
      child: Icon(
        Icons.add,
        color: Color(0xff14244f),
      ),
    );
  }
}

// class FloatingActionButtonScreen extends StatefulWidget {
//   FloatingActionButtonScreen({Key key}) : super(key: key);

//   @override
//   _FancyFabState createState() => _FancyFabState();
// }

// class _FancyFabState extends State<FloatingActionButtonScreen>
//     with SingleTickerProviderStateMixin {
//   bool isOpened = false;
//   AnimationController _animationController;
//   Animation<Color> _buttonColor;
//   Animation<double> _animateIcon;
//   Animation<double> _translateButton;
//   double _fabHeight = 56.0;

//   @override
//   initState() {
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 500),
//     );

//     // For animation to work
//     _animationController.addListener(() => setState(() {}));

//     _animateIcon =
//         Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

//     _buttonColor = ColorTween(
//       begin: Colors.blue,
//       end: Colors.red[400],
//     ).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Interval(0.00, 1.00, curve: Curves.ease),
//       ),
//     );

//     _translateButton = Tween<double>(
//       begin: _fabHeight,
//       end: -14.0,
//     ).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Interval(0.0, 0.75, curve: Curves.easeOut),
//       ),
//     );
//     super.initState();
//   }

//   @override
//   dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   animate() {
//     if (!isOpened)
//       _animationController.forward();
//     else
//       _animationController.reverse();
//     isOpened = !isOpened;
//   }

//   Widget add() {
//     return Container(
//       child: FloatingActionButton(
//         heroTag: 'add_button',
//         backgroundColor: const Color(0xffdcdcdc),
//         elevation: 0,
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => NewGroupEntry(),
//             ),
//           );
//         },
//         tooltip: 'Add',
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   Widget image() {
//     return Container(
//       child: FloatingActionButton(
//         heroTag: 'profile_button',
//         backgroundColor: const Color(0xffdcdcdc),
//         elevation: 0,
//         onPressed: () {},
//         tooltip: 'Image',
//         child: Icon(Icons.image),
//       ),
//     );
//   }

//   Widget inbox() {
//     return Container(
//       child: FloatingActionButton(
//         heroTag: 'status_button',
//         backgroundColor: const Color(0xffdcdcdc),
//         elevation: 0,
//         onPressed: () {},
//         tooltip: 'Inbox',
//         child: Icon(Icons.inbox),
//       ),
//     );
//   }

//   Widget toggle() {
//     return Container(
//       child: FloatingActionButton(
//         heroTag: 'menu_button',
//         backgroundColor: _buttonColor.value,
//         onPressed: animate,
//         tooltip: 'Toggle',
//         child: AnimatedIcon(
//           icon: AnimatedIcons.menu_close,
//           progress: _animateIcon,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: <Widget>[
//         Transform(
//           transform: Matrix4.translationValues(
//             0.0,
//             _translateButton.value * 3.0,
//             0.0,
//           ),
//           child: add(),
//         ),
//         Transform(
//           transform: Matrix4.translationValues(
//             0.0,
//             _translateButton.value * 2.0,
//             0.0,
//           ),
//           child: image(),
//         ),
//         Transform(
//           transform: Matrix4.translationValues(
//             0.0,
//             _translateButton.value,
//             0.0,
//           ),
//           child: inbox(),
//         ),
//         toggle(),
//       ],
//     );
//   }
// }
