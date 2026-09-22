# TDK CLI install page

Free short URL options:

```sh
curl -fsSL https://tdk-landscape.github.io/install.sh | sh
```

Use this if the repo is named `tdk-landscape.github.io`.

```sh
curl -fsSL https://tdk-landscape.github.io/tdk/install.sh | sh
```

Use this if the repo is named `tdk`.

## JSON Schema

Resource config schema, referenced from every `service.json` via `$schema`:

- https://tdk-landscape.github.io/schema.service.json

Source of truth is `tdk-cli-core/engine/schemas/service-schema.json`; copy changes here to republish.

## Publish

1. Create a public GitHub repo:
   - shortest: `tdk-landscape.github.io`
   - still short: `tdk`
2. Copy these files to that repo.
3. Enable GitHub Pages from the repo settings.
4. Keep CLI binaries in `tdk-landscape/tdk-cli-releases`.

