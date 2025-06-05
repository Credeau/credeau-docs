# CollectDeviceData: IOS SDK

The CollectDeviceIOSData IOS SDK facilitates the collection of anonymized, non-personally identifiable information (non-PII) from user devices. It ensures compliance with privacy policies by requiring explicit user consent before initiating any data synchronization processes.

## Requirements

Device Connect IOS SDK works on IOS 16.1 and Xcode 14.1.


## Create Podfile (if not present):

Run `pod init` - creates a podfile



## Adding Dependencies

Add the pod `CollectDevieIOSData` into the podfile of your app.

=== "Podfile"

    ```ruby

    target 'IosTestApp' do
    # Comment the next line if you don't want to use dynamic frameworks
    use_frameworks!

    # Pods for IosTestApp
  
    pod 'CollectDeviceIOSData', :git => 'https://github.com/Credeau/CollectDeviceIOSData', :tag => '0.2.3'

    target 'IosTestAppTests' do
        inherit! :search_paths
        # Pods for testing
    end

    target 'IosTestAppUITests' do
        # Pods for testing
    end
       
    ``` 
  
## Add the required permission in info.plist file:


=== "Info.plist"

    ```plist
    
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>We need location access to provide better services.</string>

    <key>NSUserTrackingUsageDescription</key>
    <string>This allows us to provide personalized ads and analytics.</string>
    
    <key>NSContactsUsageDescription</key>
    <string>We need access to your contacts to improve your experience and suggest friends.</string>
    
    ```
 


## Requesting permissions in your swift file:

For example, to request contact permission - 



=== "MainActivity.swift"

    ```swift
    
    func requestContactsAccess() {
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        
        switch authorizationStatus {
        case .authorized:
            print("Access already granted")
            
        case .notDetermined:
            contactStore.requestAccess(for: .contacts) { granted, error in
                if granted {
                    print("Access granted")
                } else {
                    print("Access denied")
                }
            }
            
        case .denied, .restricted:
            print("Access denied or restricted")
            
        @unknown default:
            print("Unknown authorization status")
        }
    }
    
    ```

<br>
<br>



### To disable syncs for the particular categories (call logs, contacts):


Disable syncs function disable the sync functionality for the categories passed in the parameters. This function needs to be called before the `startBackgroundSyncProcess` or `syncAllData` functions.



=== "MainActivity.swift"

    ```swift
    
    CollectDeviceIOSData.CollectDeviceFeatures.disableSync(syncsDisabled: ["contacts"])

    ```


<br>
<br>


### To start iterative sync process:


`startBackgroundSyncProcess` is a function that syncs the call logs, contacts and device meta data for extracting features. This function iteratively runs in the background after set intervals, to keep the data syncing updated.


=== "MainActivity.swift"

    ```swift

    CollectDeviceIOSData.CollectDeviceFeatures.startBackgroundSyncProcess(
        userName:  "user1",
        clientId:  "<CLIENT_ID>", 
        clientKey: "<CLIENT_KEY>",
        serverURL: "<SERVER_URL>"){ result in

        switch result {
        case .success(let data):
            print("Device Data Synced and Background Process Started!")
            print(data)
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }

    }


    ```


> **The following will be shared by the Credeau team:**
>
> - `<CLIENT_ID>`
> - `<CLIENT_KEY>`
> - `<SERVER_URL>`


<br>
<br>

### To sync data once:


`syncAllData` is a function that syncs the call logs, contacts and device meta data for extracting features. Unlike `startBackgroundSyncProcess` function this function only runs once when called.


=== "MainActivity.swift"

    ```swift
    
    CollectDeviceIOSData.CollectDeviceFeatures.syncDeviceData(userName: "user1", clientId: "<CLIENT_ID>", clientKey: "<CLIENT_KEY>", serverURL: "<SERVER_URL>"){ result in
        switch result {
        case .success(let data):
            print("Device Data Synced!")
            print(data)
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        }
    }


    ```


> **The following will be shared by the Credeau team:**
>
> - `<CLIENT_ID>`
> - `<CLIENT_KEY>`
> - `<SERVER_URL>`
