# Publishing a New Blog Post on B1C3-BLOG

This guide extracts and clarifies the instructions from the main README for publishing a new post on GitHub Pages using the B1C3-BLOG repository.

---

## 1. Prepare Your Post
- Finalize your post as an HTML file. You can copy an existing post in `posts/` as a template.
- Update the metadata in the `<head>` and the article hero section (title, date, lead sentence, etc).

## 2. Add the Post File
- Place your new HTML file in the `B1C3-BLOG/posts/` directory.
- Example: `B1C3-BLOG/posts/how-agents-will-make-you-struggle.html`

## 3. Update the Blog Index
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


## 4. Commit and Publish to GitHub

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

## 5. Verify on GitHub Pages

- Visit `https://b1c3game.github.io/B1C3-BLOG/` in your browser.
- Confirm your new post appears on the homepage and the link works.

---


### Notes
- No build step is required. Just HTML, CSS, and Git.
- For style and structure, see the example posts in `posts/` and the CSS in `css/`.
- For images, place them in `static/images/` and reference them in your HTML.
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

---

This file replaces the step-by-step instructions from the main README for easier reference and future updates.
