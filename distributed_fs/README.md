# Distributed Cryptographic Filesystem (D Version)

This directory contains a lightweight Plan9-style filesystem implemented in D.
It reuses ideas from the early `internetcomputer` repository and stores data
blocks in a small disk-backed DHT so state persists between runs.

Modules included:

- `fs/` – Plan9-like nodes and helpers
- `client/` – mounting helpers
- `server/` – server entry points
- `network/` – coordination stubs
- `crypto/` – placeholder crypto routines
- `metadata/` – asynchronous metadata buffer
- `storage/` – disk-backed DHT providing RAID-like redundancy

Running `make` builds the server which initializes a small filesystem tree and
stores an example file in the DHT.
