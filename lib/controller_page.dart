import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
// ignore: implementation_imports
import 'package:flutter_joystick/src/joystick_stick.dart';
import 'package:knob_widget/knob_widget.dart';

class ControllerPage extends StatefulWidget {
  const ControllerPage({Key? key}) : super(key: key);

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  final double _minimum = 0;
  final double _maximum = 180;

  late KnobController _firstJointController;
  late KnobController _secondJointController;
  late KnobController _thirdJointController;
  late double _firstJointValue;
  late double _secondJointValue;
  late double _thirdJointValue;

  @override
  void initState() {
    super.initState();
    _firstJointValue = _minimum;
    _secondJointValue = _minimum;
    _thirdJointValue = _minimum;
    _firstJointController = configKnobController(_firstJointValue);
    _secondJointController = configKnobController(_secondJointValue);
    _thirdJointController = configKnobController(_thirdJointValue);
    _firstJointController.addOnValueChangedListener(
      (value) {
        valueChangedListener(value, 1);
      },
    );
    _secondJointController.addOnValueChangedListener(
      (value) {
        valueChangedListener(value, 2);
      },
    );
    _thirdJointController.addOnValueChangedListener(
      (value) {
        valueChangedListener(value, 3);
      },
    );
  }

  void valueChangedListener(double value, int jointIndex) {
    if (mounted) {
      setState(() {
        switch (jointIndex) {
          case 1:
            _firstJointValue = value;
            break;
          case 2:
            _secondJointValue = value;
            break;
          case 3:
            _thirdJointValue = value;
            break;
        }
      });
    }
  }

  KnobController configKnobController(double value) {
    return KnobController(
      initial: value,
      minimum: _minimum,
      maximum: _maximum,
      startAngle: 0,
      endAngle: 180,
    );
  }

  KnobStyle configKnobStyle() {
    return const KnobStyle(
      minorTicksPerInterval: 10,
      labelStyle: TextStyle(
        color: Colors.blue,
      ),
      minorTickStyle: MinorTickStyle(
        length: 5,
        color: Colors.black,
        highlightColor: Colors.blue,
      ),
      majorTickStyle: MajorTickStyle(
        length: 10,
        color: Colors.black,
        highlightColor: Colors.blue,
      ),
      controlStyle: ControlStyle(
        backgroundColor: Colors.grey,
        tickStyle: ControlTickStyle(
          color: Colors.transparent,
        ),
        glowColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      pointerStyle: PointerStyle(
        color: Colors.blue,
      ),
    );
  }

  Widget createKnob(KnobController controller, String title) {
    return Column(
      children: [
        Text(title),
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: SizedBox(
            width: 150,
            height: 150,
            child: Knob(
              controller: controller,
              style: configKnobStyle(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Center(
                    child: Joystick(
                      listener: (details) {},
                      base: const JoystickBase(
                        width: 300,
                        height: 300,
                      ),
                      stick: const JoystickStick(
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          createKnob(
                            _firstJointController,
                            'Eixo 1: ' +
                                _firstJointValue.toInt().toString() +
                                '°',
                          ),
                          createKnob(
                            _secondJointController,
                            'Eixo 2: ' +
                                _secondJointValue.toInt().toString() +
                                '°',
                          )
                        ],
                      ),
                      createKnob(
                        _thirdJointController,
                        'Pinças: ' + _thirdJointValue.toInt().toString() + '°',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: Center(
                  child: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.blue,
                    child: const Icon(
                      Icons.settings,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
