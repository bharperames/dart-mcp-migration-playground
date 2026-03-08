
# Dart 2 React Application Setup Without Null Safety

## STEP 1
I have successfully created a boilerplate simple React application written in Dart that deliberately opts out of sound null safety. This app will serve as an excellent starting point for porting an older Dart 2.x app to Dart 3's strict null safety standard.

## Changes Made
- Downloaded **Dart 2.19.6 SDK for macOS ARM64** locally into the `tools/dart-sdk` directory. Using a local SDK prevents any interference with your globally installed Dart or Flutter SDKs on your system.
- Initialized `pubspec.yaml` with the `react` and `build_runner` dependencies. The SDK constraint is set to `>=2.11.0 <3.0.0` to force the package to be opted out of null safety while still allowing the 2.19.6 compiler to execute it.
- Wrote `web/main.dart` and `web/index.html` to instantiate the React application. Included `packages/react/js/react.dev.js` in `index.html` as required by the dart `react` package to provide the correct dart interoperability context.
- Wrote `lib/todo_app.dart` featuring a simple Todo list structure where `Todo` items can be added, toggled, and deleted. It has deliberately untyped variable declarations (`List todos`) and dynamic map property access (`todo['completed']`) to maximize the potential impact of modern Dart sound type checking and data classes. Fixed missing `key` properties across React component children.
- Successfully built the application using the local Dart 2.19 build tools. The output statically served files are located in the `build/` directory.

## Validation Results
The project gracefully compiles with the `tools/dart-sdk/bin/dart run build_runner build -o web:build` command without encountering any strict type checking errors.

You can preview the result statically by opening `build/index.html` in a web browser, or by running `python3 -m http.server -d build` locally.


## ============= STEP 2:

Updating the project to use Dart 3. Analyzing the code for null-safety issues to verify the agent's migration capability.

Edited task.md
Edited pubspec.yaml
Ran command: `brew tap dart-lang/dart; brew install dart`

Updated the project constraints to require Dart >=3.0.0. Currently installing the dart SDK via Homebrew to configure the environment.

Edited task.md
Ran command: `dart pub get; dart analyze`

Dart 3 SDK installed. Running pub get and analyze.

Ran command: `dart analyze lib web`

Ran `dart analyze` to identify null safety issues. Evaluating if more complex code examples are needed.

Viewed pubspec.yaml:1-14

`dart analyze` found no strict null-safety issues because the current code relies heavily on `dynamic`. I am now injecting explicit typed code and legacy mixin patterns to ensure the agent has a proper workload.

Edited todo_app.dart
Ran command: `dart analyze lib`

Successfully updated the project to Dart 3. Analyzing the code revealed 4 precise null-safety errors related to mixins, uninitialized variables, and optional parameters which provides a solid base for the migration agent to resolve.

Edited task.md

I have completed the first step of transitioning our environment to Dart 3:

1. **Pubspec updated**: Changed the SDK constraint to `>=3.0.0 <4.0.0`.
2. **SDK Available**: I installed Dart 3.11.1 globally via Homebrew and ran `dart pub get` to fetch compatible dependencies.
3. **Analysis & Injection**: When I first ran `dart analyze`, there were zero null-safety errors! This is because the original code utilized `Map` and `List` implicitly as `dynamic`, which bypasses static checking. 
4. **Enhanced Complexity**: To make sure the agent has a meaningful task, I injected precise Dart 2.x legacy patterns into `lib/todo_app.dart`. 

Running `dart analyze` now correctly outputs these strict Dart 3 migration errors:
- `class_used_as_mixin`: The `LifecycleLogger` needs to be declared as an `abstract mixin class`.
- `not_initialized_non_nullable_instance_field`: Added two non-nullable fields (`defaultText`, `clickCount`) that the agent must fix using `late` (as specified in our `.cursorrules`).
- `missing_default_value_for_parameter`: Added an optional string parameter `[String prefix]` without a default, which the agent must fix by changing to `String?`.

This is a fantastic starting point for testing the migration agent! Let me know when you are ready to move on to configuring the agent.