const
  watch = require('node-watch'),
  fs = require('fs'),
  exec = require('child_process').exec,
  suffixesForJsRecompilation = ['elm'],
  compilationTimeout = 500;

let
  jsCompilationTimeoutId = null;

const shouldFileTriggerRecompilation = function(filename, interestingSuffixes) {
  const
    shards = filename.split('.'),
    suffix = shards[shards.length - 1],
    isSuffixForRecompilation = function(suffixForRecompilation) {
      return suffix == suffixForRecompilation;
    };

  if(suffix && interestingSuffixes.find(isSuffixForRecompilation)) {
    return true;
  } else {
    return false;
  }
}

const debounce = function(timeoutId, f) {
  if(timeoutId) {
    clearTimeout(timeoutId);
  }

  return setTimeout(f, compilationTimeout);
}

const runTask = function(task) {
  exec(task, function(err, stdoutput, stderrput) {

    if(err) {
      console.error(err.toString())
      console.error('Failure');
    } else {
      if(stdoutput) {
        console.log(stdoutput);
        console.log('Success');
      }

      if(stderrput) {
        console.error(stderrput);
        console.error('Something went wrong');
      }

    }
  });
}

const compileJs = function() {
  console.log('');
  console.log('Compiling JS');

  runTask('make compile_to_js_for_development');
}

const compile = function() {
  console.log('Compiling ...');

  runTask('make dev');
}

compile();

watch('src/elm', { recursive: true }, (eventType, filename) => {
  if(shouldFileTriggerRecompilation(filename, suffixesForJsRecompilation)) {
    jsCompilationTimeoutId = debounce(jsCompilationTimeoutId, compileJs);
  }
});
