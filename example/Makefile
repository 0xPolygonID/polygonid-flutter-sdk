
# Reusable Makefile
# ------------------------------------------------------------------------
# This section of the Makefile should not be modified, it includes
# commands from my reusable Makefile: https://github.com/rowanmanning/make
-include node_modules/@rowanmanning/make/javascript/index.mk
# [edit below this line]
# ------------------------------------------------------------------------

# Configuration tasks
# -------------------

# Configure the application for local development
config: .env

# Duplicate the sample environment variable file
.env:
	@echo "Creating .env file from env.sample"
	@cp ./env.sample ./.env;
	@$(TASK_DONE)
