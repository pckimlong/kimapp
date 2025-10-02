# Riverpod v3 Migration Plan

1. **Verify workspace toolchain**
   - Lock Riverpod family dependencies to ^3.0.0 across packages and templates (done, re-run `dart pub get` once network access is available).
   - Capture upstream guidance (Riverpod 3 migration guide, analyzer 7 migration notes) for reference while implementing the changes below.

2. **Refactor core kimapp helpers**
   - Replace internal imports (`package:riverpod/src/...`) with the new public APIs (`AsyncNotifier`, `Notifier`, `AsyncLifecycle`, etc.).
   - Update helper mixins (`ProviderStatus*`, `RiverpodRefExtension`) to use the v3 `Ref` API (`ref.invalidateSelf`, `ref.keepAlive`, `ref.listen`/`ref.onDispose`) and the new state access patterns (no direct `state` getter on `Ref`).
   - Rework usages of `listenSelf`, `state`, `NotifierBase`, `BuildlessAutoDisposeNotifier`, and other removed classes so helpers compile against the official v3 abstractions.

3. **Migrate kimapp_supabase_helper providers**
   - Port `supabase_provider.dart` generated code and `upload_image_object_provider.dart` to the new notifier base classes (`AsyncNotifier`, `AsyncNotifierState`, `Notifier`) and adapt ref access (`AsyncValue` vs `state`).
   - Regenerate and/or rewrite the `.g.dart` files after generator updates to remove references to removed classes (`AutoDisposeNotifierProvider`, `ProviderRef`, etc.).

4. **Fix bootstraper package breakages**
   - Replace the deprecated `Override` generic usage with the new override API (`ProviderOverride`, `ProviderObserver`, etc.).
   - Update riverpod bootstrap tasks to the v3 `Ref` API (no implicit `state`, new splash task patterns).

5. **Update generators to analyzer v7 + Riverpod v3**
   - Migrate all generator code (`kimapp_generator`, `autoverpod_generator`) from `Element`/`ClassElement` to the new `Element2` model and resolve type mismatches.
   - Adjust generated provider templates to align with Riverpod v3 (no extending sealed `WidgetRef`, use provider extension methods instead of `select`, new provider classes and override APIs).
   - Ensure code generation emits valid provider types (`AsyncNotifierProvider`, `NotifierProvider`, `ProviderListenable` replacements) and removes direct `state`/`ref` assumptions that no longer hold.

6. **Regenerate example outputs and templates**
   - After generator changes, run `dart run build_runner build --delete-conflicting-outputs` in affected packages to refresh *.g.dart/*.widget.dart files.
   - Update example source (kimapp_generator example, autoverpod example) to call the new notifier APIs and fix any manual Riverpod usage (`ref` availability, value access).
   - Refresh mason bricks and documentation snippets so newly scaffolded projects use the v3-compatible patterns (`riverpod_annotation` 3, new ref helpers, no subclassing `WidgetRef`).

7. **Dependency hygiene**
   - Add missing direct dependencies revealed by the analyzer (e.g., declare `collection` in `numpad_input`).
   - Verify no packages still rely on deprecated Riverpod exports (e.g., `StateProvider` re-export) and update `autoverpod` exports accordingly.

8. **Validation & follow-up**
   - Once code compiles, rerun `dart analyze` and targeted tests via `melos`.
   - Exercise the generators (build_runner, example apps) to confirm the new output works with Riverpod 3.
   - Update CHANGELOG/README sections summarizing the v3 migration impacts and provide guidance for downstream users.
