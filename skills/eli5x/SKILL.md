---
name: eli5x
description: Explain one topic at five levels, WIRED "5 Levels" style - ELI5 (child), ELIT (teen), ELIC (college), ELIP (PhD, replication-ready), ELIA (omniscient tutor, beyond the topic) - as one interactive, Brilliant-style local HTML file. Use when the user types eli5x with a topic (a concept or a paper) or asks for a layered explainer.
---

# eli5x: five levels of one idea

Use the topic supplied in the user’s request.

Build **one self-contained HTML file with five pages** (tabs), the same idea told five times, each to a deeper listener. It should feel like WIRED's "5 Levels of Difficulty" crossed with Brilliant: one shared spine, a lot of pictures, and things you can touch.

The output is a local HTML file only. Don't publish it as an artifact. **Light theme only, no dark mode, no theme toggle.**

## The five levels

| Tab | Listener | Job |
|---|---|---|
| **ELI5** | A 5-year-old who knows nothing | Get the *shape* of the idea across with a story, characters, and a toy you can play with. No jargon, short sentences, big pictures. |
| **ELIT** | A curious teenager | Add context: why people care, where it shows up in real life, what came before. Introduce the concept **by its real name**, in everyday language. Light numbers are fine; equations aren't. |
| **ELIC** | A college student who knows calculus and physics | Add the mechanism in full. Introduce the **terms and the math** (MathJax, see Math), derive the key result, and show worked examples. Name the assumptions. |
| **ELIP** | A PhD student | Cover every detail. Afterwards the reader should fully understand the topic, and **if it's a paper, be able to replicate it**: exact setup, notation, every equation, architecture/algorithm as pseudocode, hyperparameters, data, training/eval protocol, baselines, ablations, known pitfalls, what the paper glosses over, and open problems. Cite sources. |
| **ELIA** | Anyone; "Ascended" | Step outside the topic. You are an omniscient tutor handing over the fruit of wisdom. For each beat, show what this beat is a *special case of*: the same pattern in other fields, the deep principle underneath, the history and the people, what it says about knowing and about being human. Aim for surprise and epiphany, the feeling of "I heard this today and I could die content tomorrow." End with one line worth remembering. No platitudes: every claim should be specific and true. |

## Consistency: one spine, five depths

1. **Plan the spine first.** Before writing anything, pick 4-7 **beats**: the questions that, answered in order, *are* the idea (e.g. "What problem?", "The key trick", "Why it works", "Where it breaks", "What it changed"). Every level uses **the same beats, in the same order, with the same section ids and titles**. Beat A in ELI5 is about A in all five levels.
2. **Build by copying.** Write ELI5 completely. Copy its whole page as the ELIT starting point, then rewrite the content deeper and add sub-sections inside beats. Repeat ELIT → ELIC → ELIP → ELIA. A level may **add** material inside a beat, plus at most one trailing extra section (ELIP: "Replication recipe"; ELIA: "The one sentence"), placed before the level test. It may never drop or reorder beats.
3. **Recurring visuals.** The same central illustration or widget appears in a given beat at every level and grows with it: a cartoon at ELI5, labelled at ELIT, with axes and equations at ELIC, with real parameters or data at ELIP, set beside its cousins from other fields at ELIA.
4. Each beat's header shows a tiny 5-dot depth marker, so it's obvious which level you're on.

## Connectivity

- Each beat ends with a **bridge**: a question or tension that the next beat picks up. No sudden topic switches.
- Open each page with a one-paragraph hook that recalls the previous level ("Last time, the robot just *guessed*. Now let's see how it guesses well.").
- Close each page with a pointer to the next level.

## Illustrate and interact (Brilliant-style)

