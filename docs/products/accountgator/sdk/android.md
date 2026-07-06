# AccountGator Android Native SDK

Android wrapper for the AccountGator embeddable web SDK.

This package loads your AccountGator web flow inside a native `WebView`, passes the required initialization data, and forwards the final `accountgator:result` message back to your Android application.

## Features

- Typed init payload with `AccountGatorInitData`
- Three integration options: Ultra-simple callback API, Activity Result API, or legacy `onActivityResult()`
- Built-in `AccountGatorActivity` for quick integration
- Custom `AccountGatorSdkView` widget for advanced use cases
- Kotlin callback for success, failure, timeout, and cancellation outcomes
- Type-safe result handling with sealed classes
- ProGuard/R8 compatible
- WebView keyboard support

## Variables

| Variable | Description | Format | Source |
|----------|-------------|--------|--------|
| `clientId` | Unique identifier for your organisation | Alphanumeric string | Provided by Credeau during onboarding |
| `authToken` | Secret token for API authentication | Alphanumeric string | Provided by Credeau during onboarding |
| `userId` | Unique identifier for an end user | Alphanumeric string | Provided by Credeau during onboarding |
| `mobileNumber` | End user's mobile number | Like, 9999999999 | Provided by customer during journey |
| `redirectUrl` | URL to redirect to post process | Like, https://yourdomain.com/redirection/path | Set by client as per requirement |
| `templateName` | Account Aggregator template name | Either `BANK_STATEMENT_PERIODIC` or `BANK_STATEMENT_ONETIME` | Set by client as per requirement |
| `consentTemplates` | Account Aggregator template array | Either `["BANK_STATEMENT_PERIODIC"]` or `["BANK_STATEMENT_ONETIME"]` or both `["BANK_STATEMENT_PERIODIC", "BANK_STATEMENT_ONETIME"]` | Set by client as per requirement |

> ⚠️ **Note**
>
> 1. Keep these credentials secure and never share them publicly. These credentials are unique to your organization and will be used to authenticate all API requests.
>
> 2. `templateName` and `consentTemplates` are mutually exclusive. Provide `consentTemplates` for a multi-template flow; provide `templateName` for a single-template flow. Exactly one of the two must be present.

## Requirements

- Android API 24+ (Android 7.0+)
- Kotlin 1.9.20+
- Java 17+

## Quick Start

### 1. Add the SDK

#### Repository Configuration

In your project level `settings.gradle.kts` file, add the repository URLs to the `repositories` block in `dependencyResolutionManagement` block.

=== "build.gradle"

    ```kotlin
    repositories {
        google()
        mavenCentral()
        maven {
            setUrl("s3://accountgatorsdk/")
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

#### Adding Dependencies

Add the SDK to your application by adding the dependency into your app level `build.gradle` file:

=== "build.gradle"

    ```kotlin
    dependencies {
        implementation("com.credeau:accountgator:<sdk_version>@aar")
    }
    ```

> **Note**: `<sdk_version>` will be provided by the Credeau team. Please contact support for the latest version.

### 2. Initialize the SDK

Create an `Application` class and initialize the SDK:

```kotlin
import android.app.Application
import com.accountgator.sdk.AccountGatorSDK

class MyApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        
        AccountGatorSDK.initialize(
            context = this,
            clientId = "your_client_id",
            authToken = "your_auth_token"
        )
    }
}
```

Register it in `AndroidManifest.xml`:

```xml
<manifest>
    <uses-permission android:name="android.permission.INTERNET" />
    
    <application
        android:name=".MyApplication"
        ...>
        
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
        
        <!-- SDK Activity (automatically included) -->
        <activity
            android:name="com.accountgator.sdk.ui.AccountGatorActivity"
            android:exported="false"
            android:theme="@style/Theme.AppCompat.Light.NoActionBar" />
    </application>
