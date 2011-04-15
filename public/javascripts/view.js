/*   Copyright (c) 2010, Windhood Inc.  See
*   the COPYRIGHT file.
*/
var View = {
  initialize: function() {
    /* Buttons */
    $("input[type='submit']").addClass("button");

    /* Tooltips */
    this.tooltips.bindAll();

    /* Animate flashes */
    this.flashes.animate();

    /* In field labels */
    $("label").inFieldLabels();
		
		/* Getting started animation */
    $(this.gettingStarted.selector)
      .live("click", this.gettingStarted.click);

    /* User menu */
    $(this.userMenu.selector)
      .click(this.userMenu.click);

    /* Autoexpand textareas */
    $('textarea')
      .autoResize({
        'animate': false,
        'extraSpace': 0
      });

    $(document.body)
      .click(this.userMenu.removeFocus)
      .click(this.reshareButton.removeFocus);
  },

  
  debug: {
    click: function() {
      $("#debug_more").toggle("fast");
    },
    selector: "#debug_info"
  },

  flashes: {
    animate: function() {
      var $this = $(View.flashes.selector);
      $this.animate({
        top: 0
      }).delay(2000).animate({
        top: -100
      }, $this.remove)
    },
    selector: "#flash_notice, #flash_error, #flash_alert"

  },

  gettingStarted: {
    click: function() {
      var $this = $(this);
      $this.animate({
        left: parseInt($this.css("left"), 30) === 0 ? -$this.outerWidth() : 0
      }, function() {
        $this.css("left", "1000px");
      });
    },
    selector: ".getting_started_box"
  },
  
  tooltips: {
    avatars: {
      bind: function() {
        $(".contact_pictures img.avatar, #manage_aspect_zones img.avatar").tipsy({
          live: true
        });
      }
    },

    public_badge: {
      bind: function() {
        $(".public_badge img").tipsy({
          live: true
        });
      }
    },

    whatIsThis: {
      bind: function() {
        $(".what_is_this").tipsy({
          live: true,
          delayIn: 400
        });
      }
    },

    bindAll: function() {
      for(var element in this) {
        if(element !== "bindAll") {
          this[element].bind();
        }
      };
    }
  },

  reshareButton: {
    removeFocus: function(evt) {
      var $target = $(evt.target);
      if(!$target.closest(".reshare_pane").length) {
        $(".reshare_button.active").removeClass("active").siblings(".reshare_box").css("display", "none");
      }
    }
  },

  userMenu: {
    click: function() {
      $(this).toggleClass("active");
    },
    removeFocus: function(evt) {
      var $target = $(evt.target);
      if(!$target.closest("#user_menu").length) {
        $(View.userMenu.selector).removeClass("active");
      }
    },
    selector: "#user_menu"
  }
};

$(function() {
  /* Make sure this refers to View, not the document */
  View.initialize.apply(View);
});
