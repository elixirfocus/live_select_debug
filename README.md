# LiveSelectDebug

This sample project demonstrates a workaround for a bug-like behavior I am witnessing in LiveView 0.17.5 where when generating a new changeset did not fully reset the form as I wanted.

If I have a LiveView with a form and have the user fill out the form multiple times, I will reset the changeset after processing a successful form submission. I want to have the form reset into its default state, but while using LiveView 0.17.5, I was not seeing this. This bug was particularly problematic for the client app's `select` input.

The solution demoed here is all about creating a random id. I attach it to the form, and when the intent is a form reset, I make a new random id. This change significantly nudges the LiveView change tracking to rebuild the form.

Demo at: [lib/live_select_debug_web/live/demo_live.ex](https://github.com/elixirfocus/live_select_debug/blob/main/lib/live_select_debug_web/live/demo_live.ex)

Related Issue?: <https://github.com/phoenixframework/phoenix_live_view/issues/1783>

I have not actively back-tested previous LiveView versions to investigate. This demo is more about extracting and sharing a hack I did on a client project, whereas explained, it was much more about the select input being sticky.
 