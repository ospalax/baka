#
# Copyright (2019) Petr Ospalý <petr@ospalax.cz>
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

# make config file - it provides mandatory values
include Makefile.config

# customized make config file - it can be generated with the configure script
-include Makefile.custom

.PHONY: all clean install release debug depend

all: release

release: $(RELEASE_DIR)/bin/$(PROGRAM) $(RELEASE_DIR)/lib/lib$(PROGRAM).a
	@printf '\n# MAKE -> BUILD ($@) DONE\n\n'

debug: $(DEBUG_DIR)/bin/$(PROGRAM) $(DEBUG_DIR)/lib/lib$(PROGRAM).a
	@printf '\n# MAKE -> BUILD ($@) DONE\n\n'

depend: $(BUILD_DIR)/.depend
$(BUILD_DIR)/.depend: $(SOURCE_FILES)
	@printf '\n# MAKE -> Find header files dependencies...\n\n'
	@mkdir -p "$(BUILD_DIR)"
	$(CC) -MM $(SOURCE_FILES) > "$(BUILD_DIR)"/.depend
	@sed "s#.*#${RELEASE_DIR}/&#" "$(BUILD_DIR)"/.depend > "$(BUILD_DIR)"/.depend-release
	@sed "s#.*#${DEBUG_DIR}/&#" "$(BUILD_DIR)"/.depend > "$(BUILD_DIR)"/.depend-debug
	@cat "$(BUILD_DIR)"/.depend-* > "$(BUILD_DIR)"/.depend

include $(BUILD_DIR)/.depend

$(RELEASE_DIR)/bin/$(PROGRAM): $(RELEASE_OBJECTS)
	@printf '\n# MAKE -> Build baka program: $@\n\n'
	@mkdir -p "$(RELEASE_DIR)/bin"
	$(CC) $(CFLAGS) $(INCLUDES) $(LIBS) $^ -o $@

$(DEBUG_DIR)/bin/$(PROGRAM): $(DEBUG_OBJECTS)
	@printf '\n# MAKE -> Build baka program (DEBUG): $@\n\n'
	@mkdir -p "$(DEBUG_DIR)/bin"
	$(CC_DEBUG) $(CFLAGS_DEBUG) $(INCLUDES) $(LIBS) $^ -o $@

$(RELEASE_DIR)/lib/lib$(PROGRAM).a: $(filter-out %/main.o, $(RELEASE_OBJECTS))
	@printf '\n# MAKE -> Create static library: $@\n\n'
	@mkdir -p "$(RELEASE_DIR)/lib"
	ar -cvru $@ $^

$(DEBUG_DIR)/lib/lib$(PROGRAM).a: $(filter-out %/main.o, $(DEBUG_OBJECTS))
	@printf '\n# MAKE -> Create static library (DEBUG): $@\n\n'
	@mkdir -p "$(DEBUG_DIR)/lib"
	ar -cvru $@ $^

$(RELEASE_DIR)/%.o: $(SOURCE_DIR)/%.c $(DEPS)
	@printf '\n# MAKE -> Build module: $@\n'
	@printf '          Dependencies: $^\n\n'
	@mkdir -p "$(RELEASE_DIR)"
	$(CC) $(CFLAGS) $(INCLUDES) $(LIBS) -c $< -o $@

$(DEBUG_DIR)/%.o: $(SOURCE_DIR)/%.c $(DEPS)
	@printf '\n# MAKE -> Build module (DEBUG): $@\n'
	@printf '          Dependencies: $^\n\n'
	@mkdir -p "$(DEBUG_DIR)"
	$(CC_DEBUG) $(CFLAGS_DEBUG) $(INCLUDES) $(LIBS) -c $< -o $@

clean:
	@printf "\n# MAKE -> Delete all object files\n\n"
	rm -vf "$(RELEASE_DIR)/"*.o "$(DEBUG_DIR)/"*.o
	@printf '\n# MAKE -> CLEANUP DONE\n\n'

# single quote is mandatory for BAKA_* variables so shell expansion can work...
install: release
	@printf "\n# MAKE -> Running the installation script...\n\n"
	@env \
	CC="$(CC)" \
	CFLAGS="$(CFLAGS)" \
	LIBS="$(LIBS)" \
	INCLUDES="$(INCLUDES)" \
	SOURCE_DIR="$(SOURCE_DIR)" \
	BUILD_DIR="$(RELEASE_DIR)" \
	BAKA_HOME='$(BAKA_HOME)' \
	BAKA_CONFIG='$(BAKA_CONFIG)' \
	BAKA_SCRIPT='$(BAKA_SCRIPT)' \
	tools/install.sh
	@printf '\n# MAKE -> INSTALLATION DONE\n\n'
