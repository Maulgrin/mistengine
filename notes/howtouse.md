# How to Use MistEngineRef for Legend in the Mist

This ruleset is a Fantasy Grounds character sheet and modifier helper for Legend in the Mist. It does not automate every rule. Use it to record your character, collect modifiers, roll 2d6, and track theme/status usage.

## Fast Roll Workflow

1. Open your character sheet.
2. Click the tags, statuses, relationships, backpack items, or manual modifier buttons that apply to the action.
3. Each clicked control adds its value to the Fantasy Grounds modifier stack and usually posts a chat message.
4. Click `2d6/Die Button right of name`.
5. The roll consumes the modifier stack, rolls two six-sided dice, and reports:
   - `Failure` on a total below 7.
   - `Mixed` on a total from 7 to 9.
   - `Success` on a total above 9.
   - `Failure - Snake Eyes` on double 1s.
   - `Success - Boxcars` on double 6s.
6. The chat result also shows `Power`, which is the total modifier that was applied to the roll.

Use `Reset` after a move or scene when you want to clear checked tag/status controls and clear the current modifier stack.

## Character Sheet Header

The top of the character sheet has the main roll controls.

- `2d6/Die Button right of name`: rolls two six-sided dice using the current modifier stack, then clears the stack.
- `Reset`: clears checked tag/status controls on the sheet and clears the modifier stack.
- `+3` and `-3`: quick Adventure-level modifiers.
- `+6` and `-6`: quick Greatness-level modifiers.
- `Favored` and `Imperiled`: labels near those quick modifier buttons.

Click modifier buttons before rolling. Do not click `2d6/Die Button right of name` until all relevant modifiers have been added.

## Themes Tab

The `Themes` tab contains your theme cards.

To add a theme, use the theme list create control or right-click the empty theme list and choose create.

Each theme card includes:

- `Type`: a dropdown with theme types such as Circumstance, Devotion, Past, Duty, Relic, Destiny, Companion, Magic, and Possessions.
- `Might`: a dropdown with `Origin`, `Adventure`, and `Greatness`.
- `Power`: power tag text fields.
- `Weakness`: weakness tag text fields.
- `Quest`: a larger text field for the theme quest.
- `Abandon`, `Improve`, and `Milestone`: tracking checkboxes.

Theme tag buttons:

- The plus icon beside a power tag adds `+1` from that tag.
- The minus icon beside a weakness tag adds `-1` from that weakness.
- The scratch icon beside supported power tags adds `+3` and posts a scratch message.

After you click a theme tag, the matching checkbox stays checked until reset or manually unchecked. This helps show which tags have already been used.

## Details Tab

The `Details` tab contains three lists: `Statuses/Tags`, `The Backpack`, and `Relationships`.

### Statuses/Tags

Use this list for personal statuses, temporary tags, or other character-specific modifiers.

Each row has:

- A name field.
- A plus button to add the selected value as a positive modifier.
- A minus button to add the selected value as a negative modifier.
- A power dropdown from `1` to `6`.
- Six small level checkboxes that can set the power dropdown.
- A `TAG` checkbox.

When `TAG` is checked, the row locks to power `1`. This is useful for ordinary tags. Leave `TAG` unchecked for statuses or modifiers that can have higher values.

You can also drag a Stat Tag library record onto the `Statuses/Tags` list. The row will be created and the tag name copied in.

### The Backpack

Use the backpack list for useful items.

Each row has:

- An item name.
- An availability/carried toggle.
- A plus icon that adds `+1` from the item.
- A scratch icon that adds `+3` and posts a scratch message.

Use the availability toggle as a reminder that an item is ready, carried, or available. It does not add a modifier by itself.

### Relationships

Use the relationships list for companions, contacts, or relationship tags.

Rows are organized as companion/tag fields. The use-tag checkbox adds `+1` as a `Relationship` modifier and marks that relationship/tag as used. The lower fields and checkboxes are for relationship notes and promise/quintessence tracking.

## Notes

The `Notes` tab contains character details such as race, sex, age, height, weight, appearance, languages, and general notes.

## Status and Tags Desktop Panel

The separate `Status and Tags` panel is shared outside the character sheet.

Use it for quick scene-wide or table-visible statuses/tags:

- Add a row with the add button.
- Enter the status or tag name.
- Choose a power value from `1` to `6`.
- Click the row's add button to add it as a positive modifier.
- Click the row's minus button to add it as a negative modifier.

The panel also has quick `+1`, `+2`, `+3`, `-1`, `-2`, and `-3` buttons. These add unnamed modifiers directly to the stack.

Use the red arrow button to shrink or expand the panel.

## Fellowship Theme Panel

The `Fellowship Theme` panel is shared publicly by the host. The GM controls adding entries, but players can use the visible entries.

Each fellowship theme has:

- Power fields with add buttons.
- Weakness fields with minus buttons.
- Used checkboxes beside each tag.
- Scratch controls for supported power rows.
- Quest, abandon, improve, and milestone tracking.

Clicking a fellowship theme power or weakness button adds its value to the modifier stack and checks the matching used box. A checked used box disables that button until it is unchecked.

## Practical Tips

- Click all applicable modifiers before rolling.
- Use `Reset` after resolving a move to clear used checkboxes and the modifier stack.
- If you click a modifier by mistake, use `Reset` before rolling.
- A checked box usually means "this tag/status was used," not "this tag is permanently active."
- Scratch buttons add `+3`; they are separate from ordinary `+1` tag-use buttons.
- The chat log is the best place to confirm what was added before the roll.
