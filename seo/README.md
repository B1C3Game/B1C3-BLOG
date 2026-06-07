# SEO Baseline for B1C3 Blog

This folder is the SEO home for the blog.
The goal is not to overbuild SEO. The goal is to cover the basics well enough that the site is indexable, understandable, and easy to grow later.

---

## What SEO Means Here

For this blog, SEO should cover:
- Search engines can find the site
- Search engines can understand each page
- Social shares look correct
- Pages have the right metadata
- The site stays fast and readable

This is a static blog, so the biggest wins are simple and structural.

---

## Priority 1: Indexability

These are the minimum basics:
- `robots.txt` exists at the site root
- `sitemap.xml` exists at the site root
- Posts are linked from `index.html`
- Drafts are not indexed
- Each published page has a unique, descriptive URL

Current status:
- `robots.txt` exists
- `sitemap.xml` exists
- Published posts are linked from the homepage
- Drafts are blocked in `robots.txt`

---

## Priority 2: Page Metadata

Every page should have:
- A unique `<title>`
- A useful `<meta name="description">`
- A canonical URL
- Open Graph tags for link previews
- Twitter card tags only if you want extra polish on X/Twitter

Current status:
- Titles exist
- Descriptions exist on the main posts
- Canonical tags are not yet standardized
- Open Graph tags are still missing
- Twitter tags are optional

Recommended pattern for posts:
- Title: `Post Title | B1C3 Blog`
- Description: one sentence, clear and specific
- Canonical: the full published URL for that post
- Open Graph: use the page title, description, canonical URL, and a relevant preview image when available

---

## Priority 3: Content Structure

Search engines and readers both benefit from clear structure:
- One `h1` per page
- Clear section headings (`h2`, `h3`)
- Human-readable URLs
- Internal links between related posts
- Alt text on images

Current status:
- Post structure is generally strong
- URLs are readable
- Internal linking is manual and inconsistent
- Image handling is still minimal

---

## Priority 4: Social Sharing

Even if you do not care about social media, Open Graph metadata helps search and preview quality.

Add to every published page:
- `og:title`
- `og:description`
- `og:url`
- `og:type`
- `og:image` when relevant

Twitter card tags are optional. Add them only if you care about X/Twitter previews.

If you do nothing else beyond the basics, add these.

---

## Priority 5: Crawl Hygiene

Keep crawlers pointed at the right things:
- `robots.txt` should allow the public blog
- Drafts should stay blocked
- If a page is not meant to be public, keep it out of navigation and sitemap
- Avoid accidental duplicate URLs

---

## Priority 6: Performance

SEO and performance are linked.
A static site already has a good base, but still watch:
- Page weight
- Unnecessary scripts
- Large images
- Render-blocking resources

The blog is already lightweight, which is good.

---

## What To Build Next

The next practical SEO steps are:
1. Create `sitemap.xml`
2. Add canonical tags to all published pages
3. Add Open Graph tags to all published pages
4. Add a simple internal-linking habit for related posts
5. Optionally generate metadata from a small template so every new post is consistent

---

## Working Rule

If a page is meant to be public, make it:
- indexable
- preview-friendly
- descriptive
- fast
- linked from somewhere important

If it does not meet that bar, it should stay a draft.
