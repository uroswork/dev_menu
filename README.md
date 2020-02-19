# dev_menu

DevMenu - flutter plugin.

Package made to make team members(Dev,QA,PM) life easier while in development. Easily find out device/app info, turn certain features on and off, and preview your WIP Widgets in `Test Playground`.

# Installation

Add `dev_menu:` as a [dependency in your pubspec.yaml](https://flutter.dev/docs/development/packages-and-plugins/using-packages) file.

![Dev_menu gif](https://media.giphy.com/media/dXXS7VQrj6d6AcGU9p/giphy.gif)


## Information

`packageName` (Mandatory) is package name (Android: applicationId). For example: _"com.example.dev_menu_example"_
*Note*: This is not needed for iOS, since there is no way of using this String to get the application data.

`flags` is list of maps, contaning _title_, and _description_. They are used to turn certain features/test on and off. Working with the help of _Shared preferences_.

Example:
```
[
  {
    'title': 'Is Environment button enabled?',
    'description': 'Determine if Environment button should work.',
  },
]
```

`testWidgets` is list of widgets provided for Test playground screen of plugin. Usually widgets which are not yet connected with the Apps flow, or work in progress stuff.

Example:
```
[
  {
    'name': 'Alert dialog',
    'widget': AlertDialog(
      title: Text('Title'),
      content: Text('Content'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Center(
            child: Text('Button 1'),
          ),
        ),
        FlatButton(
          onPressed: () {},
          child: Center(
            child: Text('Button 2'),
          ),
        )
      ],
    ),
  },
  {
    'name': 'Sized box',
    'widget': SizedBox(
      width: 300,
      height: 400,
      child: Container(
        color: Colors.red,
        child: Text('I am text in sized box'),
      ),
   )
  }
]
```

*Application info*:

| Name | Label | iOS | Android |
|--------|--------|-----|--------|
| Application name | appName | not available | [android app name](https://developer.android.com/guide/topics/manifest/manifest-intro#package-name) |
| Package name | packageName | not available | [android package name](https://developer.android.com/reference/android/content/pm/PackageInfo#packageName) |
| Version | versionName | not available | [android version](https://developer.android.com/reference/android/content/pm/PackageInfo#versionName)

Here you can also see any custom application info, provided by `customAppInfo`


`customAppInfo` is list of custom informations regarding the app. Contains _title_, initially _selected_ option, and list of all _options_. Using _Shared preferences_, selected will be read on the first run, afterwards selected is read from the phone memory.

Example:
```
[
  {
    'title': 'Environment',
    'selected': 'QA',
    'options': ['QA', 'DEV', 'PROD', 'STAGING']
  },
]
```


*Device info*:

Android:

| Name | description |
|--------|--------|
| version.securityPatch | [The user-visible security patch level](https://developer.android.com/reference/android/os/Build.VERSION#SECURITY_PATCH) |
| version.sdkInt | [The user-visible SDK version of the framework](https://developer.android.com/reference/android/os/Build.VERSION#PREVIEW_SDK_INT) |
| version.release | [The user-visible version string](https://developer.android.com/reference/android/os/Build.VERSION#RELEASE) |
| version.codename | [The current development codename, or the string "REL" if this is a release build](https://developer.android.com/reference/android/os/Build.VERSION#CODENAME) |
| version.baseOs | [The base OS build the product is based on](https://developer.android.com/reference/android/os/Build.VERSION#BASE_OS) |
| device | [The name of the industrial design](https://developer.android.com/reference/android/os/Build#DEVICE) |
| manufacturer | [The manufacturer of the product/hardware](https://developer.android.com/reference/android/os/Build#MANUFACTURER) |
| model | [The end-user-visible name for the end product](https://developer.android.com/reference/android/os/Build#MODEL) |
| product | [The name of the overall product](https://developer.android.com/reference/android/os/Build#PRODUCT) |
| androidId | [he Android hardware device ID that is unique between the device + user and app signing](https://developer.android.com/reference/android/os/Build#getSerial()) |

iOS:

| Name | description |
|--------|--------|
| name | [Device name](https://developer.apple.com/documentation/uikit/uidevice/1620015-name) |
| systemName | [The name of the current operating system](https://developer.apple.com/documentation/uikit/uidevice/1620054-systemname) |
| systemVersion | [The current operating system version](https://developer.apple.com/documentation/uikit/uidevice/1620043-systemversion) |
| model | [Device model](https://developer.apple.com/documentation/uikit/uidevice/1620044-model) |
| identifierForVendor | [Unique UUID value identifying the current device](https://developer.apple.com/documentation/uikit/uidevice/1620059-identifierforvendor) |
| utsname.sysname | [Operating system name](https://pubs.opengroup.org/onlinepubs/7908799/xsh/sysutsname.h.html) |
| utsname.nodename | [Network node name](https://pubs.opengroup.org/onlinepubs/7908799/xsh/sysutsname.h.html) |
| utsname.release | [Release level](https://pubs.opengroup.org/onlinepubs/7908799/xsh/sysutsname.h.html) |
| utsname.version | [Version level](https://pubs.opengroup.org/onlinepubs/7908799/xsh/sysutsname.h.html) |
| utsname.machine | [Hardware type](https://pubs.opengroup.org/onlinepubs/7908799/xsh/sysutsname.h.html) |
