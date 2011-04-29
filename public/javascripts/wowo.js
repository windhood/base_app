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

// begin ComponentActionPanel
var ComponentActionPanel = function () {
  // save reference to this
  var self = this;
      
  $(function() {

    // swfupload object
    var swfu,
  
        // add text button
        addText =
          $('<div class="button" id="add_text"></div>')
            .click(function () {
              var component = $('#component_templates .text_component').clone();
          
              self.addComponent(component);      
            }),
            
        // add link button
        addLink =
          $('<div class="button" id="add_link"></div>')
            .click(function () {
                var component = $('#component_templates .link_component').clone();
            
                self.addComponent(component);     
              }),
            
        // add picture button
        addPicture =
          $('<div class="button" id="add_picture"></div>');
        
    // create DOM elements  
    self.panel =
      $('<div id="component_action_panel"></div>')
        .append(addPicture)
        .append(addText)
        .append(addLink)
        .appendTo('body');
  
    //
    // addPicture button
    //
    //  this needs to be initialized after the placeholder has been added to the
    //  DOM
    //
    swfu = 
      new SWFUpload({
        upload_url                : 'http://' + window.location.host + '/pictures.js',
        flash_url                 : '/swf/swfupload.swf',
        post_params : {
        },
        
        file_post_name            : 'file',
        
        button_placeholder_id     : 'add_picture',
        button_image_url          : '/images/user/editor/PictureButton.png',
        button_width              : 29,
        button_height             : 30,
        button_action             : SWFUpload.BUTTON_ACTION.SELECT_FILE,
        
        debug                     : false,
        swfupload_loaded_handler  : function () { },
        file_dialog_start_handler : function () {
                                      swfu.insertionPoint = $('.component_insert_point:eq(' + self.insertionPoints.current + ')');
                                    },
        file_queued_handler       : function () {
                                      swfu.uploading_overlay = new Wait({
                                        id:"uploading_image",
                                        message:"Uploading your image..."
                                      });
                                      swfu.uploading_overlay.show();
                                      swfu.startUpload();
                                    },
        upload_success_handler    : function (file, server, response) {
                                      
                                      var picture_id = eval(server),
                                          // clone the component template 
                                          component = $('#component_templates .picture_component').clone();
                                          
                                      component.find('#zap_components_attributes__picture_id').val(picture_id);
                                      component.find('.picture').empty().append('<img src="/pictures/' + picture_id + '?width=540">');
                                      self.addComponent(component, swfu.insertionPoint);
                                      
                                      swfu.uploading_overlay.hide();
  
                                    }
    });

    // component delete button handlers
    $('#component_panel .component').each(function(i, component) {
    
      new Confirm({
        id: 'confirm_component_delete',
        target: $('.delete_button', this),
        message: 'Are you sure you want to delete this?',
        confirmText: 'Delete',
        confirmCallback: function() {
          self.removeComponent($(component));
        }
      });
      
    });

    // rebuild the list of insertion points 
    self.insertionPoints.rebuild();
  
    // position panel at first insertion point
    self.moveTo(0, false);  

    //
    // initialize drag & drop
    //   
    self.initSortable();

  });

  //
  // track mouse movements, and move panel to insertion point that mouse is closest to
  //
  $('body')
    .bind(
      'mousemove',
      function(e) {
        var closestIP = self.insertionPoints.getClosest(e.pageY-26);
        if (closestIP !== self.insertionPoints.current) {
          self.moveTo(closestIP, true);
        }
      }
    );

  //
  // window events
  //
  
  $(window)
    // positioning stuff that needs to happen after images are finished downloading
    //  or window is resized
    .bind('load resize',
      function() {        
        self.moveTo(self.insertionPoints.current, false);
      }
    );

    
};
// end ComponentActionPanel

