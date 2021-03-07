SRC=src
DIST=${SRC}/dist
JS_INPUT=${SRC}/elm/SimpleFrontendProject.elm
JS_OUTPUT=${DIST}/app.js

.DEFAULT_GOAL := dev
.PHONY: clean
.PHONY: clean_js

clean: clean_js

clean_js:
	rm -rf ${JS_OUTPUT}

# Development #

dev: compile_to_js_for_development

compile_to_js_for_development: clean_js
	elm make ${JS_INPUT} --output=${JS_OUTPUT}
