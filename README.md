<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A data synchronization tool based on [Event Sourcing and CQRS](https://medium.com/swlh/event-sourcing-as-a-ddd-pattern-fea6de35fcca).
An "event" is analogous to a serialized command that can be executed.
An event's order of execution within the system is relatively subjective until it has been added to the server,
at which point it has a permanently fixed order in the history of events.

This package is designed to communicate with a specific API specification.

Some benefits of our sync design include:

* offline-first - continue to work while offline or online.
* eventual consistency - everyone will eventually see the same data.
* ZERO data loss - every single edit is permanently recorded in a read-only log.
* invisible conflict resolution - conflicting edits are automatically and silently resolved without user intervention.
* historical reporting - view historical snapshots of the data.
* data recovery - any edit can be reverted.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.

### Code Generation

We are using some packages and features that generate code for us automatically.
Run the following command to generate the code.
```bash
flutter packages pub run build_runner build
```