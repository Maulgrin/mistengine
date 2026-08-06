## 2026-07-29

- Rebuilt the Stat Tags seed list in `MistEngineRef/scripts/manager_stattag_library.lua` as grouped data using the requested capitalized group names.
- Updated Stat Tags startup seeding to assign master index categories with CoreRPG's existing `DB.setCategory` API.
- Preserved existing campaign records by reusing uncategorized matching tags where possible, while allowing duplicate tag names when the same tag appears in more than one requested group.
- Added a TAG checkbox to `stattagdetails` and clamped the stat power dropdown to `1` whenever it is checked.
- Updated the TAG checkbox behavior so it checks `statlvl1`, clears higher stat levels, sets `stpower_dd` to `1`, and locks the stat level controls plus dropdown until unchecked.
- Added Stat Tag library shortcut drop support to the NPC `npclimits_list`, creating an NPC limit row and copying the Stat Tag name into `statustag_string`.
- Updated `fellowthemedetails` so each tag modifier button checks its corresponding used checkbox and that checked state disables the matching button until unchecked.
- Fixed the two-d6 result handler so manual rolls without message text no longer error before appending result details.

## 2026-08-02

- In GUI redesign mode, added an additional `themedetails` power tag row below `StringField7` using `StringField10`, `Checkbox10`, and `scratch_item10`.
- Shifted the `themedetails` weakness, quest, and progress controls down by one row and increased the theme detail item height to 520.
- Increased the character sheet theme list and sheet minimum height to fit the taller theme detail item without clipping.
- Added another `themedetails` weakness row below `StringField9` using `StringField12` and `Checkbox12`, then shifted the quest and progress controls down by one row.
- Removed `scratch_item12` from `themedetails`; the added weakness row now only uses `StringField12` and `Checkbox12`.

## 2026-08-03

- Added `notes/howtouse.md` with player-facing usage instructions derived from the current MistEngineRef character sheet, theme, status/tag, backpack, relationship, and fellowship theme code.

## 2026-08-06

- Added dynamic resize limits and CoreRPG resize handles to the `statuses` and `threats` desktop windows while preserving their existing shrink button size.
- Anchored the `statuses` and `threats` desktop lists to resize with their parent windows, anchored the `statuses` quick plus/minus buttons to the bottom edge, and made `stattagdetailsg`/`threatdetails` row text fields and right-side controls respond to row width changes.
- Added click-to-front behavior to the `statuses`, `fellowthemes`, and `threats` desktop windows and their list row windowclasses using CoreRPG's verified `bringToFront()` window API.
- Replaced the `statuses`, `fellowthemes`, and `threats` desktop panel declarations with auto-opened `noclose` windows so they participate in the normal Fantasy Grounds window stack where click-to-front can work.
