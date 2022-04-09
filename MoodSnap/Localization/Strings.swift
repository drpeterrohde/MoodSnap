import SwiftUI

/**
 Strings.
 */

let help_how_to_use_moodsnap_string = "MoodSnap records your mood history by taking _MoodSnaps_, a single sheet questionaire about your mood levels, symptoms and activities.\n\nFor the analytics tools to work correctly it is best to take MoodSnaps on a regular basis, for example at the same time every evening. You can enable reminders for this in the _settings_ page.\n\nWhen taking a MoodSnap your entries should reflect the _maximum_ respective degrees experienced _since the most recent_ MoodSnap and _within the last 24 hours_.\n\nFor people with mood disorders it is recommended taking additional MoodSnaps anytime you become aware of significant changes in mood levels or symptoms, as this additional data benefits analysis. There aren't any limits on how often you take MoodSnaps.\n\nFurther details can be found on the MoodSnap homepage: [www.moodsnap.app](https://www.moodsnap.app)"

let help_taking_moodsnaps_string = "The sliders at the top of the _MoodSnap_ panel snap to five increments, ranging from _none_ to _extreme_. The toggle buttons below allow you to specify symptoms you've experience and activites you've undertaken in the same period. Since many of these aren't relevant to everyone, you can toggle their visibility in the settings page. Custom symptoms and activities can be entered using #hashtags in any text field."

let help_events_string = "_Events_ are any major life changes that you might want to look back upon as points of reference in your mood history. These could include changes in jobs, relationships, place of residence, lifestyle changes, family situations, or changes in medication, treatment or health.\n\nIn the _statistics_ page these can be chosen as focus points for comparing mood history before and after the event. It is recommended to keep event titles very concise, a few words at most, putting further details into the associated notes field."

let help_notes_string = "Timestamped notes are for jotting down anything at all. It could be a quick note about something important that affected your mood at the time, or you could use it to keep a diary. Voice dictation is a handy way of quickly taking notes here."

let photo_diary_string = "Sometimes words just aren't enough, especially when it comes to emotions. You can take photos from within the app that get saved into your MoodSnap history as a photo diary."

let help_settings_string = "Here you can set reminders to keep MoodSnapping at regular times, customise the user interface, and import and export backups of your data. You can also toggle the visibility of items in the symptoms and activities lists. Since not all available items are relevant or of interest to everyone, this can help declutter the interface to focus on what's relevant to you. Hiding items does not delete any recorded data."

let statistics_intro_string = "The _statistics_ tab provides a number of graphs that visualise your mood history and several statistical indicators that can be helpful in understanding how different activites and life events affect your mood."

let statistics_mood_history_string = "The _mood history_ plot presents the four mood indicators as bar charts in units of days."

let statistics_moving_average_string = "The _moving average_ plot shows a sliding moving average of the same four indicators, capturing trends over time."

let statistics_volatility_string_1 = "People with some mood-related conditions often experience highly volatile moods which they aim to stabilise. The _volatility_ plot visualises this as a sliding standard deviation for each of the four mood indicators. When mood levels remain constant over time the volatility is zero. If they oscillate or abruptly change it increases."

let statistics_volatility_string_2 = "In the figure above, note how the increase in volatility of depression corresponds to the sudden major change in the mood history's depression level, and the increased volatility of elevation is associated with bigger oscillations in the elevation level."

let influences_string = "The _influences_ table provides numerical correlations showing the extent to which mood and volatility levels change following different activities. The number reflects the average difference between the respective levels after and before the activity. The numbers in brackets show how many times the respective activity has taken place within the specified timeframe."

let statistics_butterfly_average_string_1 = "The _butterfly average_ plot is centered around a particular event or type of activity, showing the mood trend going backwards and forward in time around that point. The value is calculated as the average between the reference point (indicated by the central vertical bar) and the time shown on the axis.\n\nThe dropdown menu below the plot allows you to specify which activity type or event to center around."

let statistics_butterfly_average_string_2 = "The example above is centered around the event of changing job, indicating that depression levels rapidly decreased following the event and then gradually increased over time.\n\nThe butterfly plot captures the same information as the _influences_ values, but with a variable timescale."

let average_mood_string = "The average mood panel displays your average mood and volatility levels over the specified time period. You can adjust the displayed timescale using the tabs at the top of the page."

let emergency_string = "If you feel unsafe or at risk of harm:\n\n \u{2981} Call a friend, family member, your doctor, or someone you trust.\n \u{2981} Call your local emergency service or helpline.\n\nA list of international helpline and emergency numbers can be found [here](https://www.opencounseling.com/suicide-hotlines)."

let disclaimer_string = "MoodSnap is free, open source, and provided as is. Although every effort has been made to ensure the quality of the software, no guarantees are made and no liabilities are accepted associated with its use.\n\nMoodSnap is intended to assist with self-awareness and should not be used as a medical tool. Medical decisions should only be made in consultation with medical professionals.\n\nThe MoodSnap source code is available on [GitHub](https://github.com/peterrohde/MoodSnap)."

