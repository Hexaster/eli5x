# eli5x

Create an interactive HTML lesson that teaches the same concept or paper to five audiences. The package includes the authoring instructions and a reusable HTML shell with quizzes and saved progress.

## Install on macOS, Linux, or WSL

Clone the repository into a permanent location and run the installer from the checkout.

```sh
git clone https://github.com/Hexaster/eli5x.git
cd eli5x
./install.sh
```

The installer links Claude Code, Codex, and Hermes to the same skill directory. It respects CODEX_HOME and HERMES_HOME and stops if a different installation already occupies a target. Start a fresh session after installation. In Claude Code or Hermes, use `/eli5x how batteries work`. In Codex, use `$eli5x how batteries work`.

## Maintain

Edit [the instructions](skills/eli5x/SKILL.md) or [the HTML template](skills/eli5x/template.html) in this checkout, then commit and push. On another installed machine, run `git pull --ff-only` in its checkout. All three tools read the updated files through their links. Generated lessons are standalone outputs and keep the template version used when authored. MathJax and optional video content need network access.
