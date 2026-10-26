# AviPulsa — Cloudflare Deployment Bundle

**Starting point:** AviPulsa Stage 2.4.1 Evidence-Aware HTML prototype  
**Bundle date:** 2026-10-25  
**Status:** Static frontend is ready for a Pages deployment test. Worker is a starter scaffold only.

## Included

- `frontend/index.html` — the existing Stage 2.4.1 app, preserved as the Pages entry point.
- `assets/avipulsa-logo.svg` and `assets/avipulsa-icon.svg` — simple SVG brand assets supplied with this bundle.
- `worker/src.js` — minimal API health endpoint; does not yet read or write farm data.
- `worker/wrangler.toml` — Worker configuration starter.
- `worker/migrations/0001_initial_schema.sql` — proposed initial D1 schema; not production hardened.
- `DEPLOYMENT_CHECKLIST.md` — step-by-step deployment and validation instructions.

## Important limitations

The current frontend uses browser storage (`localStorage`) and its own backup/restore functions. Publishing it to Cloudflare Pages does **not** add cross-device synchronization, shared farm accounts, server-side backups, or server-enforced audit history. Browser data can be lost if site data is cleared, and it is not automatically available on another device.

The Worker currently provides only `GET /api/health`. It is not connected to the frontend. Do not enter sensitive or mission-critical production records on the assumption that cloud synchronization is active.

Before production use, implement and test authentication, farm-level authorization, server-side record CRUD, append-only audit enforcement for corrections, validated schema migrations, protected backups, and a tested recovery procedure. A server-side audit log must preserve original values and record correction timestamp, operator, device identifier/name, old/new values, reason, and audit ID.

## GitHub Pages setup (Cloudflare Pages)

1. Create a new GitHub repository, for example `avipulsa`.
2. Upload the contents of this ZIP to the repository root (so `frontend/` and `worker/` are visible at the top level).
3. In Cloudflare, go to **Workers & Pages → Create → Pages → Connect to Git**.
4. Select the repository.
5. Framework preset: **None**.
6. Root directory: `frontend`.
7. Build command: leave blank.
8. Build output directory: `.`.
9. Deploy. Open the resulting Pages URL and test it on desktop and Android.

If Cloudflare's dashboard requires root directory to be blank, use repository root and set build output directory to `frontend` instead. Do not set root to `frontend` and output to `frontend` simultaneously.

## Create the Worker separately

1. In Cloudflare, go to **Workers & Pages → Create → Worker** and connect/import the same repository if the dashboard supports it, or create a Worker from `worker/src.js`.
2. Set the Worker entry point to `worker/src.js` and use `worker/wrangler.toml` as the configuration reference.
3. Deploy and test `https://YOUR-WORKER-DOMAIN/api/health`.
4. Expected response includes `"ok": true` and a note that farm data sync is not implemented.

The supplied Worker configuration is a starter. Depending on the Cloudflare Git deployment flow, you may need to configure the Worker root/build settings or create the Worker from the dashboard and paste `worker/src.js`. Do not add a D1 binding until you have created a database and replaced the placeholder database ID.

## Current app behavior

The HTML file retains the prototype's existing Stage 2.4.1 behavior. It has not been refactored into a multi-file app or wired to the Worker. The logo SVG files are included as separate assets and are not guaranteed to replace any embedded logo in the HTML.

## Validation before pilot use

- [ ] Pages build succeeds and app loads over HTTPS.
- [ ] Create a test farm, house and flock.
- [ ] Save a daily record; reload the page and confirm it remains.
- [ ] Export a farm backup, reset only test data, then import the backup and confirm recovery.
- [ ] Enter deliberately invalid test values and confirm quality warnings appear.
- [ ] Test record correction and confirm the app asks for a reason.
- [ ] Test on the intended Android device and desktop browser.
- [ ] Keep an exported backup in a separate safe location.
- [ ] Do not mark server synchronization or production audit as complete until a connected backend is implemented and independently tested.
