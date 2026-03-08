.PHONY: test-dart2 analyze-dart3 setup

# Target 1: Build using the local Dart 2.x SDK (Pre-migration state)
# Uses the Dart 2.19.6 SDK installed in tools/dart-sdk to avoid relying on the global system path
test-dart2:
	@echo "--- Building with local Dart 2.19.6 SDK ---"
	./tools/dart-sdk/bin/dart run build_runner build -o web:build --delete-conflicting-outputs
	@echo "--- Dart 2 Build Complete ---"

# Target 2: Analyze using the global Dart 3 SDK (Migration state)
# Uses the globally installed Dart 3 to expose all of the modern null-safety errors
analyze-dart3:
	@echo "--- Analyzing with global Dart 3 SDK ---"
	@echo "Note: It is expected that this fails and outputs migration errors."
	dart analyze lib web

setup:
	@echo "Run 'make test-dart2' to compile using the pre-null-safety Dart SDK."
	@echo "Run 'make analyze-dart3' to view the strict null-safety refactoring targets."
