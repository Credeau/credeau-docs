# CollectDeviceData: Ionic Capacitor Plugin

The CollectDeviceData Ionic Capacitor Plugin provides a seamless interface to the underlying native Android SDK for collecting anonymized, non-personally identifiable information (non-PII) from user devices. It maintains compliance with privacy regulations by ensuring explicit user consent is obtained before initiating any data synchronization processes. This wrapper enables Ionic Capacitor apps to leverage native capabilities while respecting user privacy and platform guidelines.

## Requirements

The CollectDeviceData Ionic Capacitor Plugin supports Android 5.0 and above (API level 21+), requires Java 8 or higher, and is built using AndroidX. To ensure compatibility with Android 7.0 and lower, desugaring must be enabled in your project.

### Repository Configuration

In your app level `build.gradle` file, add the repository URLs to the `repositories` block above the `dependencies` block:

=== "build.gradle"

    ```kotlin

    def awsAccessKey = project.findProperty("AWS_ACCESS_KEY") ?: ""
    def awsSecretKey = project.findProperty("AWS_SECRET_KEY") ?: ""

    repositories {
        maven {
            url "s3://deviceinsightssdk"
            credentials(AwsCredentials) {
            accessKey = awsAccessKey
            secretKey = awsSecretKey
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
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    
    ```

<br>

## IOS Configuration

Inject sdk dependency into the podfile in the ios application (developer needs to have access to the private repository – ask the admin team)

=== "Podfile"

    ```ruby

    target 'App' do
      capacitor_pods
      pod 'CollectDeviceIOSData', :git => 'https://github.com/Credeau/CollectDeviceIOSData', :tag => '0.2.3'
    end
       
    ``` 

Now run `pod install`


<br>


## Installing the `Ionic Capacitor plugin`:

Place the Package File into any path within your react app e.g. `native_modules\ionic-capacitor-collect-data-0.1.1.tgz`

Run npm install with file reference. E,g : `npm install .\native_modules\ionic-capacitor-collect-data-0.1.1.tgz`

<br>


## Import the functions from the `ionic-capacitor-collect-data` module:

=== "App.js"

    ```javascript
    
    import { CollectDataPlugin } from 'capacitor-collect-data';

    ```

<br>

<!-- ### Request Required Permissions:

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
> -->



### To match the details (Fullname, Phone no., Email):

Device matching enhances pattern recognition to identify users based on their email address, phone number, and name. All matching is performed locally on the device, ensuring that no personal information—such as phone numbers or email addresses—is transmitted off the device.

To use this feature, initialize the function by providing the customer's email address, phone number, and name.

=== "App.js"

    ```javascript
    
    await CollectDataPlugin.setDeviceMatchParams({fullname: fullnameInput.value, email: emailInput.value, phone: phoneInput.value});



    ```

<br>


### To disable syncs for the particular categories (sms, call logs, contacts):


Disable syncs function disable the sync functionality for the categories passed in the parameters. This function needs to be called before the `startBackgroundSyncProcess` or `syncAllData` functions.



=== "App.js"

    ```javascript
    
    await CollectDataPlugin.disableSync({disable_syncs:["sms"]});

    
    ```

<br>
<br>

### To start iterative sync process:


`startBackgroundSyncProcess` is a function that syncs the sms, call logs, contacts and device meta data for extracting features. This function iteratively runs in the background after set intervals, to keep the data syncing updated.


=== "App.js"

    ```javascript
    
    await CollectDataPlugin.startBackgroundSyncProcess({
            user_id: usernameInput.value,
            client_name: '<CLIENT_NAME>',
            client_key:  '<CLIENT_KEY>',
            server_url:  '<SERVER_URL>'
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


=== "App.js"

    ```javascript
    
    await CollectDataPlugin.syncAllData({
            user_id: usernameInput.value,
            client_name: '<CLIENT_NAME>',
            client_key:  '<CLIENT_KEY>',
            server_url:  '<SERVER_URL>'
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

To support this functionality, add the following code inside the FCM listener method in your class.


=== "App.js"

    ```javascript
    
    PushNotifications.addListener('pushNotificationReceived', async (notification) => {
    
        const rawData = notification?.notification?.data || notification?.data || notification?.message?.data;
    
        if (!rawData) {
            console.warn('No data found in notification:', notification);
            return;
        }
    
        try {
            const isCollecting = await CollectDataPlugin.isDeviceDataCollectionNotification({
                message_data: { data: rawData }
            });
            console.log('isCollecting', isCollecting);
    
            if (isCollecting) {
                await CollectDataPlugin.triggerOnMessageReceived({
                    message_data: { data: rawData }
                });
            }

        } catch (error) {
            console.error('Background sync error:', error);
        }

    });

    ```