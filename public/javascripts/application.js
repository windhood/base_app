$(function() {
  /* Make sure this refers to View, not the document */
  View.initialize.apply(View);
});

var View = {
  initialize: function() {
    /* Buttons */
    $("input[type='submit']").addClass("button");

    /* Tooltips */
    //this.tooltips.bindAll();

    /* Animate flashes */
    this.flashes.animate();

    /* In field labels */
    //$("label").inFieldLabels();
		
		/* Getting started animation */
    //$(this.gettingStarted.selector)
    //  .live("click", this.gettingStarted.click);

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
      .click(this.userMenu.removeFocus);
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
var Wait = function(config) {
  var self = $.extend({
    id : '',
    image : '/images/user/editor/wait.gif',
    message : '',
    overlay : null
  }, config);
  
  return {
    show : function() {
      self.overlay =
        $('<div id="' + self.id + '"><img src="' + self.image + '"/><p>' + self.message + '</p></div>')
          .appendTo('body')
          .jqm({modal:true})
          .jqmShow();
    },
    hide : function() {
      if (self.overlay) {
        self.overlay.jqmHide();
        self.overlay.remove();
      }
    }
  };

};


var Confirm = function(config) {
  var e,  // external interface
      popup,
      // config
      c = $.extend(true, {
        id: '',
        
        // needs to be a jquery object
        target          : null,
        message         : 'Are you sure?',
        confirmText     : 'Confirm',
        cancelText      : 'Cancel',
        confirmCallback : function () {},
        confirm         : function () { e.hide(); c.confirmCallback(); return false; },
        cancelCallback  : function () {},
        cancel          : function () { e.hide(); c.cancelCallback(); return false; }
      }, config);

  // target click
  if (c.target.click) {
    c.target.click(function() {
      e.show();
    })
  }
  
  // external interface
  return (e = {
    show: function () {
      var ot = c.target.offset();
      popup =
        $('<div id="' + c.id + '" class="confirm"></div>')
          .append('<p>' + c.message + '</p>')
          .append($('<a href="#" class="confirm_no">' + c.cancelText + '</a>').click(c.cancel))
          .append($('<a href="#" class="confirm_yes">' + c.confirmText + '</a>').click(c.confirm))
          .css({ top: ot.top, left: ot.left })
          .appendTo('body')
          .hide()
          .fadeIn();
      
      $(window).bind(
        'resize scroll',
        function() {
          e.hide();
        });
    },
    hide: function () {
      popup.fadeOut('fast', function() { popup.remove(); });
    }    
  });
  
}