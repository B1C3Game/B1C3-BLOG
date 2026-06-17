# Publishing a New Blog Post on B1C3-BLOG

This guide extracts and clarifies the instructions from the main README for publishing a new post on GitHub Pages using the B1C3-BLOG repository.

---

## Before You Draft: Prepare Images

If your post includes images, prepare them first (before or while drafting).

**Reference:** See `IMAGE-WORKFLOW.md` for complete image standards.

**Steps:**
1. Create or generate images for your post
2. Optimize/compress using TinyPNG, Squoosh.app, or equivalent (target ≤ 500KB)
3. Copy to `static/images/` with descriptive, kebab-case filename:
   ```powershell
   Copy-Item "source-image.png" "static/images/post-name-descriptor.png"
   ```
4. Test on mobile (375px width in DevTools)
5. Note the final filename and dimensions for reference in draft

---

## 1. Review & Confirm Draft Content

Before converting to HTML, the draft must be reviewed and approved for publication.

**For posts with images:**
- [ ] Images are already in `static/images/` and linked in draft
- [ ] Image markdown syntax is correct: `![alt text](../static/images/image-name.png)`
- [ ] All image links point to existing files

**Source locations for drafts:**
- Markdown or rich-text notes in `posts/drafts/` directory
- Project documentation or content files elsewhere in the workspace
- Session notes or planning documents

**Review checklist:**
- [ ] Confirm this is the draft to publish (title, scope, audience)
- [ ] Content is complete and ready for publication (not a work-in-progress)
- [ ] Tone, messaging, and claims are accurate
- [ ] All references and links are correct (including image links)
- [ ] Metadata is ready: publication date, category, lead sentence, canonical URL, preview image if needed

---

## 2. Prepare Your Post

Convert your reviewed draft into HTML using the standard blog post template.

**Template reference:** See `BLOG_HTML_TEMPLATE.md` for:
- Complete minimal HTML structure
- Required `<head>` metadata (title, viewport, favicon, stylesheets)
- Correct container hierarchy (`main` → `article` → `post-content`)
- Checklist to validate your HTML before publishing

**Steps:**
1. Copy `BLOG_HTML_TEMPLATE.md` structure or use an existing post as a reference
2. Populate `<head>` metadata:
   - `<title>`: "Your Post Title | B1C3 Blog"
   - `<meta name="description">`: Short description (40–160 characters)
   - `<link rel="stylesheet" href="../css/style.css">` and `../css/responsive.css`
   - Date in `<link rel="icon">`: Ensure it points to `../static/favicon.svg`
   - **Analytics scripts** (critical for tracking):
     ```html
     <script src="../js/analytics-config.js"></script>
     <script defer src="../js/analytics.js"></script>
     ```
   - `<link rel="canonical">`: Full published URL for the post
   - Open Graph tags: `og:title`, `og:description`, `og:url`, `og:type`, and `og:image` when relevant
   - Twitter card tags: optional, only if you want extra polish on X/Twitter
3. Update the hero section (`.article-hero`):
   - Category (eyebrow)
   - Post title (`<h1>`)
   - Lead sentence (short subtitle)
   - Publication date
4. Place all content inside `<div class="post-content">` within `<article>`
5. **Convert markdown images to HTML:** Replace markdown image syntax with the responsive `<figure>` structure:
   - Markdown in draft: `![alt text](../static/images/image-name.png)`
   - Convert to HTML:
   ```html
   <figure class="post-image">
     <img 
       src="../static/images/image-name.png" 
       alt="Descriptive, meaningful text (≤ 125 characters, from draft)"
       loading="lazy"
       width="800"
       height="600"
     />
     <figcaption>Optional caption or source attribution</figcaption>
   </figure>
   ```
   - **Alt text is required** for WCAG compliance (copy from draft context or draft alt text)
   - Use `loading="lazy"` for performance
   - Include `width` and `height` attributes to prevent layout shift
6. **Run the BLOG_HTML_TEMPLATE checklist** to validate structure before committing

## 3. Add the Post File
- Place your new HTML file in the `B1C3-BLOG/posts/` directory.
- Example: `B1C3-BLOG/posts/how-agents-will-make-you-struggle.html`

## 4. Update the Blog Index
- Edit `B1C3-BLOG/index.html`.
- Add a new card for your post in the posts panel:

```html
<article class="card post-card">
  <p class="card-meta">YYYY-MM-DD</p>
  <h3>Your Post Title</h3>
  <p>A short excerpt or preview of your post...</p>
  <a href="posts/your-post-title.html">Read the post</a>
</article>
```

## 5. Review Locally Before Publishing

Test the post locally in your browser to verify rendering, responsiveness, and all assets load correctly.

**Steps:**

1. **Open the post in your browser:**
   - Right-click the HTML file → "Open with" → your browser
   - Or drag the file into the browser window
   - Example: `file:///C:/2/B1C3/B1C3-BLOG/posts/generative-intelligence.html`

2. **Desktop view checklist:**
   - [ ] Post renders without errors
   - [ ] All links are clickable and correct (external and internal)
   - [ ] Images load and display correctly
   - [ ] Typography/spacing looks professional
   - [ ] Hero section displays properly (title, date, category)
   - [ ] Metadata in `<head>` looks sensible (inspect with DevTools)

