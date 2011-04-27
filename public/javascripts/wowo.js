var Editor = function(config) {
  var self;
  self = $.extend(true, {
    form : $('form#wowo_form'),
    
    // edit mode - CREATE or UPDATE
    mode : {
      current : '',
      publishPaths : {
        CREATE : '',
        UPDATE : ''
      },
      publishPath : function() {
        return self.mode.publishPaths[this.current];
      },
      publishData : function() {
        if (self.mode.current === 'CREATE') {
          return self.form.serialize();                
        } else if (self.mode.current === 'UPDATE') {
          return self.form.serialize() + '&_method=PUT';
        }
        return '';
      }
    },
    
    // wowo actions
    destroy :
      function () {
        if (self.mode.current === 'CREATE') {
          window.location.href = self.mode.publishPath();
        } else {
          $('<form action="' + self.mode.publishPath() + '" method="post"><input type="hidden" name="_method" value="delete"/></form>')
            .appendTo('body')
            .submit();
        }
      },
    preview :
      function () {
        self.form.submit();
      },
    publish :
      function () {
        $('#publish').jqmShow();
      },
    publishing_overlay: null,
    publishing :
      function () {
        $('#publish').jqmHide();
        publishing_overlay = new Wait({
          id: 'publishing',
          message: 'Hang tight for a moment while we publish your wowo!'
        });
        publishing_overlay.show();
        $.ajax({
          data      : self.mode.publishData(),
          url       : self.mode.publishPath(),
          type      : 'post',
          dataType  : 'script'
        })
      },
    published :
      function (wowo) {
      
        var link;

        // publish zap to networks
        Networks.publish($('#share_message').val(), wowo);

        // link to show in "Your WoWo URL" and published popup
        link = '<a href="http://' + wowo.domain_name + '" target="_blank">' + wowo.domain_name + '</a>';

        $('#wowo_url')
          .show()
          .find('a')
          .replaceWith(link);

        if (publishing_overlay) {
          publishing_overlay.hide();
        }
        $('#published #published_url')
          .html(link);
        $('#published')
          .jqmShow();
        
        // since we may have changed layout, update component_action_panel position
        self.componentActionPanel.insertionPoints.rebuild();
        self.componentActionPanel.moveTo(self.componentActionPanel.insertionPoints.current, false);
      }
  }, config);
  
  self.componentActionPanel = new ComponentActionPanel();
  self.theme_scroller = new ThemeScroller();
  self.wowoActionPanel = new WoWoActionPanel(self);

  $('#publish, #published').detach().appendTo('body').jqm();

	//initialize
  $(function() {
        
    // show the currently selected theme in scroller
    $('#themes .theme.selected').prevAll().detach().appendTo('#themes');
    
    // set up theme click selection
    $('#themes .theme').click(function() {
      $('#themes .theme').removeClass('selected');
      $(this).addClass('selected');
      $('#wowo_theme_id').val($(this).attr('id'));
    })
    
    // hide the insert prompt if components already exist
    if ($('.sortable_container').length > 0) {
      $('#component_insert_prompt').hide();
    }
      
  })

  return self;
}

// define WoWoActionPanel
var WoWoActionPanel = function(editor) {
  
  // save reference to this
  var BOTTOM_PADDING = 35,
      footerHeight,
      panel;

  // ui setup
  $(function() {
    // create DOM components
    var publishButton =
          $('<button id="publish_button">Publish & Share</button>')
            .click(function() {
              editor.publish();
            }),
        previewButton =
          $('<button id="preview_button">Preview</button>')
            .click(function() {
              editor.preview();
            }),
        deleteButton =
          $('<button id="delete_button">Delete</button>');

    // "memoize" footer height  
    // TODO change the #layout_footer to #footer
    footerHeight = $('#layout_footer').outerHeight();

    panel = $('<div id="wowo_action_panel"></div>')
      .append(publishButton)
      .append(previewButton)
      .append(deleteButton)
      .appendTo('body');

    new Confirm({
      id: 'confirm_wowo_delete',
      target: deleteButton,
      message: 'Are you sure you want to delete this?',
      confirmText: 'Delete',
      confirmCallback: function() {
        editor.destroy();
      }
    });

    reposition();  
  
  })


  // make sure the panel is BOTTOM_PADDING above the footer or the window bottom, whichever is higher
  var reposition =
    function() {
      var w = $(window),
          viewTop = w.scrollTop(),
          viewHeight = w.height(),
          docHeight = $(document).height();
      
      // panel may not be loaded yet
      if (!panel){ return };

      if (viewTop + viewHeight > docHeight - footerHeight) {
        panel.css({bottom: (viewTop + viewHeight + footerHeight - docHeight) + BOTTOM_PADDING });
      } else {
        panel.css({bottom: BOTTOM_PADDING});
      }
    };

  // update positioning on window scroll or resize
  $(window).bind(
    "scroll resize load ready",
    reposition
  );
  
}
// end define WoWoActionPanel