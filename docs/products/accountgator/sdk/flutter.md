# accountgator_flutter

Flutter wrapper for the AccountGator embeddable web SDK.

This package loads your AccountGator web flow inside a native `WebView`, passes the required base64url `data` payload, and forwards the final `accountgator:result` message back to Dart.

## Features

- Typed init payload (`AccountGatorInitData`) with base64url encoding.
- `AccountGatorSdkView` widget to render the flow.
- Dart callback (`onResult`) for success, failure, and timeout outcomes.
- Optional origin allowlist for message hardening.


## Variables

| Variable | Description | Format | Source |
|----------|-------------|--------|--------|
| `clientId` | Unique identifier for your organisation | Alphanumeric string | Provided by Credeau during onboarding |
| `authToken` | Secret token for API authentication | Alphanumeric string | Provided by Credeau during onboarding |
| `userId` | Unique identifier for an end user | Alphanumeric string | Provided by Credeau during onboarding |
| `mobileNumber` | End user's mobile number | Like, 9999999999 | Provided by customer during journey |
| `redirectUrl` | URL to redirect to post process | Like, https://yourdomain.com/redirection/path | Set by client as per requirement |
| `template_name` | Account Aggregator template name | Either `BANK_STATEMENT_PERIODIC` or `BANK_STATEMENT_ONETIME` | Set by client as per requirement |
| `consentTemplates` | Account Aggregator template array | Either [`BANK_STATEMENT_PERIODIC`] or [`BANK_STATEMENT_ONETIME`] or both [`BANK_STATEMENT_PERIODIC`, `BANK_STATEMENT_ONETIME`] | Set by client as per requirement |


> ⚠️ **Note**
>
> 1. Keep these credentials secure and never share them publicly. These credentials are unique to your organization and will be used to authenticate all API requests.
> 
> 2. `template_name` and `consent_templates` are mutually exclusive. Provide `consent_templates` for a multi-template flow; provide `template_name` for a single-template flow. Exactly one of the two must be present.


## Quick start

### 1. Add the package

```yaml
dependencies:
  accountgator_flutter:
    git:
      url: https://github.com/Credeau-Engineering/account-gator-flutter-sdk
      ref: v1.1.0
```

### 2. Create the init payload

```dart
import 'package:accountgator_flutter/accountgator_flutter.dart';

final List<String> consentTemplates = <String>[
      'BANK_STATEMENT_PERIODIC', 'BANK_STATEMENT_ONETIME'    
];

final String templateName = 'BANK_STATEMENT_PERIODIC';

or 

final String templateName = 'BANK_STATEMENT_ONETIME';

final initData = AccountGatorInitData(
  clientId: 'your_client_id',
  authToken: 'your_auth_token',
  userId: 'user_123',
  mobileNumber: '9876543210',
  redirectUrl: 'https://your-app.com/accountgator/redirect',
  templateName: templateName,  
  consentTemplates: consentTemplates
);

```

### 3. Start the AccountGator flow

Render `AccountGatorSdkView` on a screen where you want the consent journey to open:

```dart
import 'package:accountgator_flutter/accountgator_flutter.dart';

class ConsentFlowPage extends StatelessWidget {
  const ConsentFlowPage({super.key});


  final List<String> consentTemplates = <String>[
    'BANK_STATEMENT_PERIODIC', 'BANK_STATEMENT_ONETIME'    
  ];


  final String templateName = 'BANK_STATEMENT_PERIODIC';

  or 
  
  final String templateName = 'BANK_STATEMENT_ONETIME';


  @override
  Widget build(BuildContext context) {
    final initData = AccountGatorInitData(
      clientId: 'your_client_id',
      authToken: 'your_auth_token',
      userId: 'user_123',
      mobileNumber: '9876543210',
      redirectUrl: 'https://your-app.com/accountgator/redirect',
      consentTemplates: consentTemplates,
      templateName: templateName,
      backendUrl: 'https://account-gator.credeau.com',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('AccountGator Consent')),
      body: AccountGatorSdkView(
        baseUrl: 'https://consent-journey.account-gator.credeau.com/',
        initData: initData,
        onResult: (result) {

          // `result` is an `AccountGatorResult` returned by the SDK.

          // Access `result.success` to know whether the consent flow completed.
          // Access `result.aaSessionId` to get the AA session ID on success.
          // Access `result.error` to read the failure reason, if any.
          // Access `result.timeout` to check whether the journey timed out.
         
          
          if (result.success) {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => SuccessPage(sessionId: result.aaSessionId),
              ),
            );
            return;
          }

          if (result.timeout) {
            _showMessage(context, 'Consent flow timed out');
            return;
          }

          _showMessage(
            context,
            'Consent failed: ${result.error ?? 'Unknown error'}',
          );
        },
      ),
    );
  }
}

void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key, this.sessionId});

  final String? sessionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Success')),
      body: Center(
        child: Text('AA session created: ${sessionId ?? 'Unavailable'}'),
      ),
    );
  }
}
```


Helpers:

- `toBase64UrlData()`
- `toSdkUri(baseUrl)`

##   `AccountGatorSdkView`

Required:

- `baseUrl`
- `initData`
- `onResult`

Optional:

- `allowedOrigins`
- `onPageStarted`
- `onPageFinished`
- `onProgress`
- `onWebResourceError`
- `backgroundColor`

## Output

When the consent journey completes, `onResult` returns an `AccountGatorResult`.

Example response:

```dart
{
  "type": "accountgator:result",
  "success": true,
  "aa_session_id": "bd87bf398a754fe8b37786829bdc7118",
  "error": null,
  "timeout": false,
  "origin": "https://consent-journey.account-gator.credeau.com"
}
```

Response fields:

- `success`: `true` when the consent journey completes successfully.
- `aaSessionId`: Account Aggregator session ID returned after successful consent.
- `error`: Error message returned when the journey fails. `null` on success.
- `timeout`: `true` if the user does not complete the journey within the allowed time.
- `origin`: Web origin from which the result message was received.


### Handle the response

`onResult` is called once with the final consent outcome:

- `result.success == true`: consent completed successfully and `aaSessionId` is available.
- `result.timeout == true`: the user did not complete consent in time.
- Otherwise: treat it as a failure and read `result.error`.

### Notes

- Use your deployed AccountGator journey URL as `baseUrl`.
- Use a redirect URL you control. Avoid pages like Google that block iframe/WebView rendering.
- If needed, pass `allowedOrigins` to restrict which web origins are allowed to send result messages.


## Example app

A complete runnable example is available under `example/`.

Run it with:

```bash
cd example
flutter pub get
flutter run
```