</manifest>
```

### 3. Start the AccountGator Flow

Choose your preferred integration method:

---

## Integration: Ultra-Simple Callback API

### XML Layout Approach

**MainActivity.kt:**

```kotlin
import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.accountgator.sdk.AccountGatorSDK
import com.accountgator.sdk.handleAccountGatorResult
import com.accountgator.sdk.models.AccountGatorResult

class MainActivity : AppCompatActivity() {
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        
        findViewById<Button>(R.id.btnStartConsent).setOnClickListener {
            startConsentFlow()
        }
    }
    
    private fun startConsentFlow() {
        // Option 1: Single template
        AccountGatorSDK.startFlow(
            activity = this,
            userId = "user_123",
            mobileNumber = "9876543210",
            redirectUrl = "https://your-app.com/redirect",
            templateName = "BANK_STATEMENT_PERIODIC"
        ) { result ->
            handleConsentResult(result)
        }
        
        // OR Option 2: Multiple templates
        /*
        AccountGatorSDK.startFlow(
            activity = this,
            userId = "user_123",
            mobileNumber = "9876543210",
            redirectUrl = "https://your-app.com/redirect",
            consentTemplates = listOf(
                "BANK_STATEMENT_PERIODIC",
                "BANK_STATEMENT_ONETIME"
            )
        ) { result ->
            handleConsentResult(result)
        }
        */
    }
    
    private fun handleConsentResult(result: AccountGatorResult) {
        when (result) {
            is AccountGatorResult.Success -> {
                val sessionId = result.sessionId ?: "unknown"
                Toast.makeText(this, "Success! Session: $sessionId", Toast.LENGTH_LONG).show()
                // Navigate to success screen or process the session ID
            }
            is AccountGatorResult.Timeout -> {
                Toast.makeText(this, "Request timed out", Toast.LENGTH_SHORT).show()
            }
            is AccountGatorResult.Error -> {
                Toast.makeText(this, "Error: ${result.message}", Toast.LENGTH_LONG).show()
            }
            is AccountGatorResult.Cancelled -> {
                // User cancelled - no action needed
            }
        }
    }
    
    // Required: Add this method to handle SDK callbacks
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        handleAccountGatorResult(requestCode, resultCode, data)
    }
}
```

**activity_main.xml:**

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="24dp"
    android:gravity="center">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="AccountGator SDK"
        android:textSize="24sp"
        android:textStyle="bold"
        android:layout_marginBottom="32dp" />

    <Button
        android:id="@+id/btnStartConsent"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:text="Start Consent Flow"
        android:textSize="16sp"
        android:padding="16dp" />

</LinearLayout>
```

### Jetpack Compose Approach

**MainActivity.kt:**

