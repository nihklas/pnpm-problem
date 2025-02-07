# Nix-PNPM-GitlabCI-HashMismatch

There seems to be a problem when building a nix pnpm derivation in the gitlab
pipeline.

Steps to initialize the pnpm project:
```bash
pnpm create vuetify
> barebones
> typescript -> yes
> choose pnpm
> install dependencies -> yes
```
