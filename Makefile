PACKAGE=asso
BUILD_DIR=build
TEST_BINARY=test

build/test: build $(PACKAGE)/test/*.pony
	ponyc $(PACKAGE)/test -o $(BUILD_DIR) --bin-name $(TEST_BINARY) --debug

build/$(PACKAGE): build $(PACKAGE)/*.pony
	ponyc $(PACKAGE) -o $(BUILD_DIR) --debug

build:
	mkdir $(BUILD_DIR)

test: build/$(TEST_BINARY)
	build/$(TEST_BINARY)

run: build/$(PACKAGE)
	build/$(PACKAGE)

clean:
	rm -rf build

.PHONY: clean test
