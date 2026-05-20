# bitcoin-portable

Run Bitcoin Core from any directory, on Windows / macOS / Linux, keeping its
data alongside the scripts (in `./data`) instead of in your home folder. Handy
for running a node off an external drive.

The pinned version is set by `BITCOIN_PORTABLE_VERSION` in `config.sh`
(currently **31.0**). On first run, the matching official Bitcoin Core release
for your OS/arch is downloaded from bitcoincore.org, checksum-verified (and
GPG-verified if `gpg` and the builder keys are available), and extracted.

## Usage

- `./setup` — download, verify, and extract Bitcoin Core for this platform.
  Runs automatically the first time you use any wrapper below.
- `./bitcoin` — launch the `bitcoin-qt` GUI with `-datadir=./data`.
- `./bitcoind` — run the node daemon with `-datadir=./data`.
- `./bitcoin-cli` — talk to a running node (uses `-datadir=./data`).
- `./bitcoin-qt`, `./bitcoin-wallet` — same, with `-datadir=./data`.
- `./bitcoin-tx`, `./bitcoin-util` — offline tools (no datadir).
- `./test` — run the helper-function smoke tests.
- `./run` — build and run `bitcoind` in Docker, persisting `./data` at `/data`.

## Notes

- **macOS (Apple Silicon):** Bitcoin Core's `.tar.gz` binaries ship with
  ad-hoc signatures that arm64 macOS rejects (the process is killed on launch).
  `setup` re-signs them ad-hoc after extraction so they run.
- **GPG verification:** to verify release signatures, import the builder keys:
  ```
  git clone https://github.com/bitcoin-core/guix.sigs
  gpg --import guix.sigs/builder-keys/*.gpg
  ```
  Without them, `setup` falls back to checksum-only verification and warns.
