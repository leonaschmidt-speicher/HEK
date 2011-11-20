// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require slider
//= require rating
//= require_tree .

$(document).ready(function() {
  if ($("#bewohnerzimmer").length) {
    $("article ul a").each(function(index) {
      $(this).click(function() {
        $("article .swap-view ol").animate({"margin-left": -index*460}, 300);
        return false;
      });
    }).anchorAnimate();
    /*$("a[href~=" + window.location.hash + "]").click();*/
  }
  if ($("#gemeinschaftsraeume").length) {
    var resize = function() {
      var totalWidth = 0;
      $("#main article").width("auto");
      $("#main article > img").each(function(index, value) {
        var element = $(value);
        if (0.669375*$(window).width() < $(window).height()) { /*0.669375 = height/width*/
          element.width("auto");
          element.height($(window).height());
        }
        else {
          element.width($(window).width());
          element.height("auto");
        }
        totalWidth += element.width();
      });
      $("#main").width(totalWidth);
    };
    resize();
    $(window).resize(resize);

    /*var scroll = function() {
      if ($(scrollElement + ":not(:animated)").length) {
        var index = Math.floor(($(scrollElement).attr("scrollLeft") + $(window).width() / 2) / $("#main article:first-child > img").width());
        var anchor = "#" + $("#main article").eq(index).attr("id");
        updatePreviousAndNextButtons(anchor);
        //var link = $("aside nav a[href='" + anchor + "']:not(.previous):not(.next)");
        //if (!link.hasClass("current")) link.click();
      }
    };*/

    var firstAnchor = $("aside nav a[href]:first").attr("href");
    var lastAnchor = $("aside nav a[href]:last").attr("href");
    var updateButton = function(name, target, alternative) {
      var href = target.attr("href");
      if (href == null) href = alternative;
      $("aside nav ." + name).attr("href", href);
    };
    var updatePreviousAndNextButtons = function(anchor) {
      if (anchor == null || anchor == "") anchor = firstAnchor;
      var element = $("aside nav a[href='" + anchor + "']:not(.previous):not(.next)");
      var prev = element.prev("a");
      if (prev.attr("href") == null) {
        var prevBox = element.parent().prev("div");
        if (prevBox != null) prev = prevBox.find("a:last-child");
      }
      updateButton("previous", prev, firstAnchor);
      var next = element.next("a");
      if (next.attr("href") == null) {
        var nextBox = element.parent().next("div");
        if (nextBox != null) next = nextBox.find("a:first-child");
      }
      updateButton("next", next, lastAnchor);
      $("aside nav a").removeClass("current");
      element.addClass("current");
    };
    $("aside nav a").anchorAnimate();
    $("aside nav a").click(function() { updatePreviousAndNextButtons($(this).attr("href")) });
    updatePreviousAndNextButtons(window.location.hash);
    $("aside nav a[class]").show();

    /*$(window).scroll(scroll);*/
  }
  if ($("#lage").length) {
    var latlng = new google.maps.LatLng(49.015705, 8.397074);
    var options = {
      zoom: 15,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      mapTypeControlOptions: {
        style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
        position: google.maps.ControlPosition.LEFT_BOTTOM
      },
      panControlOptions: {
        position: google.maps.ControlPosition.LEFT_BOTTOM
      },
      zoomControlOptions: {
        style: google.maps.ZoomControlStyle.LARGE,
        position: google.maps.ControlPosition.LEFT_BOTTOM
      }
    };
    var map = new google.maps.Map(document.getElementById("map"), options);
    var kmlOptions = {
      preserveViewport: true
    };
    var kmlLayer = new google.maps.KmlLayer("http://maps.google.com/maps/ms?ie=UTF8&authuser=0&msa=0&output=kml&msid=200127856091292256284.0004a582e344e99f9dbf5", kmlOptions);
    kmlLayer.setMap(map);
  }
  if ($("#geschichte").length) {
    $("aside").show();
    var firstArticle = $("article:first").attr("id");
    var lastArticle = $("article:last").attr("id");
    var updateButton = function(name, target, alternative) {
      var id = target.attr("id");
      if (id == null) id = alternative;
      $("aside nav ." + name).attr("href", "#" + id);
    };
    var updatePreviousAndNextButtons = function(anchor) {
      if (anchor == null || anchor == "") anchor = "#" + firstArticle;
      var element = $(anchor);
      updateButton("previous", element.prev("article"), firstArticle);
      updateButton("next", element.next("article"), lastArticle);
    };
    $("aside nav a").anchorAnimate({center: true});
    $("aside nav a").click(function() { updatePreviousAndNextButtons($(this).attr("href")) });
    updatePreviousAndNextButtons(window.location.hash);

    var resize = function() {
      $("#main").width(16632 + $(window).width() / 2 - 300 / 2);
      var mainMargin = $(window).width() / 2 - 320 / 2;
      $("#main").css("margin-left", mainMargin);
      var zeitstrahlMargin = -Math.ceil(mainMargin / 320) * 320;
      $("#zeitstrahl").css("margin-left", zeitstrahlMargin);
      $("#zeitstrahl").css("padding-right", -zeitstrahlMargin);
    };
    resize();
    $(window).resize(resize);
  }
  if ($("#tutoriate").length) {
    $("article nav a").anchorAnimate();
    $(".back-to-top").anchorAnimate();
  }
  if ($("#veranstaltungen").length) {
    $("article").each(function() {
      var article = $(this);
      article.find("ul a:has('img')").each(function(index) {
        $(this).click(function() {
          article.find(".swap-view ol").animate({"margin-left": -index*300}, 300);
          return false;
        });
      }).anchorAnimate();
    });
    /*$("a[href=" + window.location.hash + "]").click();*/
  }
  if ($("#bewerbung").length) {
    $(".steps").each(function() {
      $(this).find("a").each(function(index) {
        $(this).click(function() {
          var href = $(this).attr("href");
          $("#swap-view").animate({"margin-left": -index*960}, 300, function() {
            $(href + " :input:visible:enabled:first").focus();
            $(href + " .error:input:visible:enabled:first").focus();
          });
          return false;
        });
      }).anchorAnimate();
    });
    $(".steps").filter(":first").each(function() {
      $(this).find("a").each(function(index) {
        var href = $(this).attr("href");
        $("article nav a[href=" + href + "]").click(function() {
          $("#swap-view").animate({"margin-left": -index*960}, 300, function() {
            $(href + " :input:visible:enabled:first").focus();
            $(href + " .error:input:visible:enabled:first").focus();
          });
          return false;
        }).anchorAnimate();
      });
    });
    $("#bewerbung_hochschule").change(function() {
      if ($(this).val() == "BA") {
        $("#berufsakademie").slideDown(300);
      }
      else {
        $("#berufsakademie").slideUp(300);
      }
    });
    if ($("#bewerbung_hochschule").val() != "BA") {
      $("#berufsakademie").hide();
    }
    /*$("a[href~=" + window.location.hash + "]").click();*/
  }
  if ($("#kontakt").length) {
    var latlng = new google.maps.LatLng(49.015705, 8.397074);
    var options = {
      zoom: 13,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById("map"), options);
    var kmlLayer = new google.maps.KmlLayer("http://maps.google.de/maps/ms?msid=207764012482420932679.0004a744b55ca05071e35&msa=0&ll=49.018171,8.435783&spn=0.076666,0.181789&output=kml");
    kmlLayer.setMap(map);
  }
  if ($("#lage").length || $("#gemeinschaftsraeume").length) {
    $("header").hover(
      function() {
        $("header").animate({"height": 144}, 300);
        $("#show-navigation").fadeOut(300);
      },
      function() {
        $("header").animate({"height": 24}, 300);
        $("#show-navigation").fadeIn(300);
      }
    );
    $("header").css("height", 144);
    $("#show-navigation").hide();
    var timer = setTimeout(function() {
      $("header").animate({"height": 24}, 300);
      $("#show-navigation").fadeIn(300);
    }, 1000);
    $("header").mouseover(function() {
      clearTimeout(timer);
    });
  }
  $(".bewertung").rating({showCancel: false});
});