PACKAGE=asso
BUILD_DIR=build

build/test: 
	ponyc $(PACKAGE)/test -o $(BUILD_DIR) --bin-name $(PACKAGE) --debug

build/$(PACKAGE):
	ponyc $(PACKAGE) -o $(BUILD_DIR) --debug

build:
	mkdir $(BUILD_DIR)

test: 
	build/$(PACKAGE)

clean:
	rm -rf build

.PHONY: clean test
