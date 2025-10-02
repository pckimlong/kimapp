# Riverpod 3 / Analyzer 7 Migration Notes

## Current snapshot (2025-???)
- kimapp_form_generator, table_model_generator, kimapp_schema_generator, and table_structure_generator now use analyzer Element2 APIs and Riverpod 3 types.
- Workspace still fails `dart analyze` / `build_runner` because autoverpod_generator and its models continue to depend on legacy analyzer elements and Riverpod 2 provider names.

## High-priority follow-up
1. Port `pubs/autoverpod_generator` to Element2:
   - update all `Element`, `ClassElement`, `FieldElement`, etc. references to their `...Element2` counterparts.
   - replace `getElementDeclaration` calls with `getFragmentDeclaration` and use fragment-aware AST access.
   - audit generator outputs for removed provider symbols (`AutoDisposeNotifierProvider`, `state`, `ref.watch` patterns) and align with Riverpod 3 API.
2. Regenerate code
   - run `dart run build_runner build --delete-conflicting-outputs` in `kimapp_generator` and `autoverpod_generator` once generators compile.
   - refresh example outputs (`packages/kimapp_generator/example`, `pubs/autoverpod_generator/example`).
3. Workspace validation
   - `dart run melos exec -- dart analyze`.
   - targeted widget/provider tests where they exist.

## Helpful references
- `fix.md`: long-form migration checklist already in repo.
- Riverpod 3 migration guide + analyzer element-model migration notes.

Keep this file updated as sections of autoverpod migrate so we can resume quickly.
