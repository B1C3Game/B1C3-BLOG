# B1C3 Blog

A lightweight, static blog for B1C3 founder content. No framework, no build step, and visual alignment with the live B1C3 landing page.

This repository belongs to https://github.com/B1C3Game/B1C3-BLOG.

## Design Principles

- **Minimal but complete** — HTML + CSS only. No framework or runtime complexity.
- **Brand-consistent** — Reuses the same typography, palette, atmosphere, panels, and footer motif as the current B1C3 landing page.
- **Content-first** — Posts live as `.html` files. Easy to add new posts.
- **Scalable structure** — Directory layout supports unlimited posts.
- **Deploy anywhere** — GitHub Pages compatible, no build step required.

## Setup

The blog is ready to use. Push to GitHub and enable GitHub Pages in repository settings:

1. **Repository**: `B1C3Game/B1C3-BLOG`
2. **Settings → Pages**: Source = `Deploy from a branch`, Branch = `main` (or `master`)
3. **Deployed at**: `https://b1c3game.github.io/B1C3-BLOG/`

## Directory Structure

```
B1C3-BLOG/
├── index.html              # Blog homepage
├── css/
│   ├── style.css          # Main styles
│   └── responsive.css     # Mobile/tablet breakpoints
├── posts/
│   ├── manifesto.html     # Post: The B1C3 Manifesto
│   ├── first-follower.html # Post: The First Follower
│   └── [post-name].html   # Add new posts here
├── static/
│   ├── images/            # Hero images, diagrams
│   └── fonts/             # Custom fonts (if any)
├── js/
├── .github/
│   └── workflows/
│       └── deploy.yml     # GitHub Pages auto-deploy
└── README.md              # This file
```

## Adding a New Post

### 1. Create HTML File

Create a new file in `posts/` by copying one of the existing post files and changing the metadata copy in the article hero plus the body content.

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Your Post Title | B1C3 Blog</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@400;500;700&family=JetBrains+Mono:wght@500&family=Libre+Baskerville:wght@700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="../css/style.css">
  <link rel="stylesheet" href="../css/responsive.css">
</head>
<body>
  <div class="atmosphere" aria-hidden="true"></div>
  <header class="site-header">
    <a class="brand" href="https://b1c3game.github.io/multi-agent-collab-test/">B1C3</a>
    <nav aria-label="Primary">
      <a href="../index.html">Blog</a>
      <a href="https://b1c3game.github.io/multi-agent-collab-test/" target="_blank" rel="noreferrer">Home</a>
      <a href="https://github.com/B1C3Game/B1C3-BLOG" target="_blank" rel="noreferrer">GitHub</a>
    </nav>
  </header>

  <main>
    <section class="article-hero reveal">
      <p class="eyebrow">Category label</p>
      <h1>Your Post Title</h1>
      <p class="lead">One sentence that frames the post before the body starts.</p>
      <p class="post-date">Published: YYYY-MM-DD</p>
    </section>

    <article class="panel post reveal">
      <div class="post-content">
        <p>Start writing...</p>
      </div>

      <div class="post-nav">
        <a href="../index.html" class="back-link">← Back to blog</a>
      </div>
    </article>
  </main>
</body>
</html>
```

### 2. Update `index.html`

Add a card to the posts panel in `index.html`:

```html
<article class="card post-card">
  <p class="card-meta">YYYY-MM-DD</p>
  <h3>Your Post Title</h3>
  <p>A short excerpt or preview of your post...</p>
  <a href="posts/your-post-title.html">Read the post</a>
</article>
```

### 3. Commit & Push

```bash
git add .
git commit -m "Add: Your Post Title"
git push origin main
```

GitHub will auto-deploy within seconds. Check `https://b1c3game.github.io/B1C3-BLOG/` to verify.

## Styling

All posts automatically inherit styles from:
- `css/style.css` — Shared landing-page brand tokens, typography, panels, cards, and article styles
- `css/responsive.css` — Mobile breakpoints for header, cards, and reading layout

### Key CSS Classes

- `.brand` — B1C3 pill logo in the shared header
- `.hero` and `.article-hero` — Landing-page-style page intros
- `.panel` and `.card` — Shared surface system from the landing page
- `.post-card` — Blog card variant on the homepage
- `.post` — Single post page
- `.post-content` — Post body (paragraphs, headings, links)
- `.post-date` — Publication date

See `css/style.css` for customization options (colors, fonts, spacing).

## Navigation

- Shared pill-style B1C3 brand mark
- Links to Blog, current live Home, and GitHub
- Same typography and spacing logic as the landing page

## Deployment

### GitHub Pages (Automatic)

Push to `main` → GitHub Pages deploys automatically via `.github/workflows/deploy.yml`.

### Manual Deploy

1. Ensure GitHub Pages is enabled in Settings → Pages
2. Source: `Deploy from a branch`
3. Branch: `main`
4. Save & done

## Features

✅ Mobile-first responsive design  
✅ Accessible (semantic HTML, WCAG 2.1 AA)  
✅ Fast (zero dependencies, static files only)  
✅ SEO-friendly (proper meta tags, semantic markup)  
✅ Reduced motion support (`prefers-reduced-motion`)  
✅ Brand-aligned with the current B1C3 landing page  

## Local Development

To preview locally, simply open `index.html` or any post in your browser—no build step needed.

If you want a local server:

```bash
# Python 3
python -m http.server 8000

# Then visit: http://localhost:8000
```

## License

All posts are open source. See [GitHub Repo](https://github.com/B1C3Game/B1C3-BLOG) for details.
