# CollectDeviceData: Flutter Plugin

The CollectDeviceData Flutter plugin provides a seamless interface to the underlying native Android SDK for collecting anonymized, non-personally identifiable information (non-PII) from user devices. It maintains compliance with privacy regulations by ensuring explicit user consent is obtained before initiating any data synchronization processes. This plugin enables Flutter apps to leverage native capabilities while respecting user privacy and platform guidelines.

## Requirements

The CollectDeviceData Flutter plugin supports Android 5.0 and above (API level 21+), requires Java 8 or higher, and is built using AndroidX. To ensure compatibility with Android 7.0 and lower, desugaring must be enabled in your project.


## Add the required permissions in Android.manifest file:


=== "AndroidManifest.xml"

 
    ```html
    <uses-feature android:name="android.hardware.telephony" 
                  android:required="false" />

    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.BIND_NOTIFICATION_LISTENER_SERVICE"
        tools:ignore="ProtectedPermissions" />
    <uses-permission android:name="android.permission.RECEIVE_SMS" />
    <uses-permission android:name="android.permission.READ_SMS" />
    <uses-permission android:name="android.permission.READ_CONTACTS" />
    <uses-permission android:name="android.permission.READ_CALL_LOG" /> 
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    ```
 

## IOS Configuration


### Create Podfile (if not present):

Run `flutter build ios` in ios folder - creates a podfile

Inject sdk dependency into the podfile in the ios application (developer needs to have access to the private repository – ask the admin team)

=== "Podfile"

    ```ruby
    target 'Runner' do
        use_frameworks!

        pod 'CollectDeviceIOSData', :git => 'https://github.com/Credeau/CollectDeviceIOSData', :tag => '0.2.3'
  
        flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
        target 'RunnerTests' do
          inherit! :search_paths
        end
    end
       
    ``` 

Now run `pod install`

## Installing the `flutter_collect_data` plugin:

Add the `flutter_collect_data` plugin into the `pubspec.yaml` file in your flutter app to implement the functions of the CollectDeviceData SDK.

=== "pubspec.yaml"

    ```yaml

    dependencies:
      flutter:
        sdk: flutter

      flutter_collect_data:
        git:
          url: https://github.com/Credeau/flutter_collect_data
          ref: shubham/india-privacy-version

      permission_handler: ^11.3.1
      http: ^1.4.0
      firebase_core: ^3.13.1
      firebase_messaging: ^15.2.6
    ```

Now run `flutter pub get`

## Import the Class from the flutter plugin.

=== "Main.dart"

    ```yaml

    import 'package:flutter_collect_data/flutter_collect_data_method_channel.dart';
    
    ```

## Initialize the `MethodChannelFlutterCollectData` instance:

This creates an instance of the MethodChannelFlutterCollectData class, which is the bridge between Flutter and the native (Android/iOS) code.

=== "Main.dart"

    ```dart
    
    MethodChannelFlutterCollectData plugin = MethodChannelFlutterCollectData();

    
    ```

### Request Required Permissions:

Before calling any sync operation, request runtime permissions. For example:

=== "Main.dart"

    ```dart
    
    Future<void> requestPermissions() async {
    
        final smsStatus = await Permission.sms.request();
        final phoneStatus = await Permission.phone.request();
        final callLogReadStatus = await Permission.accessMediaLocation.request();
        final contactsStatus = await Permission.contacts.request();
        final locationStatus = await Permission.location.request();
    
    }
    ```

> **Note**: All permissions must be granted for successful data collection.

### To match the details (Fullname, Phone no., Email):

Device matching enhances pattern recognition to identify users based on their email address, phone number, and name. All matching is performed locally on the device, ensuring that no personal information—such as phone numbers or email addresses—is transmitted off the device.

To use this feature, initialize the function by providing the customer's email address, phone number, and name.

=== "Main.dart"

    ```dart
    
    await plugin.setDeviceMatchParams(
          fullname: _fullNameController.text,
          phone: _phoneController.text,
          email: _emailController.text,
    );


    ```

### To disable syncs for the particular categories (sms, call logs, contacts):


Disable syncs function disable the sync functionality for the categories passed in the parameters. This function needs to be called before the `startBackgroundSyncProcess` or `syncAllData` functions.

=== "Main.dart"

    ```dart
    
    plugin.disableSyncs("sms", "contacts", "call_logs");

    
    ```

### To start iterative sync process:

`startBackgroundSyncProcess` is a function that syncs the sms, call logs, contacts and device meta data for extracting features. This function iteratively runs in the background after set intervals, to keep the data syncing updated.

=== "Main.dart"

    ```dart
    
    await plugin.startBackgroundSyncProcess(
          userId: _usernameController.text,
          clientName: "<CLIENT_NAME>",
          clientKey:  "<CLIENT_KEY>",
          serverUrl:  "<SERVER_URL>",
          gapSeconds
    ).
    then((result) {
        print("Sync Completed and background process started!");         
    }).
    catchError((error) {
        print("Error during sync: $error");       
    }).
    whenComplete(() {
        print("Sync Completed!");           
    });
    ```

> **The following will be shared by the Credeau team:**
>
> - `<CLIENT_NAME>`
> - `<CLIENT_KEY>`
> - `<SERVER_URL>`

### To sync data once:

`syncAllData` is a function that syncs the sms, call logs, contacts and device meta data for extracting features. Unlike `startBackgroundSyncProcess` function this function only runs once when called.

=== "Main.dart"

    ```dart
    
    await plugin.syncAllData(
          userId: _usernameController.text,
          clientName: "<CLIENT_NAME>",
          clientKey:  "<CLIENT_KEY>",
          serverUrl:  "<SERVER_URL>"
    ).
    then((result) {
        print("Sync Completed!");         
    }).
    catchError((error) {
        print("Error during sync: $error");       
    }).
    whenComplete(() {
        print("Sync Completed!");           
    });
    ```

> **The following will be shared by the Credeau team:**
>
> - `<CLIENT_NAME>`
> - `<CLIENT_KEY>`
> - `<SERVER_URL>`

## Send Incoming Notifications to the SDK

Some phone manufacturers implement aggressive battery optimization techniques that terminate background apps after periods of inactivity. This behavior can interfere with the DeviceConnect SDK’s ability to perform continuous syncing, as it depends on background data collection. When this happens, Credeau's server may need to request data from the SDK if the sync process has been halted.

To handle this, the SDK leverages Firebase Cloud Messaging (FCM). Forwarding FCM notifications helps the app sync the data even if it has been stopped by the device's background processes by sending in the silent notification to the deviec enabling it to resume data collection seamlessly.

To support this functionality, add the following code inside the overridden `onMessageReceived` method in your service class that extends `FirebaseMessagingService`.

=== "FirebaseListener.dart"

    ```dart
    
    Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
        final Map<String, dynamic> data = {
            'data': message.data,
        };

        final isCredNotification =
            await plugin.isDeviceDataCollectionNotification(messageData: data);

        if (isCredNotification) {
            print("CREDEAU NOTIFICATION");
            await plugin.triggerOnMessageReceived(messageData: data);
        } else {
            print("NON CREDEAU NOTIFICATION");
        }
    }
    ```
