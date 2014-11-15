var assert = require('assert')

// I'm not entirely sure how node is actually comparing
// the .fail ensure this is failure, but where/when is a comparison made?
// seems super low level, useful for building a testing library

assert.fail(1, 2, undefined ,"==" )


// http://cjohansen.no/en/node_js/unit_testing_node_js_apps
// for more discussion on testing
