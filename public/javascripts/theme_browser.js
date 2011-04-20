/*   Copyright (c) 2010, Windhood Inc.  See
*   the COPYRIGHT file.
*/
$(document).ready(function() {
    // set up theme browser
    new ThemeScroller();

});

var ThemeScroller = function() {
    var theme_browser = $('#theme_browser'),
    themes_frame = $('#themes_frame', theme_browser),
    themes = $('#themes', themes_frame),
    left_arrow = $('#left_arrow', theme_browser),
    right_arrow = $('#right_arrow', theme_browser);

    left_arrow.click(function() {
        if (themes.queue().length > 0) {
            return;
        }

        var theme = themes.children().last();
        theme.detach().prependTo(themes);
        themes.css({
            marginLeft: (theme.width() * -1)
        });
        themes.animate({
            marginLeft: 0
        });
    });

    right_arrow.click(function() {
        var theme = themes.children().first();

        if (themes.queue().length > 0) {
            return;
        }

        themes.animate(
        {
            marginLeft: theme.width() * -1
        },
        function() {
            theme.detach().appendTo(themes);
            themes.css({
                marginLeft: 0
            });
        });
    });
};

