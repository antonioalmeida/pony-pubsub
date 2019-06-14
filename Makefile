PACKAGE=asso
BUILD_DIR=build
TEST_BINARY=test

build/test: 
	ponyc $(PACKAGE)/test -o $(BUILD_DIR) --bin-name $(TEST_BINARY) --debug

build/$(PACKAGE):
	ponyc $(PACKAGE) -o $(BUILD_DIR) --debug

build:
	mkdir $(BUILD_DIR)

test: 
	build/$(TEST_BINARY)

run:
	build/$(PACKAGE)

clean:
	rm -rf build

.PHONY: clean test
