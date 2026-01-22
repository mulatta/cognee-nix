# cognee-nix

Nix flake providing cognee and related Python packages.

## Packages

| Package                       | Description                                         |
| ----------------------------- | --------------------------------------------------- |
| `cognee`                      | Memory management for AI applications and AI agents |
| `mem0`                        | Memory layer for AI apps (mem0ai)                   |
| `fastapi-users`               | FastAPI users authentication                        |
| `fastapi-users-db-sqlalchemy` | SQLAlchemy database adapter for fastapi-users       |

## Usage

### Build

```bash
nix build .#cognee
nix build .#mem0
```

### Python Environment

```nix
python3.withPackages (ps: [ cognee mem0 ])
```

### NixOS Configuration

```nix
environment.systemPackages = [
  (pkgs.python3.withPackages (ps: [ ps.cognee ]))
];
```

## Optional Dependencies

cognee supports optional features via override pattern:

| Feature      | Flag           | Packages                                  |
| ------------ | -------------- | ----------------------------------------- |
| Neo4j        | `withNeo4j`    | neo4j                                     |
| ChromaDB     | `withChromadb` | chromadb, pypika                          |
| PostgreSQL   | `withPostgres` | psycopg2, pgvector, asyncpg               |
| Web Scraping | `withScraping` | protego, playwright, beautifulsoup4, lxml |

### Enabling Optional Features

```nix
# Single feature
cognee.override { withNeo4j = true; }

# Multiple features
cognee.override {
  withNeo4j = true;
  withChromadb = true;
  withScraping = true;
}

# In Python environment
python3.withPackages (ps: [
  (ps.cognee.override { withNeo4j = true; withPostgres = true; })
])
```

### PostgreSQL Feature Note

The `withPostgres` option requires `allowBroken = true` in Nix configuration due to a broken test hook in nixpkgs (`postgresqlTestHook`). This only affects Nix evaluation; runtime functionality is unaffected.

```nix
# NixOS
{ nixpkgs.config.allowBroken = true; }

# CLI
NIXPKGS_ALLOW_BROKEN=1 nix build --impure .#...
```

## Environment Variables

### MEM0_DIR

mem0 creates a config directory at import time. Set `MEM0_DIR` to a writable location:

```bash
export MEM0_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/mem0"
```

Without this, mem0 attempts to write to `~/.mem0`, which may fail in read-only environments.

## Development

```bash
nix develop    # Enter dev shell
nix flake check    # Build all packages
nix fmt    # Format code
```

## License

Apache-2.0
