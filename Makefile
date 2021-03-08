SRC=src
DIST=${SRC}/dist
JS_INPUT=${SRC}/elm/SimpleFrontendProject.elm
JS_OUTPUT=${DIST}/app.js
JS_MIN_OUTPUT=${DIST}/app.min.js
JS_MIN_GZIPPED_OUTPUT=${JS_MIN_OUTPUT}.gz

.DEFAULT_GOAL := dev
.PHONY: clean
.PHONY: clean_js

clean: clean_js

clean_js:
	rm -rf ${JS_OUTPUT} ${JS_MIN_OUTPUT} ${JS_MIN_GZIPPED_OUTPUT}

# Development #

dev: compile_to_js_for_development

compile_to_js_for_development: clean_js
	elm make ${JS_INPUT} --output=${JS_OUTPUT}

# Production #

build: clean compile_to_js uglify_js gzip_js

compile_to_js:
	elm make ${JS_INPUT} --optimize --output=${JS_OUTPUT}

uglify_js:
	uglifyjs ${JS_OUTPUT} --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output ${JS_MIN_OUTPUT}

gzip_js:
	yes | gzip --keep --best --force ${JS_MIN_OUTPUT} > ${JS_MIN_GZIPPED_OUTPUT}