```kotlin
import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.accountgator.sdk.AccountGatorSDK
import com.accountgator.sdk.handleAccountGatorResult
import com.accountgator.sdk.models.AccountGatorResult

class MainActivity : ComponentActivity() {
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        setContent {
            MaterialTheme {
                ConsentScreen()
            }
        }
    }
    
    @Composable
    fun ConsentScreen() {
        val context = LocalContext.current
        val activity = context as MainActivity
        
        Surface(
            modifier = Modifier.fillMaxSize(),
            color = MaterialTheme.colorScheme.background
        ) {
            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(24.dp),
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.Center
            ) {
                Text(
                    text = "AccountGator SDK",
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(bottom = 32.dp)
                )
                
                Button(
                    onClick = {
                        startConsentFlow(activity)
                    },
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(56.dp)
                ) {
                    Text(text = "Start Consent Flow", fontSize = 16.sp)
                }
            }
        }
    }
    
    private fun startConsentFlow(activity: MainActivity) {
        // Option 1: Single template
        AccountGatorSDK.startFlow(
            activity = activity,
            userId = "user_123",
            mobileNumber = "9876543210",
            redirectUrl = "https://your-app.com/redirect",
            templateName = "BANK_STATEMENT_PERIODIC"
        ) { result ->
            handleConsentResult(result, activity)
        }
        
        // OR Option 2: Multiple templates
        /*
        AccountGatorSDK.startFlow(
            activity = activity,
            userId = "user_123",
            mobileNumber = "9876543210",
            redirectUrl = "https://your-app.com/redirect",
            consentTemplates = listOf(
                "BANK_STATEMENT_PERIODIC",
                "BANK_STATEMENT_ONETIME"
            )
        ) { result ->
            handleConsentResult(result, activity)
        }
        */
    }
    
    private fun handleConsentResult(result: AccountGatorResult, activity: MainActivity) {
        when (result) {
            is AccountGatorResult.Success -> {
                val sessionId = result.sessionId ?: "unknown"
                Toast.makeText(activity, "Success! Session: $sessionId", Toast.LENGTH_LONG).show()
            }
            is AccountGatorResult.Timeout -> {
                Toast.makeText(activity, "Request timed out", Toast.LENGTH_SHORT).show()
            }
            is AccountGatorResult.Error -> {
                Toast.makeText(activity, "Error: ${result.message}", Toast.LENGTH_LONG).show()
            }
            is AccountGatorResult.Cancelled -> {
                // User cancelled
            }
        }
    }
    
    // Required: Add this method to handle SDK callbacks
    @Deprecated("Deprecated in ComponentActivity")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        handleAccountGatorResult(requestCode, resultCode, data)
    }
}
```

## Output

When the consent journey completes, the callback returns an `AccountGatorResult` sealed class.

### Success Response

```kotlin
AccountGatorResult.Success(sessionId = "bd87bf398a754fe8b37786829bdc7118")
```

### Timeout Response

```kotlin
AccountGatorResult.Timeout
```

### Error Response

```kotlin
AccountGatorResult.Error(message = "Invalid credentials")
```

### Cancelled Response

```kotlin
AccountGatorResult.Cancelled
```

### Response Fields

- `Success.sessionId`: Account Aggregator session ID returned after successful consent (may be null)
- `Error.message`: Error message returned when the journey fails
- `Timeout`: User did not complete the journey within the allowed time
- `Cancelled`: User cancelled the flow by pressing back button

## Handle the Response

### Option 1: Inline Callback (Ultra-Simple API)

```kotlin
AccountGatorSDK.startFlow(...) { result ->
    when (result) {
        is AccountGatorResult.Success -> {
            // Consent completed successfully
            val sessionId = result.sessionId
            // Send sessionId to your backend
        }
        is AccountGatorResult.Timeout -> {
            // User did not complete consent in time
            showRetryDialog()
        }
        is AccountGatorResult.Error -> {
            // Error occurred
            showError(result.message)
        }
        is AccountGatorResult.Cancelled -> {
            // User cancelled the flow
            // No action needed
        }
    }
}
```

### Option 2: Activity Result API Callback

```kotlin
private val consentLauncher = registerForActivityResult(AccountGatorContract()) { result ->
    when (result) {
        is AccountGatorResult.Success -> handleSuccess(result.sessionId)
        is AccountGatorResult.Timeout -> handleTimeout()
        is AccountGatorResult.Error -> handleError(result.message)
        is AccountGatorResult.Cancelled -> handleCancellation()
    }
}
```




## Notes

- Use your deployed AccountGator journey URL as `baseUrl` when initializing.
- Use a redirect URL you control. Avoid pages like Google that block iframe/WebView rendering.
- Always handle all result types: Success, Timeout, Error, and Cancelled.
- Store credentials securely and never hardcode them in production.


### Runtime Errors

**Error: clientId is required**
- Call `initialize()` in Application class
- Verify credentials are not empty

**Error: No callback triggered**
- Add `handleAccountGatorResult()` to `onActivityResult()`
- This is required for `startFlow()` API

## Support

For issues and questions, please contact: support@accountgator.com

## License

Apache License 2.0
