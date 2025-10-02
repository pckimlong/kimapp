# Riverpod 3 / Analyzer 7 Migration Notes

## Current snapshot (2025-???)
- kimapp_form_generator, table_model_generator, kimapp_schema_generator, and table_structure_generator now use analyzer Element2 APIs and Riverpod 3 types.
- Workspace still fails `dart analyze` because packages that consume autoverpod_generator (kimapp_generator, kimapp_supabase_helper, examples) haven't yet been updated to the new Riverpod 3 APIs.

## High-priority follow-up
1. ✅ Port `pubs/autoverpod_generator` to Element2 / Riverpod 3 APIs.
2. Regenerate code in dependents
   - run `dart run build_runner build --delete-conflicting-outputs` in `kimapp_generator`, `autoverpod_generator`, and their examples after updating templates.
   - refresh example outputs (`packages/kimapp_generator/example`, `pubs/autoverpod_generator/example`).
3. Migrate consumers
   - update `kimapp_generator` outputs & templates to the new Riverpod 3 provider APIs (replace legacy mixins/providers, stop importing `riverpod/src/...`).
   - update `kimapp_supabase_helper` providers to the new notifier APIs (`Notifier`, `AsyncNotifier`, `Ref` helpers) and drop private `riverpod/src` imports.
4. Workspace validation
   - `dart run melos exec -- dart analyze` once generators/consumers compile.
   - targeted widget/provider tests where they exist.

## Helpful references
- `fix.md`: long-form migration checklist already in repo.
- Riverpod 3 migration guide + analyzer element-model migration notes.

Keep this file updated as sections of autoverpod migrate so we can resume quickly.
