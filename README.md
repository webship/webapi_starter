# WebAPI Starter

The basic Drupal API site template.

A site template for the [Webships](https://www.drupal.org/project/webships)
installer. It keeps the standard Drupal content model and adds a documented API:

- JSON:API served from `/api`, and read-only.
- OAuth 2.0 with Simple OAuth and consumers, and HTTP Basic authentication.
- OpenAPI documents for JSON:API and REST, rendered with Swagger UI at
  `/api-docs`.
- The Drupal core administration theme for the back end and the front end.
- Registration is closed: an administrator creates the accounts.

Everything comes from drupal.org.

## Install

With the [Webships Project](https://www.drupal.org/project/webships_project)
template:

```shell
ddev composer create-project drupal/webships_project:^1.0
ddev drush site:install ../recipes/webapi_starter -y --account-name=webmaster
```

Or apply the recipe on an existing site:

```shell
ddev composer require drupal/webapi_starter
ddev drush recipe recipes/webapi_starter
```

## Write operations

JSON:API is read-only, which is what the Drupal Security Team recommends. Turn
write operations on at `/admin/config/services/jsonapi` only when the site needs
them, and rebuild the cache afterwards.

## Cross-origin requests

CORS lives in `sites/default/services.yml` under `cors.config`. No module or
recipe can ship it, so set it per site.
