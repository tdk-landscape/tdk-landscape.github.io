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

---

⭐ **Using TDK?** [Star tdk-cli-core](https://github.com/tdk-landscape/tdk-cli-core) so other developers can find it.
