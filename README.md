# WebAPI Starter

The basic Drupal API site template: a documented, read-only JSON:API on a
small editorial content model.


## Table of contents

- Features
- Requirements
- Installation
- Configuration
- Usage


## Features

- JSON:API served from `/api`, and read-only.
- OAuth 2.0 with Simple OAuth and consumers, and HTTP Basic authentication.
- OpenAPI documents for JSON:API and REST, rendered with Swagger UI.
- The Webpage content type with Display Builder and the editorial
  workflow, the Tags vocabulary, and a contact webform at `/form/contact`.
- The core standard recipe: text formats, the administrator and content
  editor roles.
- Webmaster, Editorial and Management dashboards.
- A front page, `/api-and-docs`, that explains the API.
- The Drupal core administration theme for the back end and the front end.
- Registration is closed: an administrator creates the accounts.


## Requirements

Drupal core `^11.4`. The recipe applies
[Web API](https://www.drupal.org/project/webapi),
[Webpage](https://www.drupal.org/project/webpage) and
[Web Dashboard](https://www.drupal.org/project/webdash).

Display Builder is a beta release, so the project needs
`"minimum-stability": "beta"` or lower.

Swagger UI needs its library at `web/libraries/swagger-ui`. Web API
requires `swagger-api/swagger-ui`, a plain Composer `library` that lands in
`vendor/`. Require [vardot/swagger-ui](https://github.com/Vardot/swagger-ui)
in the project: it replaces that package as a `drupal-library`, so the
usual `type:drupal-library` installer path puts it in place.


## Installation

With the [Webships Project](https://www.drupal.org/project/webships_project)
template:

```
ddev composer create-project drupal/webships_project:^1.0
ddev drush site:install ../recipes/webapi_starter -y --account-name=webmaster
```

Or on an existing site:

```
ddev composer require drupal/webapi_starter vardot/swagger-ui
ddev drush recipe ../recipes/webapi_starter
```


## Configuration

- JSON:API is read-only, which is what the Drupal Security Team
  recommends. Turn write operations on at `/admin/config/services/jsonapi`
  only when the site needs them, then rebuild the cache.
- OAuth 2.0 consumers: `/admin/config/services/consumer`.
- CORS lives in `sites/default/services.yml` under `cors.config`. No module
  or recipe can ship it, so set it per site.


## Usage

`/api` lists every resource the site serves. Content is at
`/api/node/webpage` and tags at `/api/taxonomy_term/tags`.

Swagger UI is at `/admin/config/services/openapi/swagger/jsonapi` and needs
the "access openapi api docs" permission. The OpenAPI document itself is at
`/openapi/jsonapi`.