- Every beat needs at least one visual: a hand-built inline SVG figure or cartoon, a diagram, or an animation.
- Every page needs **at least 2 interactive panels**, e.g. sliders that change a live plot, draggable points, step-through animations, "predict first, then reveal" questions, toggles that compare before/after, or tiny simulations in canvas. Let the reader poke the idea before you explain it.
- Animations: build them yourself with JS, CSS or canvas. For real footage or a great explainer, add a YouTube video (see Videos).
- Keep the text short at ELI5 and ELIT; let the visuals carry those levels.

## Videos (YouTube)

Videos are optional extras that sit beside a beat's own figure or widget, never replacing it. Use at most one per beat and about 1-3 per page. Pick only clips that show something your page can't, such as real footage, a famous lecture, or the person who discovered it.

- **A different video for each level, matched to its difficulty:**
  - ELI5: short animated or kids' science clips.
  - ELIT: popular-science explainers.
  - ELIC: lecture-style explainers with the math, or university course lectures.
  - ELIP: conference talks, the authors' own talks, graduate lectures, paper walkthroughs.
  - ELIA: history, interviews with the people involved, documentaries, talks that connect fields.
  - The same beat can have a different clip at every level.
- **Never use a video ID from memory.** Find candidates with web search, then verify each one this session:
  - Check it with `curl -s 'https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=<ID>&format=json'`.
  - HTTP 200 means it exists. Use the `title` and `author_name` from that response in the caption.
  - Any other status: drop the video.
  - If you have no web access, skip videos.
- **Start time:** only set `data-start` (seconds) if you confirmed the moment, from the video's chapters or transcript. Otherwise use 0.
- **Markup:** `<figure class="yt" data-id="<ID>" data-start="0"><figcaption><b>Title</b> · Channel · from m:ss. Why this clip, for this level.</figcaption></figure>`
  - The shell turns it into a thumbnail card. YouTube refuses embeds on pages opened as local files (Error 153), so from a local file the card opens YouTube in a new tab. Served over http(s), it plays inline.
  - Switching tabs stops any playing video.

## Level tests (pass to unlock the next level)

Like Brilliant, every level ends with a **test**, and you must pass it to unlock the next tab.

- **Gating:** only ELI5 is open at the start. The other tabs show a lock icon and can't be opened until the previous level's test is passed. Save progress in `localStorage` (wrapped in try/catch). If storage is unavailable, keep progress in memory for the session.
- **Content:** one question per beat, in beat order, so the test walks back through the spine. Questions test that level's depth, not trivia:
  - ELI5: picture-based, choose the right outcome in the story.
  - ELIT: concepts in everyday terms, real-world cases.
  - ELIC: short calculations, reading a graph, spotting a wrong derivation step.
  - ELIP: derivation details, design choices and why, replication specifics (what breaks if X changes).
  - ELIA has no next level. It ends with a **capstone**: a couple of open-ended "connect the pattern" questions. Show a model answer after each attempt, then a completion screen.
- **Formats:** mix them: multiple choice, numeric input with a tolerance, drag-to-order, click on the diagram, "predict, then run the widget".
- **Feedback:** check each answer immediately. A wrong answer shows a short explanation and a "revisit this beat" link that scrolls to the beat. The reader can retry until correct. The level passes when every question has been answered correctly. Show a progress bar and a small celebration on pass, then an "Enter level N →" button.
- Wrong options should be plausible misconceptions, not throwaways. Each one's explanation should say what misconception it represents.

## Style

Claude's warm, yellowish paper look. Keep it simple and light-only, with no extra features.

```css
:root{
  --bg:#F5F0E3;      /* warm paper */
  --card:#FBF8F0;    /* panels */
  --ink:#2F2B22;     /* text */
  --muted:#6F6758;
  --line:#E3DACB;
  --accent:#C96442;  /* Claude clay/orange */
  --accent-soft:#F1DCCF;
  --gold:#D9A441;
  color-scheme: light;
}
```

