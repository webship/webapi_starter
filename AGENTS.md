# WebAPI Starter — agent guide

A `drupal-recipe` site template (`drupal/webapi_starter`) for the Webships
installer: the standard Drupal content model plus Web API. Part of the Webship
Workspace (`~/workspace/products`): DDEV only.

## Rules

- This is a `drupal-recipe`: keep configuration in the recipe, not in
  `config/install` or `config/optional`.
- A site template is standalone. It never requires or applies another site
  template; shared parts come from module recipes.
- Only packages from drupal.org. The Swagger UI asset library belongs to the
  project template, where `installer-paths` works.
- JSON:API stays read-only. Never set `read_only: false` here.
- The Drupal core administration theme is the default theme, for the back end
  and the front end.

## Build and test with DDEV

```bash
ddev composer require drupal/something
ddev drush cr
```

`ddev start` takes `-y`; `ddev stop` does not. Never write a `$databases` block
into `settings.php`: DDEV owns the database connection.

## Test

```shell
ddev drush si -y webships installer_site_template_form.add_ons=webapi_starter
ddev drush config:get jsonapi.settings read_only
ddev drush config:get system.theme
```
