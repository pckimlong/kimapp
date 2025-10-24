# Using Kimapp Packages in External Projects

This guide explains how to use kimapp packages in external Flutter applications without publishing to pub.dev.

## Recommended Setup

### 1. For Development (Local Development)
Use `dependency_overrides` in your consuming app's `pubspec.yaml`:

```yaml
dependency_overrides:
  kimapp:
    path: ../path/to/your/kimapp_packages/packages/kimapp
  kimapp_supabase_helper:
    path: ../path/to/your/kimapp_packages/packages/kimapp_supabase_helper
  kimapp_generator:
    path: ../path/to/your/kimapp_packages/packages/kimapp_generator
  kimapp_utils:
    path: ../path/to/your/kimapp_packages/packages/kimapp_utils
```

### 2. For Production/Stable Releases
Use Git dependencies with specific tags:

```yaml
dependencies:
  kimapp:
    git:
      url: https://github.com/yourusername/kimapp_packages.git
      path: packages/kimapp
      ref: kimapp-v0.0.3
  kimapp_supabase_helper:
    git:
      url: https://github.com/yourusername/kimapp_packages.git
      path: packages/kimapp_supabase_helper
      ref: kimapp_supabase_helper-v0.0.3
  kimapp_generator:
    git:
      url: https://github.com/yourusername/kimapp_packages.git
      path: packages/kimapp_generator
      ref: kimapp_generator-v0.0.2
  kimapp_utils:
    git:
      url: https://github.com/yourusername/kimapp_packages.git
      path: packages/kimapp_utils
      ref: kimapp_utils-v0.0.3
```

## Available Package Versions

### Current Stable Tags:
- `kimapp-v0.0.3`
- `kimapp_supabase_helper-v0.0.3`
- `kimapp_generator-v0.0.2`
- `kimapp_utils-v0.0.3`

### Autoverpod Packages:
- `autoverpod-v0.0.4+1`
- `autoverpod_generator-v0.0.4+1`

## Version Management Strategy

### Tagging Convention
Tags follow the pattern: `{package_name}-v{version}`

### Creating New Releases
When you're ready to release a new version:

```bash
# 1. Update version in pubspec.yaml
# 2. Commit the changes
git add packages/{package_name}/pubspec.yaml
git commit -m "Bump {package_name} to v{new_version}"

# 3. Create and push tag
git tag {package_name}-v{new_version}
git push origin {package_name}-v{new_version}
```

### Branch Strategy
- `main`: Development branch
- `release/*`: Release preparation branches
- Tags: Point to specific commits for stable releases

## Example App Configuration

Create a sample `pubspec.yaml` for an external app:

```yaml
name: my_flutter_app
description: A Flutter app using kimapp packages

environment:
  sdk: '>=3.6.0 <4.0.0'
  flutter: ">=3.27.1"

dependencies:
  flutter:
    sdk: flutter
  
  # Kimapp packages - use Git dependencies for production
  kimapp:
    git:
      url: https://github.com/yourusername/kimapp_packages.git
      path: packages/kimapp
      ref: kimapp-v0.0.3
  
  kimapp_supabase_helper:
    git:
      url: https://github.com/yourusername/kimapp_packages.git
      path: packages/kimapp_supabase_helper
      ref: kimapp_supabase_helper-v0.0.3
  
  # Other dependencies
  supabase_flutter: ^2.0.0
  riverpod: ^3.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0

# For local development, uncomment and adjust paths:
# dependency_overrides:
#   kimapp:
#     path: ../kimapp_packages/packages/kimapp
#   kimapp_supabase_helper:
#     path: ../kimapp_packages/packages/kimapp_supabase_helper
```

## Workflow Recommendations

### For Package Development
1. Make changes in your kimapp_packages repo
2. Test with local path dependencies in a sample app
3. When ready, update versions and create tags
4. Update consuming apps to use new tags

### For App Development
1. Use Git dependencies with specific tags for production
2. Use `dependency_overrides` with local paths for development/debugging
3. Update tags when new package versions are available

## Troubleshooting

### Common Issues

**Issue**: Version conflicts between packages
**Solution**: Ensure all packages reference compatible versions, use `dependency_overrides` if needed

**Issue**: Git dependency not updating
**Solution**: Run `flutter pub cache repair` or delete `.pub-cache` and retry

**Issue**: Path dependency not found
**Solution**: Verify the relative path is correct from your app's root directory

### Getting Help
- Check the package-specific README files in each package directory
- Review the changelogs for breaking changes
- Ensure your Flutter/Dart versions meet the minimum requirements