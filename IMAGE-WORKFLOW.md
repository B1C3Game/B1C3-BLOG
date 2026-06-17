# B1C3 Blog Image Workflow

Guidelines for implementing images that work across devices, meet accessibility standards, and optimize performance.

---

## File Organization

**Location:** All images go in `static/images/`

**Naming convention:** Descriptive, kebab-case, include post name or context
- ✓ `generative-intelligence-horizon.png`
- ✓ `toolbox-chess-board.jpg`
- ✗ `image1.png`
- ✗ `screenshot.jpg`

---

## Image Formats & Optimization

### Format Selection
- **PNG:** Graphics, diagrams, charts, screenshots (lossless compression)
- **JPG:** Photographs, illustrations, complex visuals (lossy compression)
- **WebP:** Modern format for smaller file sizes (optional fallback chain)

### File Size Requirements
- Mobile-first: target images **≤ 500KB** for web delivery
- Use compression tools before adding to repo:
  - Online: TinyPNG, Squoosh.app
  - Command: `ffmpeg` or `ImageMagick` for batch processing
- Maintain originals separately (outside repo) if needed

### Dimensions
- **Maximum width:** 800px (blog content width)
- **Mobile (mobile-first):** 100% width, responsive
- **Desktop:** 100% of container (respects CSS `max-width`)

---

## HTML Implementation

### Basic Responsive Image (Recommended)

```html
<figure class="post-image">
  <img 
    src="../static/images/image-name.png" 
    alt="Descriptive text that explains what the image shows and its relevance"
    loading="lazy"
    width="800"
    height="600"
  />
  <figcaption>Optional: Short caption describing the image or its source</figcaption>
</figure>
```

### Advanced: Multiple Resolutions (For Large Photos)

```html
<figure class="post-image">
  <picture>
    <!-- Mobile first (small) -->
    <source 
      media="(max-width: 480px)" 
      srcset="../static/images/image-name-sm.png"
    />
    <!-- Tablet (medium) -->
    <source 
      media="(max-width: 768px)" 
      srcset="../static/images/image-name-md.png"
    />
    <!-- Desktop (large) -->
    <img 
      src="../static/images/image-name-lg.png"
      alt="Descriptive text"
      loading="lazy"
      width="800"
      height="600"
    />
  </picture>
  <figcaption>Optional caption</figcaption>
</figure>
```

### CSS for Responsive Container

Add to `css/style.css`:

```css
.post-image {
  margin: 2rem 0;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.post-image img {
  max-width: 100%;
  height: auto;
  display: block;
  border-radius: 4px;
}

.post-image figcaption {
  font-size: 0.875rem;
  color: #666;
  font-style: italic;
  text-align: center;
}

/* Mobile optimization */
@media (max-width: 768px) {
  .post-image {
    margin: 1.5rem 0;
  }
}
```

---

## Accessibility (WCAG 2.1 AA Compliance)

### Alt Text Standards

**Required:** Every `<img>` must have an `alt` attribute.

**Good alt text:**
- Describes the image's content AND its relevance to the post
- Not decorative? Include context. Decorative? Use `alt=""`
- 125 characters max (but be complete)
- Do NOT start with "image of" or "picture of"

**Examples:**

✓ Good:
```html
<img alt="Horizon line at calm ocean with soft gradient sky, representing a moment of pause in thought" />
```

✓ Good:
```html
<img alt="Chessboard with B1C3 opening move highlighted, illustrating action-first philosophy" />
```

✗ Bad:
```html
<img alt="image of a horizon" />
<img alt="" /> <!-- Missing context -->
<img /> <!-- No alt attribute -->
```

### Other Accessibility Requirements

1. **Color contrast:** If images contain text, ensure text contrast ≥ 4.5:1 (WCAG AA)
2. **Meaningful captions:** Use `<figcaption>` for source attribution or important context
3. **Avoid text-only images:** If the image contains essential information, repeat it in the post text
4. **Lazy loading:** Use `loading="lazy"` to improve page performance without blocking

---

## Mobile Optimization

### Viewport Meta Tag (Already in template, confirm presence)

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
```

### Responsive Images Workflow

1. **Design mobile first:** Image should look good at 320px width
2. **No fixed widths:** Use `max-width` and `width: 100%` in CSS
3. **Test breakpoints:**
   - Mobile: 375px (iPhone 12)
   - Tablet: 768px (iPad)
   - Desktop: 1024px (desktop)
4. **Use density-based srcset for high-DPI screens:**

```html
<img 
  src="../static/images/image-name.png"
  srcset="../static/images/image-name.png 1x,
          ../static/images/image-name@2x.png 2x"
  alt="Description"
  loading="lazy"
  width="800"
  height="600"
/>
```

---

## Performance Checklist

- [ ] Image is compressed (TinyPNG or equivalent)
- [ ] File size ≤ 500KB
- [ ] Dimensions are exact (width/height attributes set)
- [ ] `loading="lazy"` is present
- [ ] Alt text is descriptive and ≤ 125 characters
- [ ] Image tested on mobile (375px), tablet (768px), desktop (1024px)
- [ ] Aspect ratio is consistent across screen sizes
- [ ] Figcaption included if context needed (source, credit)
- [ ] File named descriptively and stored in `static/images/`

---

## Workflow Example: Adding an Image to a Post

### 1. Prepare the image
```powershell
# Compress image
# Use TinyPNG online or:
# ffmpeg -i source.png -q:v 2 compressed.png
```

### 2. Copy to repo
```powershell
Copy-Item "source.png" "C:\2\B1C3\B1C3-BLOG\static\images\post-name-descriptor.png"
```

### 3. Add to post HTML
```html
<figure class="post-image">
  <img 
    src="../static/images/post-name-descriptor.png"
    alt="Concise, meaningful description"
    loading="lazy"
    width="800"
    height="600"
  />
  <figcaption>Source or context if relevant</figcaption>
</figure>
```

### 4. Verify
- [ ] Mobile (DevTools: 375px)
- [ ] Tablet (768px)
- [ ] Desktop (1024px)
- [ ] Alt text reads well with screen reader
- [ ] File size confirmed ≤ 500KB

---

## Tools & Resources

### Image Compression
- [TinyPNG](https://tinypng.com/) — PNG/JPG compression, easy interface
- [Squoosh](https://squoosh.app/) — Google's image optimizer, WebP support
- [ImageMagick](https://imagemagick.org/) — CLI tool for batch processing

### Testing
- Chrome DevTools: responsive design mode (F12 → device emulation)
- WAVE (WebAIM): accessibility validator
- Lighthouse: performance audits (Chrome DevTools → Lighthouse)

### WCAG Compliance
- [Web Content Accessibility Guidelines 2.1](https://www.w3.org/WAI/WCAG21/quickref/)
- Focus: Images (1.1.1 Non-text Content)

---

## Questions?

If an image doesn't look right on mobile, check:
1. Is `width: 100%` applied in CSS?
2. Is the image larger than the viewport?
3. Is `max-width` set on the container?
4. Did you test on actual mobile or DevTools only?
