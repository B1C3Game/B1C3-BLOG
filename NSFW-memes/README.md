# NSFW Meme Lab Infrastructure

This folder is for experimental meme development where each meme has its own folder, source asset, and ChatGPT prompt documentation.

## Goals

- One folder per meme.
- Prompt documentation stored in the same folder as the meme asset.
- Urban Dictionary style self-explanatory framing for every meme concept.
- Clean handoff between prompt design, image generation, and publishing.

## Structure

```
NSFW-memes/
  _template/
    PROMPT_CHATGPT.md
    MEME_CARD.md
    metadata.json
  _tools/
    new-meme.ps1
    import-loose-files.ps1
    publish-selected.ps1
  <meme-slug>/
    PROMPT_CHATGPT.md
    MEME_CARD.md
    metadata.json
    assets/
      original.<ext>
    exports/
```

## Required Files Per Meme

- `PROMPT_CHATGPT.md`: prompt(s) to run in ChatGPT web.
- `MEME_CARD.md`: Urban Dictionary style explanation.
- `metadata.json`: basic tracking and workflow status.
- `assets/original.<ext>`: source image asset used for the meme.

## Quick Start

Create a new meme folder from template:

```powershell
.\_tools\new-meme.ps1 -Name "context-over-vibes"
```

Import loose image files in this root into per-meme folders:

```powershell
.\_tools\import-loose-files.ps1
```

Create a dedicated NSFW meme page from an existing meme slug:

```powershell
.\_tools\new-meme-page.ps1 -Slug "poc-06-literacy-framing-risk-87fedc8a-5f0b-41d4-91a3-d3ee5869b2ca" -PageSlug "literacy-framing-risk" -Title "Literacy Framing Risk"
```

Publish a selected meme image into blog static assets:

```powershell
.\_tools\publish-selected.ps1 -Slug "photo-2026-06-20-09-45-41" -OutputName "mirror-doctrine-v1"
```

## Workflow

1. Generate or select one base image.
2. Store base image in `assets/original.<ext>`.
3. Fill `PROMPT_CHATGPT.md` with exact production prompt and variants.
4. Fill `MEME_CARD.md` with self-explanatory meaning and usage.
5. Export final variants into `exports/`.
6. Create or update a dedicated meme page in `../nsfw/memes/<page-slug>.html`.
7. Add or update the card in `../nsfw/index.html` and point it to the meme page, not directly to the raw asset.
8. Move selected final image to `static/images/` when publishing a blog post.

Or use `publish-selected.ps1` to copy the selected asset automatically and mark the meme as published.

See also: `../nsfw/NSFW-PUBLISHING-WORKFLOW.md`

## Notes

- Keep prompt language explicit and reproducible.
- Keep meme explanations concrete, no hidden inside jokes.
- Avoid putting sensitive personal data in prompts or metadata.
