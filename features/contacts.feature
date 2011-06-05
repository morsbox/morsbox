@wip
Feature: contacts
  As a potential client or partner
  I want to ask something
  So they can help me
  
  Background:
    Given static block with name "contacts" and text "Наши контакты"
  
  Scenario: view contact info
    Given I am on the home page
    When I follow "contacts"
    Then I should be on the contacts page
    And I should see "Наши контакты"
    
  Scenario: changing locale
    Given I am on the contacts page
    When I follow "switch_to_locale_en"
    Then I should see "Our contacts info"
  
  Scenario: send message
    Given I am on the contacts page
    When I fill in "contact_name" with "Mikhail"
    And I fill in "contact_email" with "client@admin.com"
    And I fill in "contact_phone" with "1234567"
    And I fill in "contact_message" with "Be my designer!"
    And I press "contact_submit"
    Then I should see element ".notice"
    And admin should receive email that contains:
      | Mikhail           |
      | client@admin.com  |
      | 1234567           |
      | Be my designer!   |
    
  Scenario: send empty message
    Given I am on the contacts page
    When I press "admin_submit"
    Then I should see element ".alert"