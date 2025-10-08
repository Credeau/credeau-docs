# CollectDeviceData: React native wrapper

The CollectDeviceData React native wrapper provides a seamless interface to the underlying native Android SDK for collecting anonymized, non-personally identifiable information (non-PII) from user devices. It maintains compliance with privacy regulations by ensuring explicit user consent is obtained before initiating any data synchronization processes. This wrapper enables React native apps to leverage native capabilities while respecting user privacy and platform guidelines.

## Requirements

The CollectDeviceData React native wrapper supports Android 5.0 and above (API level 21+), requires Java 8 or higher, and is built using AndroidX. To ensure compatibility with Android 7.0 and lower, desugaring must be enabled in your project.

### Repository Configuration

In your app level `build.gradle` file, add the repository URLs to the `repositories` block above the `dependencies` block:

=== "build.gradle"

    ```kotlin
   
    repositories {
        maven {
            url "s3://deviceinsightssdk"
            credentials(AwsCredentials) {
            accessKey = <ACCESS_KEY>
            secretKey = <SECRET_KEY>
            }   
        }   
    }

    ```


> **Note**: Replace `<ACCESS_KEY>` and `<SECRET_KEY>` with the credentials provided by the Credeau team.
>
> **The following will be shared by the Credeau team:**
>
> - `<ACCESS_KEY>`
> - `<SECRET_KEY>`


 
## Add the required permissions in Android.manifest file:


=== "AndroidManifest.xml (For India)"

    ```xml
    <uses-feature android:name="android.hardware.telephony" android:required="false" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.READ_SMS" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    ```

=== "AndroidManifest.xml (For Other Markets)"

    ```xml
    <uses-feature android:name="android.hardware.telephony" android:required="false" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.BIND_NOTIFICATION_LISTENER_SERVICE" tools:ignore="ProtectedPermissions" />
    <uses-permission android:name="android.permission.READ_CALL_LOG" />
    <uses-permission android:name="android.permission.READ_CONTACTS" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.RECEIVE_SMS" />
    <uses-permission android:name="android.permission.READ_SMS" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    ```
 

## IOS Configuration

Inject sdk dependency into the podfile in the ios application (developer needs to have access to the private repository – ask the admin team)

=== "Podfile"

    ```ruby
    target 'DemoReactNativeApp' do
        config = use_native_modules!
  
        pod 'CollectDeviceIOSData', :git => 'https://github.com/Credeau/CollectDeviceIOSData', :tag => '0.2.3'

        use_react_native!(
            :path => config[:reactNativePath],
            # An absolute path to your application root.
            :app_path => "#{Pod::Config.instance.installation_root}/.."
        )

    target 'DemoReactNativeAppTests' do
        inherit! :complete
        # Pods for testing
    end
       
    ``` 

Now run `pod install`



## Installing the `react native wrapper`:

Place the Package File into any path within your react app e.g. `native_modules\react-native-collect-data-0.1.4.tgz`

Run npm install with file reference. E,g : `npm install .\native_modules\react-native-collect-data-0.1.4.tgz`



## Import the functions from the `react-native-collect-data` module:

=== "SyncDataScreen.tsx"

    ```typescript
    
    import {
        startBackGroundSyncProcess,
        syncAllData
        setDeviceMatchParams,
        disableSyncs,
        initializeFirebase,
    } from 'react-native-collect-data';

    
    ```


<br>

### Request Required Permissions:

Before calling any sync operation, request runtime permissions:

For example, to request SMS permissions follow - 

=== "ResuestPermissions.tsx"

    ```typescript
    
        // Request SMS Permission
        const smsStatus = await request(PERMISSIONS.ANDROID.READ_SMS);
        if (smsStatus === RESULTS.GRANTED) {
          setSmsPermission(true);
        } else if (smsStatus === RESULTS.BLOCKED) {
          Alert.alert(
            'Permission Required',
            'SMS permission is required for this feature. Please enable it in the app settings.',
            [
              {text: 'Cancel', style: 'cancel'},
              {text: 'Open Settings', onPress: () => Linking.openSettings()},
            ],
          );
        } else {
          console.log('SMS permission denied');
        }

    
    ```

