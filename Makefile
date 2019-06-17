PACKAGE=asso
BUILD_DIR=build

build/$(PACKAGE): build $(PACKAGE)/*.pony
	ponyc $(PACKAGE) -o $(BUILD_DIR) --debug

build:
	mkdir $(BUILD_DIR)

run: build/$(PACKAGE)
	build/$(PACKAGE)

clean:
	rm -rf build

.PHONY: clean test
