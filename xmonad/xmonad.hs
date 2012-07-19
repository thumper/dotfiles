import XMonad
import XMonad.Config.Gnome

-- Declare config preferences
-- config_terminal = "terminator"      -- Default terminal to run
config_focusFollowsMouse :: Bool    -- Have focus follow mouse
config_focusFollowsMouse = True

-- Run xmonad with the specified conifguration
main = xmonad myConfig

-- Use the gnomeConfig, but change a couple things
myConfig = gnomeConfig {
--     terminal            = config_terminal,
    focusFollowsMouse   = config_focusFollowsMouse,
    -- use the Command key in OSX, instead of Alt/Option,
    -- and uses the Win key in Linux.
    modMask = mod4Mask

}

