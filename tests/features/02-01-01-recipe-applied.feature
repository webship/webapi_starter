Feature: The WebAPI Starter recipe applies
  As a site administrator
  I want the WebAPI Starter recipe to set up the API and its content model
  So that the site serves a documented API from the start

  Scenario: Web API and its modules are enabled
    Given I am a logged in user with the "Webmaster" user
     When I navigate to "/admin/modules"
     Then the element "#edit-modules-webapi-enable" with the attribute "checked" and the value "checked" should exist
      And the element "#edit-modules-jsonapi-enable" with the attribute "checked" and the value "checked" should exist
      And the element "#edit-modules-simple-oauth-enable" with the attribute "checked" and the value "checked" should exist
      And the element "#edit-modules-openapi-ui-swagger-enable" with the attribute "checked" and the value "checked" should exist

  Scenario: The Webpage content type exists
    Given I am a logged in user with the "Webmaster" user
     When I navigate to "/admin/structure/types"
     Then I should see "Webpage"

  Scenario: The page about the API is published
    Given I am an anonymous user
     When I navigate to "/api-and-docs"
     Then the response status code should be 200
      And I should see "The API and its documentation"

  Scenario: Registration is closed
    Given I am an anonymous user
     When I navigate to "/user/register"
     Then the response status code should be 403
