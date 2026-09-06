//! Terminal rendering of the bundled PNG; no terminal graphics protocol required.
use std::{io::Cursor, sync::OnceLock};

use ratatui::{layout::Rect, style::Color, widgets::Paragraph};

const SIZE: usize = 16;
const PNG: &[u8] = include_bytes!("../assets/brand/drudwyn-white.png");

fn silhouette() -> Option<String> {
    let mut reader = png::Decoder::new(Cursor::new(PNG)).read_info().ok()?;
    let mut bytes = vec![0; reader.output_buffer_size()];
    let info = reader.next_frame(&mut bytes).ok()?;
    if info.color_type != png::ColorType::Rgba || info.bit_depth != png::BitDepth::Eight {
        return None;
    }
    let (width, height) = (info.width as usize, info.height as usize);
    let mut pixels = [[false; SIZE]; SIZE];
    // Area coverage preserves the silhouette better than point sampling at this size.
    for (y, row) in pixels.iter_mut().enumerate() {
        for (x, pixel) in row.iter_mut().enumerate() {
            let mut alpha = 0u64;
            let mut count = 0u64;
            for sy in y * height / SIZE..(y + 1) * height / SIZE {
                for sx in x * width / SIZE..(x + 1) * width / SIZE {
                    alpha += u64::from(bytes[(sy * width + sx) * 4 + 3]);
                    count += 1;
                }
            }
            *pixel = count > 0 && alpha > count * 127;
        }
    }
    let mut text = String::new();
    for y in (0..SIZE).step_by(2) {
        for x in 0..SIZE {
            text.push(match (pixels[y][x], pixels[y + 1][x]) {
                (true, true) => '█',
                (true, false) => '▀',
                (false, true) => '▄',
                _ => ' ',
            });
        }
        text.push('\n');
    }
    Some(text)
}

pub(crate) fn render(frame: &mut ratatui::Frame<'_>, area: Rect, background: Color) {
    static ICON: OnceLock<Option<String>> = OnceLock::new();
    if let Some(icon) = ICON.get_or_init(silhouette) {
        frame.render_widget(
            Paragraph::new(icon.as_str()).style(
                ratatui::style::Style::default()
                    .fg(Color::White)
                    .bg(background),
            ),
            area,
        );
    }
}

#[cfg(test)]
mod tests {
    #[test]
    fn bundled_png_renders_a_nonempty_transparent_silhouette() {
        let icon = super::silhouette().expect("bundled RGBA PNG must decode");
        assert_eq!(icon.lines().count(), 8);
        assert!(icon.lines().all(|line| line.chars().count() == 16));
        assert!(icon.contains('█'));
        assert!(icon.contains(' '));
        assert!(icon.contains('▀') || icon.contains('▄'));
    }
}
