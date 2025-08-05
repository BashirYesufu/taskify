# Taskify

## Getting Started
This repository contain the code for the provided assessment. This project was written using the Flutter 3.29.2 SDK and Dart programming Language. If you're new to Flutter and Dart, Check out the SDK at https://www.flutter.dev and the language at https://dart.dev/.

## How to Use

**Step 1:**

You must have Flutter and Dart Installed to build this project. Check the links above if you haven't done so. You might experience build issues running on a lower flutter version. If you don't have flutter ^3.0.0, You can use fvm to download it and manage your flutter version locally. I have included a link to it.

```
https://fvm.app/
```

Download or clone this repo by using the link below:

```
https://github.com/BashirYesufu/taskify.git
```

**Step 2:**

Create an env file called .env with a base 64 encryption key and your gemini api key. check the .env.example file for more context on what you env file should look like!

**Step 3:**

Run your simulator for iOS or android emulator and smash the build button. Easy!

## Architecture
The app follows a BLoC + Repository pattern combined with RxDart.
The architecture choice is informed by the simplicity of the project to be delivered, Other complex state management libraries and techniques could be employed but to keep it lightweight, this was used.

## Conclusion
May The Code be with you.
