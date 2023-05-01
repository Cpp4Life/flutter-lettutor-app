build-ios:
	flutter clean \
	&& flutter pub get \
	&& flutter build ios

build-pod:
	@echo "Starting building pod..."
	cd ios \
	&& rm -f Podfile.lock \
	&& rm -rf Pods \
	&& pod cache clean --all \
	&& pod deintegrate \
	&& pod setup \
	&& pod install \
	&& pod repo update
	@echo "Done"