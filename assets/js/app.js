// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"

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

import jQuery from 'jquery';
window.jQuery = window.$ = jQuery; // Bootstrap requires a global "$" object.
import "bootstrap";


window.editTimeBlock = (ev) => {
  $("data-timeblock-id").show();
  let task_id = $(ev).data('task-id');
  let start_time = $("#addnew-timeblock").val();
  let end_time = $("#endnew-timeblock").val();

  console.log(start_time)
  console.log(end_time)
  //Check not empty
  if (start_time !== "" && end_time !== "") {
      let text = JSON.stringify({
          timeblock: {
              task_id: task_id,
              start_time: new Date(start_time),
              end_time: new Date(end_time),
          },
      });

      $.ajax("/ajax/timeblocks", {
          method: "put",
          dataType: "json",
          contentType: "application/json; charset=UTF-8",
          data: text,
          success: (resp) => {
              location.reload();
          },
      });

  } else {
      location.reload();
  }
}

window.deleteTimeBlock = (ev) => {
  let timeblock_id = $(ev).data('timeblock-id');

  $.ajax("/ajax/timeblocks/" + timeblock_id, {
      method: "delete",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      success: (resp) => {
          location.reload();
      },
  });
}

var START_TIME = "";
$(function () {
  let start_button = $('#start-timeblock-button');
  let stop_button = $('#stop-timeblock-button');

  stop_button.hide();

  start_button.click((ev) => {
      START_TIME = new Date();
      console.log(START_TIME);
      start_button.hide();
      stop_button.show();
  });

  stop_button.click((ev) => {
      let END_TIME = new Date();
      let task_id = $(ev.target).data('task-id');
      start_button.show();
      stop_button.hide();
      console.log(START_TIME);
      console.log(END_TIME);
      console.log(task_id);

      let text = JSON.stringify({
          timeblock: {
              task_id: task_id,
              start_time: START_TIME,
              end_time: END_TIME,
          },
      });

      $.ajax("/ajax/timeblocks", {
          method: "post",
          dataType: "json",
          contentType: "application/json; charset=UTF-8",
          data: text,
          success: (resp) => {
              location.reload();
          },
      });
  });
});
