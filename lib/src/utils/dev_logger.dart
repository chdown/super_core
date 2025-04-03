import 'package:logger/logger.dart';
import 'dart:developer' as developer;

class DevLogger extends LogOutput {
  @override
  void output(OutputEvent event) {
    event.lines.forEach(developer.log);
  }
}
