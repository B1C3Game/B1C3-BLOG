
# Blog Draft: The Infrastructure Paradox
## Subtitle: Why building beautiful UX requires fighting your own tools

### The Problem

You want to build something simple: a persona component. Dynamic, interactive, human-readable. You design it. You scaffold it. You make it work locally. You deploy it to GitHub Pages. It's live. It's beautiful.

Then you add a feature: persona chooser (dropdown, loads JSON, switches personas). Simple. Clean. The right architecture.

Copilot builds it. It works. The dropdown works. The JSON loads. The personas switch. It's incredible.

Then you add another feature: Schema Rationale (collapsible guide explaining why each field exists). Same pattern. Same simplicity.

And suddenly: everything disappears.

Not "breaks." Disappears. The whole component goes blank. No errors. Just gone.

Three hours of debugging later:


### The Root Cause

The root cause wasn't the code. The code was fine. It was the infrastructure demanding ceremonies.

Vite needs to know if you're serving from `/` or `/personas-demo/`. If you get it wrong, the whole build breaks. Not gracefully. Catastrophically.

GitHub Pages auto-deploys. So you push code, it breaks, you don't know why. You pull, fix locally, push again. The feedback loop is hours, not seconds.

Meanwhile, Copilot is solving the right problems (persona loading, dynamic rendering, schema rationale). But the infrastructure is eating the day.

### The Paradox

Modern web development promises to make building easier. "Just use Vite! Fast builds! Hot reload!"

But the moment you go beyond a single-file component, you're negotiating with:

- Build tools (`Vite`, `esbuild`, `rollup`)
- Deployment systems (GitHub Pages, CORS headers, asset paths)
- Environment differences (dev server vs. production)
- Configuration files (`vite.config.js`, `package.json`, `.github/workflows/`)

Each one is trying to help. Each one adds a layer. And if you get one thing wrong, the whole thing collapses.

### The Real Cost

- **1 hour:** Building the persona chooser (Copilot: incredible)
- **2 hours:** Fighting infrastructure (Me: terrible)
- **Result:** Something that works, but the time to confidence is obscene

You're not building a persona component anymore. You're building a build pipeline, a deployment system, an asset management strategy, a configuration management system.

### The Alternative

What if you could just... write code and see it work immediately?

Not "wait for the build." Not "push and wait for deploy." Not "debug asset paths and base URLs."

Just: write → see → iterate.

This is what server-side rendering had. This is what static sites have. This is what... well, most of the web had before we decided to turn JavaScript into a compilation language.

### The Irony

I'm building something about making complex user models simple (personas). I'm using a tech stack that makes simple builds complex.

### The Lesson

Infrastructure has opinions. Heavy ones. You're not just building the feature; you're building for the infrastructure.

### The Confusing Part

There is another failure mode that feels small but is actually huge: false closure.

An assistant says, "You can now reload the app and continue," and one second later you get:

> `http://localhost:5178/personas-demo/src/components/PersonaReveal.vue?... net::ERR_ABORTED 500 (Internal Server Error)`

That sequence is brutal for trust. It communicates completion when the system is still failing.

This is not just a bug. It's a coordination failure between language and system state.

- The message implies: resolved.
- The runtime reality says: unresolved.
- The user absorbs both at once and loses confidence in the loop.

If AI tooling wants to be reliable in production workflows, it has to stop doing premature reassurance. Better language would be:

"Changes are applied. Reload now and confirm. If it still fails, share the first error line and we will continue from that state."

That one shift keeps context honest.

---

## Chat Comments

**ME:**  
That's a good blog post. And here this too. I noticed that I put in a parenthesis in the wrong place in a paragraph:

> "And the organization—when it listens—breaks down silos (making sure support knowledge actually reaches the people who need it) and closes the loop between intent and experience. Making support a feedback engine isn't just operationally smart; it's an example of what MTO is trying to enable: breaking down silos between human experience, technical systems, and organizational decisions."

The parenthesis should be after the other "silo".

I think this is what AI does. It sort of fragments the code and makes very simple mistakes. I think because its context window is so small. I don't know why but it feels like it's the same. It seems to not be able to grasp a full `.vue` file. This is GPT-4.1 we should say too.

---

**Wijak:**  
You're onto something real here.

**The parenthesis mistake:**

Current (wrong):

> "breaks down silos (making sure support knowledge actually reaches the people who need it) and closes the loop"

Should be:

> "breaks down silos and closes the loop (making sure support knowledge actually reaches the people who need it)"

The parenthetical remark applies to both "breaks down silos" AND "closes the loop." By putting it mid-sentence, it only modifies one half. Context is lost.

**Why this happens:**  
You're right. It's not stupidity. It's context fragmentation.

GPT-4.1 (and Claude, honestly) don't "read" files holistically. They:

- Tokenize the input
- Chunk it into context windows
- Generate tokens autoregressively (one token at a time, committing to choices)
- Lose the "full picture" halfway through

For a `.vue` file:

- Template section (structure)
- Script section (logic)
- Style section (presentation)

A model should understand how all three interact. But if the file is long:

- First half of template loaded
- Script section gets abbreviated in context
- Style section... maybe not there at all
- Model generates Script code that breaks the template
- Nobody noticed because there's no real-time feedback

**The fix in small tokens:**

- Vue file parsed into three independent sections
- Each section has its own "purpose statement" prepended
- Model sees: "TEMPLATE: [structure]. SCRIPT: [logic]. STYLE: [css]."
- Constraints are explicit, not implicit

**This is why Copilot works better at:**

- Small files (context fits)
- Single-purpose functions (doesn't need to hold 5 concepts)
- Well-commented code (constraints are stated)

**And struggles with:**

- Large components (context fragmentation)
- Cross-cutting concerns (template + script + style coordination)
- Implicit dependencies (assumes knowledge from earlier in the file)

**For the blog:**  
This is worth a separate piece: "Why AI Fragments Code: A Context Window Story"

- Explain tokenization
- Show how a `.vue` file chunks
- Demonstrate where the fragments happen
- Propose: better prompting, file structure, or tooling to prevent it