> **Note**: All permissions (sms, call logs, contacts, phone state, location) must be granted for successful data collection.
>


<br>

### To match the details (Fullname, Phone no., Email):

Device matching enhances pattern recognition to identify users based on their email address, phone number, and name. All matching is performed locally on the device, ensuring that no personal information—such as phone numbers or email addresses—is transmitted off the device.

To use this feature, initialize the function by providing the customer's email address, phone number, and name.

=== "SyncDataScreen.tsx"

    ```typescript
    
    setDeviceMatchParams(fullname, phoneNumber, email);


    ```

<br>


### To disable syncs for the particular categories (sms, call logs, contacts):


Disable syncs function disable the sync functionality for the categories passed in the parameters. This function needs to be called before the `startBackgroundSyncProcess` or `syncAllData` functions.



=== "SyncDataScreen.tsx"

    ```typescript
    
    disableSyncs(['contacts', 'call_logs', 'sms']);

    
    ```

<br>
<br>

### To start iterative sync process:


`startBackgroundSyncProcess` is a function that syncs the sms, call logs, contacts and device meta data for extracting features. This function iteratively runs in the background after set intervals, to keep the data syncing updated.


=== "SyncDataScreen.tsx"

    ```typescript
    
    startBackGroundSyncProcess(
        username,
        '<CLIENT_NAME>',
        '<CLIENT_KEY>',
        '<SERVER_URL>',
        1800
    )
    .then((result: String) => {
        setStatus('Sync Completed!');
    })
    .catch((error: Error) => {
        setStatus(error.toString());
    });


    ```

> **The following will be shared by the Credeau team:**
>
> - `<CLIENT_NAME>`
> - `<CLIENT_KEY>`
> - `<SERVER_URL>`

<br>
<br>

### To sync data once:


`syncAllData` is a function that syncs the sms, call logs, contacts and device meta data for extracting features. Unlike `startBackgroundSyncProcess` function this function only runs once when called.


=== "SyncDataScreen.tsx"

    ```typescript
    
    syncAllData(
        username,
        '<CLIENT_NAME>',
        '<CLIENT_KEY>',
        '<SERVER_URL>'
    )
    .then((result: String) => {
        setStatus('Sync Completed!');
    })
    .catch((error: Error) => {
        setStatus(error.toString());
    });

    
    ```


> **The following will be shared by the Credeau team:**
>
> - `<CLIENT_NAME>`
> - `<CLIENT_KEY>`
> - `<SERVER_URL>`

<br>


## Send Incoming Notifications to the SDK

Some phone manufacturers implement aggressive battery optimization techniques that terminate background apps after periods of inactivity. This behavior can interfere with the DeviceConnect SDK’s ability to perform continuous syncing, as it depends on background data collection. When this happens, Credeau's server may need to request data from the SDK if the sync process has been halted.

To handle this, the SDK leverages Firebase Cloud Messaging (FCM). Forwarding FCM notifications helps the app sync the data even if it has been stopped by the device's background processes by sending in the silent notification to the deviec enabling it to resume data collection seamlessly.

To support this functionality, add the following code inside the overridden `onMessageReceived` method in your service class that extends `FirebaseMessagingService`.



=== "FirebaseListener.tsx"

    ```typescript
    
    import messaging from '@react-native-firebase/messaging';

    messaging().setBackgroundMessageHandler(async remoteMessage => {
        console.log('Message handled in the background!', remoteMessage);

    const data = {
        data: remoteMessage.data,
    };

    const isCredNotification = await NativeModules.YourNativeModule.isDeviceDataCollectionNotification(data);

    if (isCredNotification) {
        console.log('CREDEAU NOTIFICATION');
        await NativeModules.YourNativeModule.triggerOnMessageReceived(data);
    } else {
        console.log('NON CREDEAU NOTIFICATION');
    }
    });

    ```