3. **Mobile responsiveness (DevTools):**
   - Open DevTools: `F12` or `Ctrl+Shift+I`
   - Click device emulation icon (top-left of DevTools)
   - Test these viewport sizes:
     - [ ] Mobile: 375px (iPhone 12)
     - [ ] Tablet: 768px (iPad)
     - [ ] Desktop: 1024px+
   - For images: 
     - [ ] Images scale properly (not stretched, not cut off)
     - [ ] Images are centered and readable
     - [ ] Alt text is present (right-click image → inspect)
     - [ ] Captions (if any) are visible

4. **Navigation:**
   - [ ] Header navigation links work
   - [ ] Internal post links work (if any)
   - [ ] Footer links work

**If you find issues:**
- Fix the HTML file
- Reload the browser (Ctrl+R or Cmd+R)
- Verify the fix

---

## 6. Commit and Publish to GitHub

1. Open your terminal and navigate to the B1C3-BLOG repository directory.
2. Stage your changes (the new post and the updated index):
  ```bash
  git add .
  ```
3. Commit your changes with a clear message:
  ```bash
  git commit -m "Add: [Your Post Title]"
  ```
4. Push your changes to GitHub:
  ```bash
  git push origin main
  ```
5. GitHub Pages will automatically deploy your changes within seconds to a few minutes.

## 7. Verify on GitHub Pages

- Visit `https://b1c3game.github.io/B1C3-BLOG/` in your browser.
- Confirm your new post appears on the homepage and the link works.

---

## 8. Publishing AI Interaction Logs (Session Documentation)

AI Interaction Logs document problems encountered, solutions applied, and lessons learned during agent-assisted development sessions. They serve as institutional memory and guidance for future work.

### When to Create a Log
- After a significant agent-assisted session (HTML debugging, content restructuring, workflow changes, etc.)
- If the session involved problems, recoveries, or edge cases worth documenting
- As a peer-review artifact that shows the development process transparently

### File Structure & Naming

**Location:** `agent-logs/` directory

**Naming convention:** `YYYY-MM-DD-description.md` (e.g., `2026-05-10-carinspect-html-generation.md`)

**Required metadata header:**
```markdown
---
title: "Session Log: [Brief Title]"
date: YYYY-MM-DD
scope: [File/Project modified, e.g., "posts/carinspect-ai-audio-analysis.html"]
related_work: 
  - "[Link to related post or work](../posts/your-post.html)"
  - "[Link to repo or PR](../../your-repo)"
---
```

**Recommended sections:**
- **TL;DR**: One-sentence executive summary
- **Problems Encountered**: Numbered list of issues (e.g., "1) Appendix order drift", "2) FAQ misplacement")
- **Root Causes & Prevention**: For each problem, explain why it happened and how to prevent it
- **Lessons Learned**: Reusable checklist or guardrails
- **Useful Commands**: Shell commands that helped diagnose or fix issues

### Example Entry
See `agent-logs/2026-05-10-carinspect-html-generation.md` for a full example.

### Adding the Log to the Homepage

1. Edit `index.html`
2. Add a card in the "AI Interaction and Analysis" section:

```html
<article class="card post-card">
  <p class="card-meta">YYYY-MM-DD</p>
  <h3>Session: [Brief Title]</h3>
  <p>Scope: [e.g., "CarInspect HTML generation and structure validation"]</p>
  <a href="agent-logs/YYYY-MM-DD-description.md">Read the log</a>
</article>
```

### Commit and Push

```bash
git add agent-logs/
git add index.html
git commit -m "Add: AI Interaction Log - [Session description]"
git push origin main
```

---

### Notes
- No build step is required. Just HTML, CSS, and Git.
- For style and structure, see the example posts in `posts/` and the CSS in `css/`.
- **For images:** Follow the complete workflow in `IMAGE-WORKFLOW.md` (compression, naming, WCAG compliance, responsive design, mobile testing).
  - All images go in `static/images/`
  - Use `<figure>` + `<figcaption>` wrapper with `alt` text (required)
  - Test on mobile before publishing
- **Favicon:**
  - All posts should include the B1C3 favicon for brand consistency.
  - In your post's `<head>`, add:
    ```html
    <link rel="icon" href="../static/favicon.svg" type="image/svg+xml">
    ```
  - The favicon file is located at `static/favicon.svg`.
  - For the homepage, use:
    ```html
    <link rel="icon" href="static/favicon.svg" type="image/svg+xml">
    ```

### OpenClaw/MyClaw Draft Import Gotcha

If draft text is copied from OpenClaw/MyClaw output (chat or `write` summary), markdown can be saved as a **single line** with literal escape sequences like `\n` instead of real line breaks.

Symptoms:
- The entire file appears on one line in the editor
- You see literal `\n` between paragraphs
- Sometimes wrapper artifacts appear at the start/end (for example a leading `"` or trailing `}`)

Quick recovery (PowerShell):

```powershell
$path = "posts/drafts/your-draft.md"
$raw = [System.IO.File]::ReadAllText($path).Trim()
if ($raw.EndsWith('}')) { $raw = $raw.Substring(0, $raw.Length - 1).TrimEnd() }
if ($raw.StartsWith('"')) { $raw = $raw.Substring(1) }
if ($raw.EndsWith('"')) { $raw = $raw.Substring(0, $raw.Length - 1) }
$decoded = [System.Text.RegularExpressions.Regex]::Unescape($raw)
[System.IO.File]::WriteAllText($path, $decoded, (New-Object System.Text.UTF8Encoding($false)))
```

Validation after recovery:
- File has normal multi-line markdown structure
- No literal `\n` remains
- Headings and paragraphs render correctly in Markdown preview

---

This file replaces the step-by-step instructions from the main README for easier reference and future updates.