let pdf_report_string = "You can generate customisable PDF reports of your mood history and statistics within the settings page, suitable for printing, saving or sharing."

let intro_popover_title_string = "**Welcome to MoodSnap!**"

let intro_popover_description_string = "MoodSnap is your free mood diary with advanced analytics to understand your mood patterns and provide insight into what affects them.\n\nMoodSnap has features written for people with mood disorders in mind, allowing symptom tracking and analysis.\n\nNot everything available in MoodSnap is relevant to everyone. It is recommended that before you start using MoodSnap:\n\n \u{2981} You quickly read the information in the help page to understand the features.\n \u{2981} Go to settings to toggle the visibility of features not relevant to you to streamline the interface."

let intro_popover_note_string = "When taking MoodSnaps your entries should reflect the _maximum_ respective degrees experienced _since the most recent_ MoodSnap and _within the last 24 hours_."

let intro_popover_disclaimer_string = "MoodSnap is designed for self-awareness and should not be used as a medical device. Medical decisions should only be made in consultation with medical professionals."

let privacy_string = "MoodSnap respects your privacy and does not share any of your information with the developer or third parties. Your data only leaves the app if you manually export it."

let intro_snap_title = "Welcome to MoodSnap"

let intro_snap_notes = "This is your MoodSnap feed where your MoodSnaps, events, diary and photo diary entries appear."

let intro_snap_quickstart = "Quickstart: MoodSnaps should reflect the maximum mood levels experienced in the last 24 hours and since the last MoodSnap. It is recommended taking MoodSnaps regularly every day for the most reliable insights, and additionally whenever you notice changes in mood. You can take MoodSnaps as often as you like. See the help page for more information."

let intro_snap_tip = "Tip: in _settings_ you can toggle the visibility of symptoms and activities to declutter the interface and focus on what's relevant to you."

let statistics_tally_string = "The tally displays the number of occurrences of different activites, symptoms, social and hashtag events within the specified time window."

let notes_on_interpretation_string_1 = "\n• Moving average and volatility are lagging indicators, calculated over a 14 day sliding window. The moving average is a simple moving average (SMA) within the sliding window, and the volatility similarly defined using the window standard deviation.\n"
let notes_on_interpretation_string_2 = "• All insights are univariate measures that correlate moods with single parameters. In reality such correlations are more accurately describe via multi-variate analysis. This can lead to misleading conclusions about cause and effect when multiple correlations are at play. For example, if elevated mood correlates with increased sleep, and increased sleep correlated with exercise, it is impossible to determine whether the underlying causality was between mood and sleep or mood and exercise.\n"
let notes_on_interpretation_string_3 = "• Correlation does not imply causality. Taking transients as an example, it is not possible to differentiate whether a mood trend was caused by a correlated activity or caused the correlated activity. The transient plots are therefore in a time-symmetric manner — the positive and negative values relative to the point of reference are symmetrically defined as the average between the reference point and the time offset on the horizontal axis. For example, a correlation between increased appetite and elevated mood could equally suggest that:\n"
let notes_on_interpretation_string_4 = "    • Eating more results in increased elevation.\n"
let notes_on_interpretation_string_5 = "    • Increased elevation results in increased appetite.\n"
let notes_on_interpretation_string_6 = "    • Neither are caused by one another and both are correlated with another parameter.\n"
let notes_on_interpretation_string_7 = "• Missing data points make analysis less reliable. All provided measures are most accurate if the associated data is complete with daily data points. Volatility measures are most reliable if additional data points capture intermittent mood changes.\n"
let notes_on_interpretation_string_8 = "• MoodSnaps should reflect maximum values within the last 24 hours and since the last MoodSnap, and should not capture overlapping information.\n"
let notes_on_interpretation_string_9 = "• All measures under the History heading are calculated over the timescale specified in the tab at the top of the page. Measures under the Influences heading are calculated using all data.\n"
let notes_on_interpretation_string_10 = "• Transients are shown over a ±7day timescale for activities, symptoms and hashtags, and over a ±30day timescale for events.\n"
let notes_on_interpretation_string_11 = "• Influences and Transients are averaged over all instances of the chosen reference, except Events which are one-off points of reference.\n"
let notes_on_interpretation_string_12 = "• Transients are normalised to be relative to the point of reference, displayed at the center, which always has value zero. Hence Transient plots indicate relative changes rather than absolute values.\n"
let notes_on_interpretation_string_13 = "• Influences are defined as the difference between the rightmost and leftmost values of the respective Transient plot, also printed directly above the respective Transient plot.\n"

let notes_on_interpretation_string = notes_on_interpretation_string_1 + notes_on_interpretation_string_2 + notes_on_interpretation_string_3 + notes_on_interpretation_string_4 + notes_on_interpretation_string_5 + notes_on_interpretation_string_6 + notes_on_interpretation_string_7 + notes_on_interpretation_string_8 + notes_on_interpretation_string_9 + notes_on_interpretation_string_10 + notes_on_interpretation_string_11 + notes_on_interpretation_string_12 + notes_on_interpretation_string_13
