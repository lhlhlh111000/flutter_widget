import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:widget_test/pages/controller/SecondController.dart';

import '../forgeground/my_task_handler.dart';

class SecondPage extends StatelessWidget with RouteAware {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: GetBuilder<SecondController>(
        init: SecondController(),
        initState: (_) {
          // Add a callback to receive data sent from the TaskHandler.
          FlutterForegroundTask.addTaskDataCallback(_onReceiveTaskData);

          WidgetsBinding.instance.addPostFrameCallback((_) async {
            // Request permissions and initialize the service.
            await _requestPermissions();
            _initService();

            await WidgetsBinding.instance.endOfFrame;

            _startService();
          });
        },
        dispose: (_) {
          // Remove a callback to receive data sent from the TaskHandler.
          FlutterForegroundTask.removeTaskDataCallback(_onReceiveTaskData);

          FlutterForegroundTask.stopService();
        },
        builder: (controller) {
          return const Center(
            child: Text('Second Page'),
          );
        },
      ),
    );
  }

  void _onReceiveTaskData(Object data) {
    if (data is Map<String, dynamic>) {
      final dynamic timestampMillis = data["timestampMillis"];
      if (timestampMillis != null) {
        final DateTime timestamp =
            DateTime.fromMillisecondsSinceEpoch(timestampMillis, isUtc: true);
        print('timestamp: ${timestamp.toString()}');
      }
    }
  }

  Future<void> _requestPermissions() async {
    // Android 13+, you need to allow notification permission to display foreground service notification.
    //
    // iOS: If you need notification, ask for permission.
    final NotificationPermission notificationPermission =
        await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }
  }

  void _initService() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'foreground_service',
        channelName: 'Foreground Service Notification',
        channelDescription: 'This notification appears when the foreground service is running.',
        onlyAlertOnce: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: false,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(5000),
        autoRunOnBoot: true,
        autoRunOnMyPackageReplaced: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  Future<ServiceRequestResult> _startService() async {
    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.restartService();
    } else {
      return FlutterForegroundTask.startService(
        // You can manually specify the foregroundServiceType for the service
        // to be started, as shown in the comment below.
        // serviceTypes: [
        //   ForegroundServiceTypes.dataSync,
        //   ForegroundServiceTypes.remoteMessaging,
        // ],
        serviceId: 256,
        notificationTitle: 'Foreground Service is running',
        notificationText: 'Tap to return to the app',
        notificationIcon: null,
        notificationInitialRoute: '/',
        callback: startCallback,
      );
    }
  }
}
