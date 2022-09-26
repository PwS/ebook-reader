import 'package:flutter/material.dart';
import 'package:flutter_alice/alice.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

NavigatorState get navigatorKey => _navigatorKey.currentState!;

Alice alice = Alice(showNotification: false, navigatorKey: _navigatorKey);

FlutterSecureStorage secureStorage = const FlutterSecureStorage();

FlutterSecureStorage flutterSecureStorage = const FlutterSecureStorage();

final prettyPrintLog = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    lineLength: 110,
  ),
);
