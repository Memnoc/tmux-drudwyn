//! Shared presentation primitives for Drudwyn's interactive terminal surfaces.

use ratatui::{
    layout::Rect,
    style::{Modifier, Style},
    text::{Line, Span},
    widgets::{Block, Borders, Paragraph},
};

use crate::theme::Theme;

#[derive(Clone, Copy)]
pub(crate) enum FooterTone {
    Info,
    Warning,
    Error,
}

pub(crate) fn render_action_bar(
    frame: &mut ratatui::Frame<'_>,
    area: Rect,
    theme: Theme,
    groups: &[&[(&str, &str)]],
) {
    frame.render_widget(
        Paragraph::new(action_line(groups, theme)).block(Block::default().borders(Borders::TOP)),
        area,
    );
}

pub(crate) fn render_footer(
    frame: &mut ratatui::Frame<'_>,
    area: Rect,
    theme: Theme,
    groups: &[&[(&str, &str)]],
    context: (&str, &str, FooterTone),
) {
    frame.render_widget(
        Paragraph::new(vec![
            action_line(groups, theme),
            context_line(context, theme),
        ])
        .block(Block::default().borders(Borders::TOP)),
        area,
    );
}

pub(crate) fn action_line(groups: &[&[(&str, &str)]], theme: Theme) -> Line<'static> {
    let mut spans = vec![Span::raw(" ")];
    for (group_index, group) in groups.iter().enumerate() {
        if group_index > 0 {
            spans.push(Span::styled("  │  ", Style::default().fg(theme.muted)));
        }
        for (action_index, (key, label)) in group.iter().enumerate() {
            if action_index > 0 {
                spans.push(Span::raw("  "));
            }
            spans.push(Span::styled(
                format!("[{key}]"),
                Style::default().fg(theme.rose).add_modifier(Modifier::BOLD),
            ));
            spans.push(Span::styled(
                format!(" {label}"),
                Style::default().fg(theme.text),
            ));
        }
    }
    Line::from(spans)
}

fn context_line(context: (&str, &str, FooterTone), theme: Theme) -> Line<'static> {
    let (label, message, tone) = context;
    let colour = match tone {
        FooterTone::Info => theme.pine,
        FooterTone::Warning => theme.gold,
        FooterTone::Error => theme.love,
    };
    Line::from(vec![
        Span::styled(
            format!(" {label:<9}"),
            Style::default().fg(colour).add_modifier(Modifier::BOLD),
        ),
        Span::styled(message.to_owned(), Style::default().fg(theme.muted)),
    ])
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn footer_actions_use_keycaps_and_group_separators() {
        let theme = Theme::rose_pine(crate::theme::Variant::Moon);
        let line = action_line(&[&[("j/k", "Move")], &[("Esc", "Close")]], theme);
        let text = line
            .spans
            .iter()
            .map(|span| span.content.as_ref())
            .collect::<String>();
        assert_eq!(text, " [j/k] Move  │  [Esc] Close");
    }
}