//
// keep track of the current vertical offsets of the insertion points
// 
ComponentActionPanel.prototype.insertionPoints = {
  points: [],
  current: 0,
  add: function (y) {
    this.points.push(y);
  },
  
  // rebuild list of insertion point y-indexes
  rebuild: function () {
    var self = this;
    this.points = [];
    $('.component_insert_point').each(function (i, point) {
      self.add($(point).offset().top);
    });
    this.current = Math.min(this.current, this.points.length - 1);
  },
  
  // return the index of the IP closest to the given page y position
  getClosest: function (y) {
    var closestIP = this.current;
    while (
           (closestIP > 0) &&
           (Math.abs(this.points[closestIP]   - y) > Math.abs(this.points[closestIP - 1] - y))
          ) {
      closestIP = closestIP - 1;        
    }
    while (
           (closestIP < this.points.length - 1) &&
           (Math.abs(this.points[closestIP]   - y) > Math.abs(this.points[closestIP + 1] - y))
          ) {
      closestIP = closestIP + 1;        
    }
    return closestIP;
  }
};

//
// move the panel to the given IP
//
ComponentActionPanel.prototype.moveTo = function (insertionPointIndex, animate) {
  var ip = $('.component_insert_point:eq(' + insertionPointIndex + ')'),
      position = ip.offset(),
      to = {left:position.left - 45, top: position.top + 26};
      
  this.insertionPoints.current = insertionPointIndex;
  this.panel.stop();

  if (animate) {
    this.panel.animate(to);
  } else {
    this.panel.css(to);
  }
};

//
// adds the given component to the component list
//
ComponentActionPanel.prototype.addComponent = function (component, insertionPoint) {
  
  if (typeof insertionPoint === "undefined") {
    insertionPoint = $('.component_insert_point:eq(' + this.insertionPoints.current + ')');
  }
  
  var self = this,
      
      // determine where to insert new component
      prevContainer = insertionPoint.parents('.sortable_container'),

      // create new sortable container
      container =
        $('<div class="sortable_container"></div>')
          .append('<div class="component_top"></div>')
          .append(component)
          .append('<div class="component_bottom"></div>')
          .append(insertionPoint.clone())
          .hide()
          .insertAfter(prevContainer.length === 0 ? insertionPoint : prevContainer)
          .show(
            'slow',
            function() {
      
              // rebuild insertion point list  
              self.insertionPoints.rebuild();
            
              // update the panel position
              self.moveTo(self.insertionPoints.current, false);
            
              // let everyone know we resized the component panel
              $('#component_panel').resize();
              
            }
          );

  new Confirm({
    id: 'confirm_component_delete',
    target: $('.delete_button', component),
    message: 'Are you sure you want to delete this?',
    confirmText: 'Delete',
    confirmCallback: function() {
      self.removeComponent(component);
    }
  });
  
  
  // hide the insertion text prompt     
  $('#component_insert_prompt').hide();

  // reset sorting
  this.initSortable();
    
  // reset placeholder shim
  Placeholders.reset();

};

//
// remove the given component from the component list
//
ComponentActionPanel.prototype.removeComponent = function (component) {
  
  var self = this,
      container = component.parents('.sortable_container');
  
  container.hide('fast', function() {
    container.remove();
    $('#component_panel').resize();
    self.initSortable();
    self.insertionPoints.rebuild();
    self.moveTo(self.insertionPoints.current, false);
    if (('.sortable_container').length === 0) {
      $('#component_insert_prompt').show();
    }
  });
};

//
// (re)sets sorting behavior on zapComponents component list
//
ComponentActionPanel.prototype.initSortable = function () {
  
  // save reference to this
  var self = this,
      insertionPointBG;
      
  // set up drag & drop sorting
  $('#component_panel').sortable({
    
    // only sort .sortable_container
    items: '.sortable_container',
    
    // on start of drag, hide the insertion points and the
    //  component_action_panel
    start: function () {
      insertionPointBG = $('.component_insert_point').css('background');
      $('.component_insert_point').css({'background' : 'none'});
      self.panel.hide();
    },
    
    // on end of drag, show the component_action_panel and reinsert the
    //  insertion points
    stop: function () {
      $('.component_insert_point').css({'background' : insertionPointBG});
      self.insertionPoints.rebuild();
      self.panel.show();
      self.moveTo(self.insertionPoints.current, false);
    }
  });
};


        
// (re)set up placeholder shim
Placeholders = {
  reset :
    function () {
      if ($.placeholder) {
        $.placeholder.shim({
          selector    : '#component_panel input[placeholder], #component_panel textarea[placeholder]',
          lr_padding  : 0
        });
      }
    }
}
