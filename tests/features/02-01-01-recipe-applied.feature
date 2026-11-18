Feature: The WebAPI Starter recipe applies
  As a site administrator
  I want the WebAPI Starter recipe to set up the API and its content model
  So that the site serves a documented API from the start

  Scenario: Web API and its modules are enabled
    Given I am a logged in user with the "Webmaster" user
     Then the "webapi" module should be installed
      And the "jsonapi" module should be installed
      And the "simple_oauth" module should be installed
      And the "openapi_ui_swagger" module should be installed

  Scenario: The Webpage content type exists
    Given I am a logged in user with the "Webmaster" user
     Then the "Webpage" content type should exist

  Scenario: The page about the API is published
    Given I am an anonymous user
     When I navigate to "/api-and-docs"
     Then the response status code should be 200
      And I should see "The API and its documentation"

  Scenario: Registration is closed
    Given I am an anonymous user
     When I navigate to "/user/register"
     Then the response status code should be 403
