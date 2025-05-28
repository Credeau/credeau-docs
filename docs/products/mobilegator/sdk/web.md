# WebSDK: Web Analytics SDK

The Web Analytics SDK enables comprehensive collection of browser telemetry, device information, and fraud detection metrics from web applications while maintaining user privacy and compliance.

## Requirements

The Web SDK works on Google Chrome, Safari, Firefox, Opera and other popular modern browsers.
 
## Adding Dependency

Add the SDK to your application using one of the following methods.

Using npm:

```bash
npm install credLibKit-web
```
 
or using yarn:
 
```bash
yarn add credLibKit-web
```
 
CDN Integration - Alternatively, include the SDK via CDN:
 
```html
<script  src="https://cdn.jsdelivr.net/npm/credLibKit-web/dist/web-sdk.min.js"></script>
```
 
ES6 Module:

```js
import { syncWebData } from "credLibKit-web";
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
| base_url | string | No | Custom API endpoint (default: https://devdevicesense.credeau.com) |

> Note:
>
> `user_id` must be -
>
> - Alphanumeric (no special characters)
> - Should not exceed 64 characters
> - A non-empty / non-null value

#### Returns

Returns a Promise that resolves to an object containing all collected data, or null if an error occurs.
 

#### Response Handling
 
The response to this method (success or failure) can be captured using async/await or promises.

```js
try {

    const result = await credLibKit.syncWebData(
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
