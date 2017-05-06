// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


// REFACTOR AJAX FUNCTIONS

const avalible_tokens = { 'Wild': 'ASKIatDc2KHFm-8D_6ZYTMv68a85FLv7CxrMVuBD9uZkCYArLAAAAAA',
                          'Sweet': 'Af1TaYudagla5TYwigWONK1IFX7QFLv5lps5Qf5D-idtVqAzHAAAAAA',
                          'Hair': 'Ae7GWbSWQBPIFGoUljDIAqPRYRKZFLv7psXrKX1D-ikzwyAsrAAAAAA' };
var token;
var followersUrl;
var followingUrl;
var unsubUrl;
var fsUsers = [];
var fingUsers = [];
var bastards = [];

function setUrls(account) {
  token = avalible_tokens[account];
  followersUrl = "https://api.pinterest.com/v1/me/followers/?access_token=" + token + "&fields=url&limit=100";
  followingUrl = "https://api.pinterest.com/v1/me/following/users/?access_token=" + token + "&limit=100";
}

function clearCache() {
  fsUsers = [];
  fingUsers = [];
  bastards = [];
  $('.followers-list').empty();
  $('.following-list').empty();
  $('.bastards-list').empty();
}

function getFsUsers(url) {
  $.get({
    dataType: 'json',
    url: url,
    async: false,
    success: function(data) {
      data['data'].forEach(function(item) {
        fsUsers.push(item['url']);
      })
      getFsUsers(data['page']['next']);
    }
  });
}

function getFiUsers(url) {
  $.get({
    dataType: 'json',
    url: url,
    async: false,
    success: function(data) {
      data['data'].forEach(function(item) {
        fingUsers.push(item['url']);
      })
      getFiUsers(data['page']['next']);
    }
  });
}

function unSubBastards() {
  bastards.forEach(function(bas) {
    $.ajax({
      url: unsubUrl,
      type: 'DELETE',
      async: false,
      success: function() {
        console.log(bas + ' - DONE!');
      },
      fail: function() {
        console.log(bas + ' - ERR!');
      }
    });
  });
}

function parseUsers() {
  getFsUsers(followersUrl);
  getFiUsers(followingUrl);
  calculateBastards();
  visualiseResults();
}

// Refactor dis
function visualiseResults() {
  fsUsers.forEach(function(us) {
    $('.followers-list').append('<div>' + us + '</div>');
  });
  fingUsers.forEach(function(us) {
    $('.following-list').append('<div>' + us + '</div>');
  });
  bastards.forEach(function(us) {
    $('.bastards-list').append('<div><span class="bast"> ' + us + ' </span></div>');
  });
}

function calculateBastards() {
  fingUsers.forEach(function(user) {
    if (fsUsers.indexOf(user) < 0) {
      bastards.push(user.split('/')[3]);
    }
  })
}

function getFinalBastards() {
  var finalBastards = [];
  $(".bastards-list").find('.bast').each(function() {
    finalBastards.push(this.innerText);
  });
  return finalBastards;
}

// Enter here

$( document ).ready(function() {
  $("#parse").click(function() {
    setUrls($('#account').val());
    $('#remove').show();
    clearCache();
    parseUsers();
  });

  $("#remove").click(function() {
    if( ! confirm("Do you really want to do this?") ){
      e.preventDefault();
    }
    unSubBastards(getFinalBastardsList());
  });

  $(".bastards-list").on('click', '.bast', function() {
    $(".safe-bastards-list").append('<div><span class="bast"> ' + this.innerText + ' </span></div>');
  })

});


