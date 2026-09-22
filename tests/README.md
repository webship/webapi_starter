# WebAPI Starter tests

[webship-js](https://www.npmjs.com/package/webship-js) (Playwright + Cucumber-js) suite, run against Drupal 11.4 with the recipe applied on the standard profile.

```bash
ddev composer require vardot/swagger-ui
ddev drush site:install standard --account-name=webmaster --account-pass=dD.123123ddd -y
ddev drush recipe ../recipes/webapi_starter
yarn install
./node_modules/.bin/playwright install --with-deps chromium
LAUNCH_URL="http://<project>.ddev.site" yarn test
```

CI: the `webship-js-test` job in `.gitlab-ci.yml`.
