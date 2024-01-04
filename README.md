# [4004.com](https://www.4004.com)

[![Build](https://github.com/SuperSodaSea/4004.com/actions/workflows/build.yaml/badge.svg)](https://github.com/SuperSodaSea/4004.com/actions/workflows/build.yaml)

Source code for <https://www.4004.com/>, powered by [VitePress](https://vitepress.dev/).

Preview latest build: <https://supersodasea.github.io/4004.com/>

## Prerequisites

- [Node.js](https://nodejs.org/)
- [pnpm](https://pnpm.io/)

## Instructions

Install dependencies:
```bash
pnpm install
```

Clean cache:
```bash
pnpm run clean
```

Run type check:
```bash
pnpm run types
```

Build the site:
```bash
pnpm run build
```
The build output is in the `src/.vitepress/dist` directory.

Build the site for distribution (run clean, type check, then build):
```bash
pnpm run dist
```

Start local dev server (no need to build, hot reload enabled):
```bash
pnpm run dev
```

Start local preview server (need to build first):
```bash
pnpm run preview
```
