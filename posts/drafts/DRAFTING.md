# Drafting Guide for B1C3 Blog

This guide covers the stage before publishing.

Drafts are expected to become published posts, but only after they pass minimum quality and formatting standards.

---

## 1. Drafting Principle

Treat every draft as publish-intended.

That means each draft should aim to be:
- Coherent end-to-end
- Structurally readable
- Factually defensible for claims made
- Ready to convert into HTML with minimal rewriting

A draft can be unfinished, but it should never be chaotic.

---

## 2. Minimum Draft Standards

A draft is ready for HTML conversion when it meets all of these:

- A clear title exists on line 1 (`# Title`)
- Publication date is present or easy to set (`Published: YYYY-MM-DD`)
- Body has clear section breaks (`##` headings)
- Paragraphs are readable and not compressed into one giant block
- Lists are valid Markdown lists
- Tone is consistent with B1C3 voice
- Obvious placeholder text is removed
- Final question or close is intentional

If one of these fails, fix draft quality first. Do not jump to HTML yet.

---

## 3. Accepted Input Formats During Drafting

Draft content can arrive in multiple formats before cleanup:

1. Normal Markdown
- Multi-line text with proper headings and paragraph breaks.
- This is preferred.

2. Rich-text/chat copy from assistant tools
- May include smart punctuation, hidden formatting, or odd spacing.
- Must be normalized to plain Markdown.

3. Escaped one-line text from OpenClaw/MyClaw style writes
- Entire file may be one line with literal `\\n` separators.
- May include wrapper artifacts like leading `"` or trailing `}`.
- Must be decoded and repaired before content review.

---

## 4. Format Repair Workflow (Before Content Editing)

Run this if the draft is one line with escaped newlines.

```powershell
$path = "posts/drafts/your-draft.md"
$raw = [System.IO.File]::ReadAllText($path).Trim()
if ($raw.EndsWith('}')) { $raw = $raw.Substring(0, $raw.Length - 1).TrimEnd() }
if ($raw.StartsWith('"')) { $raw = $raw.Substring(1) }
if ($raw.EndsWith('"')) { $raw = $raw.Substring(0, $raw.Length - 1) }
$decoded = [System.Text.RegularExpressions.Regex]::Unescape($raw)
[System.IO.File]::WriteAllText($path, $decoded, (New-Object System.Text.UTF8Encoding($false)))
```

Then verify:
- File is multi-line again
- No literal `\\n` remains
- Markdown preview renders headings and paragraphs correctly

Only after that should you edit writing quality.

---

## 5. Draft Heuristics (Quality)

Use this quick heuristic pass before publishing handoff:

- Hook: The first 2-4 paragraphs establish the core problem
- Through-line: Each section supports one central thesis
- Compression: Remove repeated claims unless repetition adds emphasis
- Precision: Replace vague statements with concrete framing
- Sequence: Problem -> analysis -> implication -> close
- Ending: Final paragraph lands a question, decision, or principle

---

## 6. Naming and File Location

- Store working drafts in `posts/drafts/`
- Use descriptive names, usually matching eventual post slug intent
- Keep one canonical draft file per post to avoid version drift

---

## 7. Handoff to Publishing

When the draft is structurally clean and content-complete:

1. Keep draft in `posts/drafts/` as source of truth
2. Convert to HTML in `posts/`
3. Add post card to `index.html`
4. Follow the publishing workflow in `PUBLISHING.md`

Drafting is complete when content is stable.
Publishing starts when format conversion starts.
