/* File: slate.example.js
 * Author: lunixbochs (Ryan Hileman)
 * Project: http://github.com/lunixbochs/reslate
 */

S.log("Starting...");

S.src('.reslate.js');
// enable to see debug messages in Console.app
//$.debug = true;

slate.alias('hyper', 'ctrl;alt;cmd');

// begin config
slate.configAll({
    defaultToCurrentScreen: true,
    checkDefaultsOnLoad: true,
    nudgePercentOf: 'screenSize',
    resizePercentOf: 'screenSize',
    undoOps: [
        'active-snapshot',
        'chain',
        'grid',
        'layout',
        'move',
        'resize',
        'sequence',
        'shell',
        'push'
    ]
});

function focusTo(dir) {
  return $('doOperation', slate.operation("focus", {'direction': dir}));
}


// bindings
slate.bindAll({
    hyper: {
        shift: {
            // edges
            h: [$('barResize', 'left',   3),
                $('center',    'left',   3, 3)],
            j: [$('barResize', 'bottom', 2),
                $('center',    'bottom', 3, 3)],
            k: [$('barResize', 'top',    2),
                $('center',    'top',    3, 3)],
            l: [$('barResize', 'right',  3),
                $('center',    'right',  3, 3)],

            // corners
            y: [$('corner', 'top-left',     3, 2),
                $('corner', 'top-left',     3, 3)],
            i: [$('corner', 'top-right',    3, 2),
                $('corner', 'top-right',    3, 3)],
            b: [$('corner', 'bottom-left',  3, 2),
                $('corner', 'bottom-left',  3, 3)],
            m: [$('corner', 'bottom-right', 3, 2),
                $('corner', 'bottom-right', 3, 3)],

            // centers
            u: [$('center', 'top'),
                $('center', 'top', 3, 3)],
            n: [$('center', 'bottom'),
                $('center', 'bottom', 3, 3)],
            'return': $('center', 'center', 3, 3),

            // focus
            'up': focusTo('behind'),
            'down': focusTo('behind'),
        },
        // bars
        h: [$('barResize', 'left',  2),
            $('barResize', 'left',  1.5)],
        j: $('barResize', 'bottom', 2),
        k: $('barResize', 'top',    2),
        l: [$('barResize', 'right', 2),
            $('barResize', 'right', 1.5)],
        // corners
        y: [$('corner', 'top-left'),
            $('corner', 'top-left', 1.5)],
        i: [$('corner', 'top-right'),
            $('corner', 'top-right', 1.5)],
        b: [$('corner', 'bottom-left'),
            $('corner', 'bottom-left', 1.5)],
        m: [$('corner', 'bottom-right'),
            $('corner', 'bottom-right', 1.5)],
        // centers
        u: $('center', 'top'),
        n: $('center', 'bottom'),
        'return': $('center', 'center'),
        // throw to monitor
        '`': ['throw 0 resize',
              'throw 1 resize'],
        '1': $('toss', '0', 'resize'),
        '2': $('toss', '1', 'resize'),
        '3': $('toss', '2', 'resize'),

        // direct focus
        c: $.focus('Google Chrome'),
        e: $.focus('Evernote'),
        t: $.focus('iTerm'),
        f: $.focus('Finder'),
        x: $.focus('X11'),
        s: $.focus('Spotify'),

        'right': focusTo('right'),
        'left': focusTo('left'),
        'up': focusTo('up'),
        'down': focusTo('down'),

        // utility functions
        f1: 'relaunch',
        z: 'undo',
        tab: 'hint'
    }
});


function doOperation(val) {
  $.log('doing ' + val);
  return {
    'operations': val,
    'repeat': true,
  };
}

function makeWinSequence(ops) {
  var dispatch = function (win) {
    $.log('called dispatch with ' + win.title());
    w = $.window(win);
    _.each(ops, function (op) {
      op(w);
    });
  }
  return doOperation(dispatch);
};



function hideApps(apps) {
  return slate.operation('hide', {
    'app': apps,
  });
}

var fullscreen = makeWinSequence([$('barResize', 'left', '1')]);


var laptopLayout = slate.layout('laptopMonitor', {
  '_after_': doOperation(hideApps(['Firefox', 'Spotify'])),
  'iTerm': fullscreen,
  'Evernote': fullscreen,
  'Firefox': fullscreen,
  'Google Chrome': fullscreen,
  'Lime Chat': fullscreen,
  'Microsoft Outlook': fullscreen,
  'Spotify': fullscreen,
});

var twoMonitorLayout = slate.layout('twoMonitors', {
  'iTerm': makeWinSequence([$('toss', 0), $('barResize', 'left', 2)]),
  'Evernote': makeWinSequence([
    $('toss', 0),
    $('corner', 'top-left', 1.5, 1.5),
  ]),
  'Firefox': makeWinSequence([$('toss', 0), $('corner', 'top-right', 2, 1.5)]),
  'Google Chrome': makeWinSequence([$('toss', 0), $('barResize', 'right', 2)]),
  'LimeChat': makeWinSequence([
    $('toss', 0),
    $('corner', 'top-left', 1.5, 1.5),
  ]),
  'Microsoft Outlook': makeWinSequence([
    $('toss', 0),
    $('corner', 'top-left', 2, 1.5),
  ]),
  'Spotify': fullscreen,
});

slate.default(['1440x900'], laptopLayout);
slate.default(['2560x1600', '1440x900'], twoMonitorLayout);
slate.default(['1920x1080', '1440x900'], twoMonitorLayout);

S.log("[SLATE] -------------- Finished Loading Config --------------");

