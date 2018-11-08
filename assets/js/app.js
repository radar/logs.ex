// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"


var $ = require('jquery');

$.fn.highlight = function() {
  $('.highlight').removeClass("highlight");
  this.parent().addClass("highlight");
}

$(document).ready(function() {
  if (document.location.hash) {
    $(document.location.hash).highlight()
  }

  $('.anchor').click(function() { $(this).highlight() });

  $('.join, .part, .quit').hide();

  $('#show_events').change(function (event) {
    var target = $(event.target);
    if (target.is(":checked")) {
      $('.join, .part, .quit').show();
    } else {
      $('.join, .part, .quit').hide();
    }
  });
})