- Serif headings (e.g. `Source Serif 4` or `Lora` from Google Fonts), clean sans body, generous whitespace, max reading width ~760px, rounded cards, and thin warm borders.
- The template already has the tabs, the locks, the test engine, progress saving, and all styles. Don't rebuild them.
- Code: plain `<pre>` blocks, no highlighter needed.
- It must work at phone width.

## Math

The template loads **MathJax 3 with SVG output**, which needs no stylesheet or font files. Don't switch to KaTeX: it needs a separate stylesheet and font files, and it refuses to run in quirks mode.

- Inline math `\( … \)`, display math `<div class="math-d">\[ … \]</div>`. Never `$…$`.
- The TeX sits inside HTML, so write `<` as `\lt`, `>` as `\gt`, and `&` as `&amp;`.
- Stick to standard LaTeX and AMS commands. No `\rm`: use `\mathrm{}`.
- Math inserted by JavaScript after load needs `MathJax.typesetPromise([el])`.

## Papers

If the topic is a paper (title, arXiv id, PDF, or link), read it first: fetch or read the actual text. ELIP must be faithful to it. Use its notation, its numbers, and its hyperparameters. Say clearly where the paper is silent, and label your own inferences as inferences. Never invent results.

## Template

`template.html` (next to this file) is the finished shell. **Copy it, then only fill the `{{PLACEHOLDERS}}` and the TOPIC WIDGETS script.**

- **Placeholders:**
  - Each level's `<section class="page">` comes with two beat blocks and a test. Repeat the beat block once per beat, and repeat the test question once per beat.
  - ELIP already includes the Replication recipe, and ELIA includes The one sentence and the capstone.
- **KEEP sections:** don't edit the CSS rules marked KEEP or the SHELL SCRIPT. They exist to prevent known bugs:
  - `[hidden]{display:none!important}`: without it, any `display` rule on `.page` overrides `hidden` and all five pages show at once.
  - Tab switches scroll to the top. Locked tabs are disabled. Junk saved state falls back to ELI5.
  - Keep the first line `<!doctype html>`. Without it, Chrome renders the page in quirks mode, where math libraries refuse to run and layout shifts.
- **Test question markup:**
  - Multiple choice: `.tq` with `.opts` buttons. Mark the right one `data-ok`, and give every option a `data-why`.
  - Number: `.tq` with `data-answer` and `data-tol`. It accepts `6.1e-10` and `6.1 × 10^-10`.
  - Open (ELIA only): `.tq.open`.
  - Custom widget: put it inside a `.tq` and call `FL.done(tq)` when it's solved.
  - Every `.tq` gets `data-beat="<beat element id>"` for the "Revisit this beat" link.
- **Widgets:** put them in the TOPIC WIDGETS script, one function per widget that takes the level (0-4), so the same widget grows with depth. Size canvases with fixed numbers, never `clientWidth`: hidden pages measure 0.

## Process

1. Pin down the topic (read the paper if there is one). Write out the beat spine: ids and titles.
2. Copy `template.html` into the current working directory as `eli5x-<slug>.html` (or wherever the user says). Set the title and the beat blocks for all five levels first, so the spine is identical everywhere.
3. Fill ELI5, then ELIT, ELIC, ELIP, ELIA in turn. Write each level by deepening the previous one, along with its test.
4. Check, and fix anything that fails:
   - `grep -c '{{' file` is 0.
   - There are exactly 5 `class="test"` sections.
   - Every level has the same beat ids (after the prefix), in the same order.
   - Every beat has a figure and a bridge.
   - Each test has one `.tq` per beat, every `data-why` is filled, and every numeric `data-answer` is a plain number.
   - No `$` math, and no raw `<` or `&` inside TeX.
   - No `clientWidth` in the widgets.
   - Every `.yt` video ID returned 200 from oEmbed in this session, and each page's videos suit its level.
   - If a browser tool is available, open the page: math renders, only one page is visible, and passing a test unlocks the next tab.
5. Don't publish. Give the user the file's absolute path (they open it in a browser) plus the beat spine in 2-3 lines.
