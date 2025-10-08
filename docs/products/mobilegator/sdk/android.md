# CollectDeviceData: Android Analytics SDK

The CollectDeviceData Android SDK facilitates the collection of anonymized, non-personally identifiable information (non-PII) from user devices. It ensures compliance with privacy policies by requiring explicit user consent before initiating any data synchronization processes.

## Requirements

The CollectDeviceData Android SDK supports Android 5.0 and above (API level 21+), requires Java 8 or higher, and is built using AndroidX. To ensure compatibility with Android 7.0 and lower, desugaring must be enabled in your project.

### Repository Configuration

In your project level `settings.gradle.kts` file, add the repository URLs to the `repositories` block in `dependencyResolutionManagement` block.


=== "build.gradle"

    ```kotlin
    repositories {
        google()
        mavenCentral()
        maven {
            setUrl("s3://deviceinsightssdk/")
            credentials(AwsCredentials::class) {
                accessKey = "<ACCESS_KEY>"
                secretKey = "<SECRET_KEY>"
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


## Adding Dependencies

Add the SDK to your application by adding the dependencies into your app level `build.gradle` file.

=== "build.gradle"

    ```kotlin
    implementation("androidx.preference:preference-ktx:1.2.1")
    implementation("com.google.android.gms:play-services-ads-identifier:18.0.1")
    implementation("androidx.work:work-runtime-ktx:2.7.1")
    implementation("com.credeau:collectDeviceData:<sdk_version>@aar")
    implementation("com.google.firebase:firebase-messaging:24.1.0")
       
    ``` 

> Note:
> 
> `<sdk_version>` will vary based on the concerned geography -
>
> - India - `3.0.6`
> - South-East Asia - `2.0.8`
> - For Others, pLease connect with the Credeau team.

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
 

## Import the `DeviceDataManager` class from the SDK:

=== "MainActivity.java"

    ```java
    
    import com.credeau.collectdevicedata.DeviceDataManager;

    ```


### Now initialize the object of `DeviceDataManager` class from the SDK:


=== "MainActivity.java"

    ```java
    
    DeviceDataManager deviceDataManager = new DeviceDataManager(
                MainActivity.this,
                "<CLIENT_ID>",
                "<AUTH_TOKEN>",
                "<SERVER_URL>"
    );
    
    ```

> Note:
> 
> Following credentials will be shared by the Credeau team at the time of integration -
> 
> - `CLIENT_ID`
> - `AUTH_TOKEN`
> - `SERVER_URL`


### Set the username by calling `setUsername`:

=== "MainActivity.java"

    ```java
    deviceDataManager.setUsername("username");
    ```

### To match the details (Fullname, Phone no., Email):

Device matching enhances pattern recognition to identify users based on their email address, phone number, and name. All matching is performed locally on the device, ensuring that no personal information—such as phone numbers or email addresses—is transmitted off the device.

To use this feature, initialize the builder by providing the customer's email address, phone number, and name.

=== "MainActivity.java"

    ```java
    deviceDataManager.setDeviceMatchParams(
        "Full name",
        "9999999999",
        "useremail@gmail.com"
    );
    ```


### To disable syncs for the particular categories (sms, call logs, contacts):


Disable syncs function disable the sync functionality for the categories passed in the parameters. This function needs to be called before the `startBackgroundSyncProcess` or `syncAllData` functions.

=== "MainActivity.java"

    ```java
    deviceDataManager.disableSyncs(new String[]{"sms", "contacts", "call_logs"});
    ```

### To start iterative sync process:


`startBackgroundSyncProcess` is a function that syncs the sms, call logs, contacts and device meta data for extracting features. This function iteratively runs in the background after set intervals, to keep the data syncing updated.


=== "MainActivity.java"

    ```java
    
    deviceDataManager.startBackGroundSyncProcess(new DataDeviceDataCallback() {
                    
        @Override
        public void onSuccess() {
                    Log.i("SDKResult:DataCollection", "Data synced and background processes start!");
        }

        @Override
        public void onFailure(String s) {
                    Log.i("SDKResult:DataCollection", "Data synced Failed!");
        }

    }, 1800L);

    ```

### To sync data once:


`syncAllData` is a function that syncs the sms, call logs, contacts and device meta data for extracting features. Unlike `startBackgroundSyncProcess` function this function only runs once when called.


=== "MainActivity.java"

    ```java
    
    deviceDataManager.syncAllData(new DataDeviceDataCallback() {
                    
        @Override
        public void onSuccess() {
                    Log.i("SDKResult:DataCollection", "Data synced!");
        }

        @Override
        public void onFailure(String s) {
                    Log.i("SDKResult:DataCollection", "Data synced Failed!");
        }

    });

    
    ```

## Send Incoming Notifications to the SDK

Some phone manufacturers implement aggressive battery optimization techniques that terminate background apps after periods of inactivity. This behavior can interfere with the DeviceConnect SDK’s ability to perform continuous syncing, as it depends on background data collection. When this happens, Credeau's server may need to request data from the SDK if the sync process has been halted.

To handle this, the SDK leverages Firebase Cloud Messaging (FCM). Forwarding FCM notifications helps the app sync the data even if it has been stopped by the device's background processes by sending in the silent notification to the deviec enabling it to resume data collection seamlessly.

To support this functionality, add the following code inside the overridden `onMessageReceived` method in your service class that extends `FirebaseMessagingService`.


=== "AppCollectMessagingService.java"

    ```java
    
    @Override
    public void onMessageReceived(@NonNull RemoteMessage message) {

        //Credeau Notification
        if (SDKCollectMessagingService.isDeviceDataCollectionNotification(message)) {
            SDKCollectMessagingService credService = new SDKCollectMessagingService(this);
            credService.triggerOnMessageReceived(message);
        } else {
            Log.i("NOTIFICATION", "Notificagtion Received");
        }

    }

    ```