.PHONY: build clean rebuild test run list release

# Variables
PROJECT_NAME = CHTCollectionViewWaterfallLayoutDemo
SCHEME = CHTCollectionViewWaterfallLayoutDemo
PROJECT_DIR = CHTCollectionViewWaterfallLayoutDemo
PROJECT_FILE = $(PROJECT_DIR)/$(PROJECT_NAME).xcodeproj
SDK = iphonesimulator
CONFIGURATION = Debug
DESTINATION = 'platform=iOS Simulator,name=iPhone 16'

# Build the project
build:
	@echo "Building $(PROJECT_NAME)..."
	cd $(PROJECT_DIR) && xcodebuild \
		-project $(PROJECT_NAME).xcodeproj \
		-scheme $(SCHEME) \
		-configuration $(CONFIGURATION) \
		-sdk $(SDK) \
		-destination $(DESTINATION) \
		build

# Clean build artifacts
clean:
	@echo "Cleaning $(PROJECT_NAME)..."
	cd $(PROJECT_DIR) && xcodebuild \
		-project $(PROJECT_NAME).xcodeproj \
		-scheme $(SCHEME) \
		-configuration $(CONFIGURATION) \
		clean

# Clean and rebuild
rebuild: clean build

# Run tests
test:
	@echo "Running tests for $(PROJECT_NAME)..."
	cd $(PROJECT_DIR) && xcodebuild \
		-project $(PROJECT_NAME).xcodeproj \
		-scheme $(SCHEME) \
		-configuration $(CONFIGURATION) \
		-sdk $(SDK) \
		-destination $(DESTINATION) \
		test

# Build and run on simulator
run: build
	@echo "Launching $(PROJECT_NAME) on simulator..."
	xcrun simctl boot "iPhone 16" 2>/dev/null || true
	open -a Simulator
	xcrun simctl install booted $(PROJECT_DIR)/build/$(CONFIGURATION)-iphonesimulator/$(PROJECT_NAME).app || \
		xcrun simctl install booted ~/Library/Developer/Xcode/DerivedData/$(PROJECT_NAME)-*/Build/Products/$(CONFIGURATION)-iphonesimulator/$(PROJECT_NAME).app
	xcrun simctl launch booted io.github.arimura.$(PROJECT_NAME)

# List project information
list:
	@echo "Listing project information..."
	cd $(PROJECT_DIR) && xcodebuild -list

# Release build
release:
	@echo "Building $(PROJECT_NAME) in Release mode..."
	cd $(PROJECT_DIR) && xcodebuild \
		-project $(PROJECT_NAME).xcodeproj \
		-scheme $(SCHEME) \
		-configuration Release \
		-sdk $(SDK) \
		-destination $(DESTINATION) \
		build
