# tdk-landscape.github.io

Short install URL and JSON schema host for [TDK CLI](https://github.com/tdk-landscape/tdk-cli-core).

## Install

```sh
curl -fsSL https://tdk-landscape.github.io/install.sh | sh
```

The script downloads the latest binary from [tdk-cli-releases](https://github.com/tdk-landscape/tdk-cli-releases/releases/latest). Prefer npm? `npm install -g @tdk-landscape/tdk-cli-core`.

## JSON Schema

Resource config schema, referenced from every `service.json` via `$schema`:

- https://tdk-landscape.github.io/schema.service.json

Source of truth is [`engine/schemas/service-schema.json`](https://github.com/tdk-landscape/tdk-cli-core/blob/main/engine/schemas/service-schema.json) in tdk-cli-core; copy changes here to republish.

### VS Code: validation and autocomplete for `service.json`

VS Code's built-in JSON support can validate `service.json` files against this schema and autocomplete their fields — no extension required.

**Option A — per file.** Add a `$schema` key to the top of any `service.json`:

```json
{
  "$schema": "https://tdk-landscape.github.io/schema.service.json",
  "appName": "my-service"
}
```

**Option B — whole workspace.** Most generated `service.json` files don't include `$schema`, so map the filename once instead. Add to `.vscode/settings.json`:

```json
{
  "json.schemas": [
    {
      "fileMatch": ["**/service.json"],
      "url": "https://tdk-landscape.github.io/schema.service.json"
    }
  ]
}
```

Reopen (or just click into) a `service.json` file and VS Code will underline invalid fields and suggest valid ones on <kbd>Ctrl</kbd>+<kbd>Space</kbd>.

---

⭐ **Using TDK?** [Star tdk-cli-core](https://github.com/tdk-landscape/tdk-cli-core) so other developers can find it.
