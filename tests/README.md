# WebAPI Starter tests

The functional tests of the WebAPI Starter site template: Gherkin features run
by [webship-js](https://www.npmjs.com/package/webship-js) (Playwright and
Cucumber) with the Drupal steps of
[@webship-js/drupal-core-steps](https://www.npmjs.com/package/@webship-js/drupal-core-steps)
(the login by account handle, module and content type checks). They check what
the recipe sets up: the API and its documentation, the page about them, the
closed registration and the accessibility of the pages. `cucumber.js` in the
project root holds the configuration.

| Folder | What it holds |
| --- | --- |
| `features/` | the features (5 files, 15 scenarios) |
| `step-definitions/` | this project's own steps (none yet) |
| `selectors/` | named selectors for Claro |
| `reports/`, `screenshots/`, `videos/` | what a run writes (not committed) |

## From nothing to a green run

### 1. A site in DDEV with this site template

Build a site from the
[Webships project template](https://www.drupal.org/project/webships_project),
which places this site template in `recipes/webapi_starter` and brings the
Swagger UI library:

```bash
mkdir webapi-site && cd webapi-site
ddev config --project-type=drupal --docroot=web
ddev start
ddev composer create-project drupal/webships_project:~12.0
ddev restart
```

### 2. The site, with the test accounts

The suite logs in as the accounts that `cucumber.js` lists in
`worldParameters.users`, and never creates or deletes an account: the site
build does. Choose three passwords, keep them in your environment, install the
site from the recipe with the Webmaster account, and add the other two
accounts:

```bash
export DRUPAL_ADMIN_PASS='…' DRUPAL_EDITOR_PASS='…' DRUPAL_AUTHENTICATED_PASS='…'
ddev drush site:install ../recipes/webapi_starter --account-name=webmaster --account-mail=webmaster@example.test --account-pass="$DRUPAL_ADMIN_PASS" -y
ddev drush user:create content_editor_user --mail=content_editor_user@example.test --password="$DRUPAL_EDITOR_PASS"
ddev drush user:role:add content_editor content_editor_user
ddev drush user:create authenticated_user --mail=authenticated_user@example.test --password="$DRUPAL_AUTHENTICATED_PASS"
```

CI builds a Standard site and applies the recipe on top, with the same
accounts and passwords made for the job: see the `webship-js-test` job in
`.gitlab-ci.yml`.

### 3. Run the suite

From this project's folder, with Node.js 24 and Yarn 4 (through Corepack):

```bash
corepack enable
yarn install
npx playwright install chromium
export LAUNCH_URL=https://webapi-site.ddev.site
export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.pem"
yarn test --tags "not @wip"
```

`NODE_EXTRA_CA_CERTS` lets Node.js trust DDEV's HTTPS certificate for the
API steps, which send their requests outside the browser.
`yarn test:dry` checks that every step resolves to one definition, without
a browser.

### 4. What green looks like

```
15 scenarios (15 passed)
83 steps (83 passed)
```

The HTML report is written to `tests/reports/cucumber_report.html`. A failed
step leaves a screenshot in `tests/screenshots/` and a video in
`tests/videos/`. The suite changes nothing on the site (the write request it
sends is refused), so a second run is green too.

## Test users

The accounts as `cucumber.js` lists them in `worldParameters.users`. Each
value comes from the environment variable named below; `CHANGE_ME` stands for
the password you chose in step 2.

```json
{
  "Webmaster": { "username": "webmaster", "password": "CHANGE_ME", "email": "webmaster@example.test", "isAdmin": true },
  "Content editor": { "username": "content_editor_user", "password": "CHANGE_ME", "email": "content_editor_user@example.test", "roles": ["content_editor"] },
  "Authenticated user": { "username": "authenticated_user", "password": "CHANGE_ME", "email": "authenticated_user@example.test", "roles": [] }
}
```

| Handle | Variables | The account |
| --- | --- | --- |
| Webmaster | `DRUPAL_ADMIN_USER`, `DRUPAL_ADMIN_PASS`, `DRUPAL_ADMIN_MAIL` | the account the installer created |
| Content editor | `DRUPAL_EDITOR_USER`, `DRUPAL_EDITOR_PASS`, `DRUPAL_EDITOR_MAIL` | a user with the Content editor role of the recipe |
| Authenticated user | `DRUPAL_AUTHENTICATED_USER`, `DRUPAL_AUTHENTICATED_PASS`, `DRUPAL_AUTHENTICATED_MAIL` | a user with no role |
