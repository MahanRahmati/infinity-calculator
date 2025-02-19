get:
	flutter pub get

clean:
	flutter clean
	flutter pub get

native_splash:
	dart run flutter_native_splash:create

native_splash_remove:
	dart run flutter_native_splash:remove

localizations:
	cd packages/app_localizations/ && dart run slang

models:
	cd packages/app_models/ && dart run build_runner build --delete-conflicting-outputs

providers:
	cd packages/app_providers/ && dart run build_runner build --delete-conflicting-outputs

router:
	cd packages/app_router/ && dart run build_runner build --delete-conflicting-outputs

clean_lint:
	find . -name "custom_lint.log" -type f -delete

launcher_icons:
	dart run icons_launcher:create

build_android:
	flutter build apk --release --target-platform android-arm64
