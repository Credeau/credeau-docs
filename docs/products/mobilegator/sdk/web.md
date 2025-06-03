# WebSDK: MobileGator Web Analytics SDK

The Web Analytics SDK enables comprehensive collection of browser telemetry, device information, and fraud detection metrics from web applications while maintaining user privacy and compliance.

## Requirements

The Web SDK works on Google Chrome, Safari, Firefox, Opera and other popular modern browsers.
 
## Adding Dependency

Add the SDK to your application using one of the following methods.

Using npm:

```bash
npm install credlibkit-web
```
 
or using yarn:
 
```bash
yarn add credlibkit-web
```
 
CDN Integration - Alternatively, include the SDK via CDN:
 
```html
<script  src="https://cdn.jsdelivr.net/npm/credlibkit-web/dist/web-sdk.min.js"></script>
```
 
ES6 Module:

```js
import { syncWebData } from "credlibkit-web";
```

> Note:
> 
> Following credentials will be shared by the Credeau team at the time of integration -
> 
> - `CLIENT_ID`
> - `SECRET_KEY`

## Function Reference

### Sync Web Data

To collect and synchronize comprehensive browser and device data, call the syncWebData method with the following -
 
`syncWebData(user_id, client_id, secret_key,​base_url)`

#### Parameters

| Parameter | Type | Required | Description |
|----|-----|-----|----|
| user_id | string | Yes | Unique identifier for the user |
| client_id | string | Yes | Your application's client identifier |
| secret_key | string | Yes | Authentication key for API access |
| base_url | string | No | Custom API endpoint (default: https://devicesync.credeau.com) |

> Note:
>
> `user_id` must be -
>
> - Alphanumeric (no special characters)
> - Should not exceed 64 characters
> - A non-empty / non-null value

#### Returns

Returns a Promise that resolves to an object containing all collected data, or null if an error occurs.

Response schema -

```js
{
    user_id: "user123",
    client_id: "client456",
    app_device_id: "unique_device_id",
    sync_id: "sync_identifier",
    sdk_version: "1.0.0",
    sync_request_id: "uuid",

    // Location
    latitude: 37.7749,
    longitude: -122.4194,
    accuracy: 10,
    timezone: "America/Los_Angeles",
 
    // Browser
    browserName: "Chrome",
    os: "Windows 10",
    language: "en-US",
    platform: "Win32",
    vendor: "Google Inc.",
    browser_fingerprint: "hash_value",

    // Hardware
    screenResolution: "1920x1080",
    deviceMemory: 8,
    logicalProcessors: 8,
    maxTouchPoints: 0, touchSupport: false,
    batteryLevel: 0.85,
    batteryCharging: true,

    // Performance
    uptimeMs: 1234567,

    // Storage
    storageUsed: 1024000,
    storageTotal: 2048000,
    localStorageAvailable: true,
    sessionStorageAvailable: true,
    indexedDBAvailable: true,

    // Media
    audioInputs: 1,
    videoInputs: 1,
    videoCard: "NVIDIA GeForce GTX 1060",

    // Security
    incognito: false,
    hasAutomationTools: false,
    isHeadless: false,
    resistFingerprinting: false,
    hasPrivacyExtensions: false,
    doNotTrack: false,
    clipboardSupport: true
}
```

#### Response Handling

The response to this method (success or failure) can be captured using async/await or promises.

```js
try {

    const result = await syncWebData(
        "USER_ID", // User identifier
        "CLIENT_ID", // Your client identifier
        "SECRET_KEY", // Authentication key
        "https://api.yourserver.com" // Optional: Custom API endpoint
    );
 
    if (result) {
        // Data collection successful console.log("Sync successful:", result);
    } else {
        // Data collection failed console.log("Sync failed");
    }
} catch (error) {
    // Handle errors
    console.error("SDK Error:", error);
}
```

## Error Handling

Common error scenarios and their handling -
 
```js
// Handle permission denials gracefully
if (!result.latitude) {
    console.log("Location access denied by user");
}
```

```js
// Network connectivity issues
if (!result) {
    console.log("Network error - sync failed");
}
```

## Privacy Consideration

- Respects user privacy settings and browser limitations
- Handles incognito/private browsing modes appropriately
- Complies with Do Not Track preferences
- No sensitive personal data collected without explicit permission