# Public Content Cleanup Plan

Status: proposal

Date: 2026-09-03

## Reason

The public blog currently contains roughly 48 post cards and the NSFW lane roughly 46 meme cards. The surfaces mix current work, historical essays, personal experiments, unfinished imports, review queues and speculative doctrine.

The goal is not to erase the archive. The goal is to make the public front door legible: current work first, selected durable writing second, experiments and unfinished material private or archived.

## Immediate Removal

- [x] Remove `posts/spectrum-as-self-regulation.html`.
  - It contains personal relationship details.
  - It makes broad medical, political and AI-takeover claims without enough framing.
  - It does not support the current Aishna/B1C3 public direction.
- [x] Create [NSFW-CURATION-QUEUE.md](NSFW-CURATION-QUEUE.md) before changing the large NSFW index.
  - The first NSFW cut should remove unfinished material from public navigation while preserving source folders.

## Public Blog Tiers

### Keep And Feature

Current, grounded writing about:

- Aishna and agent systems.
- A2A/MCP, security, consent, authority and provenance.
- B1C3 operating principles that are useful outside the private workspace.
- Concrete technical incidents and evidence-backed work.

### Keep But Reduce Prominence

Durable personal or conceptual essays that still represent B1C3, but should not define the current startup direction.

### Archive Or Remove

- Draft-like posts presented as finished conclusions.
- Posts with unnecessary private details about other people.
- Unbounded claims presented as fact.
- Duplicate doctrine posts covering the same idea.
- Old experiments whose context is no longer available.
- Content that points to superseded landing pages or products.

## NSFW Rules

The NSFW index should not present 46 mixed-status items as one finished collection. Use three public groups at most:

1. **Selected works:** a small curated set with complete pages and clear framing.
2. **Lab archive:** older experiments kept for provenance but visually secondary.
3. **Private/import queue:** candidates, review-required items and unfinished imports removed from the public index.

The repository can retain source assets and prompt documentation without publishing every experiment as a public card.

## Review Criteria

For every public item, ask:

- Does it support the current B1C3/Aishna direction?
- Is the claim bounded and understandable without private context?
- Does it expose personal information about someone else?
- Is it clearly finished, or does it look like a draft/import?
- Does it have a useful public page, not only an asset dump?
- Would a serious partner understand why it is public?

## Next Cleanup Pass

- [x] Build a keep/archive/remove table for the first blog cleanup pass.
- [x] Reduce the blog index to a curated current set; post files remain available but are no longer front-page/sitemap content.
- [ ] Add an explicit archive page if the older writing should remain discoverable later.
- [ ] Build a keep/archive/remove table for all NSFW cards.
- [ ] Remove `Candidate`, `Review required` and unfinished `Campaign Import` cards from the public NSFW index.
- [ ] Keep source assets and documentation unless they create a privacy or legal problem.
- [ ] Rebuild sitemap entries from the public set.
- [ ] Check every remaining card for a working page and current description.

## Publishing Rule Going Forward

An experiment is not automatically a public post. Publish it only when the page has a clear status, bounded claims, a reason to exist publicly, and a destination that still works.
