//! Share the shell status bar's font policy with standalone Rust interfaces.
use std::process::Command;

pub(crate) fn agent_icon() -> String {
    Command::new("bash")
        .args(["-c", include_str!("../scripts/icons.sh")])
        .output()
        .ok()
        .filter(|output| output.status.success())
        .and_then(|output| {
            String::from_utf8(output.stdout)
                .ok()?
                .lines()
                .nth(1)
                .filter(|icon| !icon.is_empty())
                .map(str::to_owned)
        })
        .unwrap_or_else(|| "A".into())
}
