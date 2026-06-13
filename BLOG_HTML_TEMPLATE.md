# B1C3 Blog Post HTML Template & Checklist

## Minimal HTML Structure Template

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Blog Post Title | B1C3 Blog</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Short description of the post.">
  <link rel="canonical" href="https://b1c3game.github.io/B1C3-BLOG/posts/your-post-file.html">
  <meta property="og:type" content="article">
  <meta property="og:title" content="Blog Post Title | B1C3 Blog">
  <meta property="og:description" content="Short description of the post.">
  <meta property="og:url" content="https://b1c3game.github.io/B1C3-BLOG/posts/your-post-file.html">
  <meta property="og:image" content="https://b1c3game.github.io/B1C3-BLOG/static/images/your-preview-image.jpg">
  <link rel="stylesheet" href="../css/style.css">
  <link rel="stylesheet" href="../css/responsive.css">
  <link rel="icon" href="../static/favicon.svg" type="image/svg+xml">
  <meta name="twitter:card" content="summary_large_image">
  <script src="../js/analytics-config.js"></script>
  <script defer src="../js/analytics.js"></script>
  <meta name="twitter:title" content="Blog Post Title | B1C3 Blog">
  <meta name="twitter:description" content="Short description of the post.">
  <meta name="twitter:image" content="https://b1c3game.github.io/B1C3-BLOG/static/images/your-preview-image.jpg">
</head>
<body>
  <div class="atmosphere" aria-hidden="true"></div>
  <header class="site-header">
    <a class="brand" href="https://b1c3.dev/">B1C3</a>
    <nav aria-label="Primary">
      <a href="../index.html">Blog</a>
      <a href="https://b1c3.dev/" target="_blank" rel="noreferrer">Home</a>
      <a href="https://github.com/B1C3Game/B1C3-BLOG" target="_blank" rel="noreferrer">GitHub</a>
    </nav>
  </header>
  <main>
    <section class="article-hero reveal">
      <p class="eyebrow">Category</p>
      <h1>Blog Post Title</h1>
      <p class="lead">Short subtitle or summary.</p>
      <p class="post-date">Published: YYYY-MM-DD</p>
    </section>
    <article class="panel post reveal">
      <div class="post-content">
        <!-- All blog content goes here: headings, paragraphs, lists, tables, appendices, etc. -->
      </div>
    </article>
  </main>
</body>
</html>
```

## Checklist for Blog Post HTML

- [ ] Only one `<html>`, `<head>`, `<body>`, `<main>`, `<article>`, and `<div class="post-content">` per file.
- [ ] All post content (including appendices, lists, tables, etc.) is inside `<div class="post-content">`.
- [ ] No content after the closing `</main>` tag.
- [ ] No duplicate or orphaned tags (e.g., no extra `</div>`, `</ul>`, etc.).
- [ ] Navigation and header are outside `<main>`, not duplicated.
- [ ] `<title>` and `<meta name="description">` are updated for the post.
- [ ] Canonical URL points to the live published post URL.
- [ ] Open Graph metadata is present for link previews.
- [ ] Twitter card metadata is included only if you want X/Twitter polish.
- [ ] Analytics scripts are included: `<script src="../js/analytics-config.js"></script>` and `<script defer src="../js/analytics.js"></script>`
- [ ] Validate HTML with a linter or validator if possible.
- [ ] Test in browser: all content should be inside the styled container, nothing should overflow or appear outside the main post area.

## Common Pitfalls
- Accidentally duplicating the entire HTML structure (e.g., pasting a second `<html>...</html>` inside the file).
- Closing the `.post-content` `<div>` too early, leaving content outside the main container.
- Leaving orphaned content after the closing `</main>` tag.
- Not updating the `<title>`, `<meta name="description">`, or `<p class="post-date">` for each post.
- **Forgetting the analytics scripts** in `<head>`. Without them, page views won't be tracked. Always include both `analytics-config.js` and `analytics.js`.

---

**Tip:**
If converting from Markdown, always paste the converted HTML inside the `<div class="post-content">` and review the structure before publishing.
