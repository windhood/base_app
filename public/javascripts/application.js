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
