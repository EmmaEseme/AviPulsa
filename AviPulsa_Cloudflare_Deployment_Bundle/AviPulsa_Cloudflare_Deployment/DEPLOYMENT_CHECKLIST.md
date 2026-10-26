# AviPulsa Deployment Checklist

## A. Deploy the frontend to Cloudflare Pages
- [ ] Create GitHub repository `avipulsa` (or another chosen name).
- [ ] Upload ZIP contents to repository root.
- [ ] Connect repository in Cloudflare Pages.
- [ ] Use framework preset `None`.
- [ ] Recommended: root directory `frontend`; build command blank; output directory `.`.
- [ ] Wait for successful build and open the Pages URL.

## B. Smoke-test the prototype
- [ ] App loads without a blank screen.
- [ ] Create a test farm and flock.
- [ ] Add a daily record and reload.
- [ ] Export a backup and confirm a JSON file downloads.
- [ ] Restore the JSON backup.
- [ ] Check data-quality screen and baseline/trend views.
- [ ] Test Android display and navigation.

## C. Deploy the Worker starter separately
- [ ] Create Worker `avipulsa-api`.
- [ ] Use `worker/src.js` as the entry point.
- [ ] Deploy.
- [ ] Visit `/api/health`; confirm `ok: true`.
- [ ] Treat all other endpoints as unimplemented.

## D. Production blockers
- [ ] Connect frontend to authenticated API.
- [ ] Implement server-side CRUD and validation.
- [ ] Enforce farm/user permissions.
- [ ] Implement append-only audit events preserving prior values and correction reasons.
- [ ] Configure D1 binding and apply migrations only after reviewing schema.
- [ ] Add protected backup and restore/recovery procedures.
- [ ] Test sync across devices, browser closure, version upgrades and network interruptions.
- [ ] Security and data-loss review before using real operational records.
