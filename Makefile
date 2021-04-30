SRC=src
DIST=${SRC}/dist
JS_INPUT=${SRC}/elm/SimpleFrontendProject.elm
JS_OUTPUT=${DIST}/app.js
JS_MIN_OUTPUT=${JS_OUTPUT}.min
JS_MIN_GZIPPED_OUTPUT=${JS_MIN_OUTPUT}.gz

CSS_INPUT=src/scss/SimpleFrontendProject.scss
CSS_OUTPUT=${DIST}/app.css
CSS_MIN_OUTPUT=${CSS_OUTPUT}.min
CSS_MIN_GZIPPED_OUTPUT=${CSS_MIN_OUTPUT}.gz

.DEFAULT_GOAL := dev
.PHONY: clean
.PHONY: clean_js
.PHONY: clean_css

clean: clean_js clean_css

clean_js:
	rm -rf ${JS_OUTPUT} ${JS_MIN_OUTPUT} ${JS_MIN_GZIPPED_OUTPUT}

clean_css:
	rm -rf ${CSS_OUTPUT} ${CSS_MIN_OUTPUT} ${CSS_MIN_GZIPPED_OUTPUT}

# Development #

dev: compile_to_js_for_development compile_to_css_for_development

compile_to_js_for_development: clean_js
	elm make ${JS_INPUT} --output=${JS_OUTPUT}

compile_to_css_for_development: clean_css
	sass --no-source-map ${CSS_INPUT}:${CSS_OUTPUT}

# Production #

build: clean compile_to_js uglify_js gzip_js compile_to_css gzip_css

compile_to_js:
	elm make ${JS_INPUT} --optimize --output=${JS_OUTPUT}

uglify_js:
	uglifyjs ${JS_OUTPUT} --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output ${JS_MIN_OUTPUT}

gzip_js:
	yes | gzip --keep --best --force ${JS_MIN_OUTPUT} > ${JS_MIN_GZIPPED_OUTPUT}

compile_to_css:
	sass --no-source-map ${CSS_INPUT}:${CSS_MIN_OUTPUT} --style compressed

gzip_css:
	yes | gzip --keep --best --force ${CSS_MIN_OUTPUT} > ${CSS_MIN_GZIPPED_OUTPUT}
