Feature: manage static blocks
  As a admin
  I want to manage of static blocks
  So that can change view of some static text parts in frontend
  
  Background:
    Given a admin with email "admin@domain.com" and password "123456"
    And I sign in as "admin@domain.com/123456"
    And static block with name "home" and text "Главная страница"
    And static block with name "contacts" and text "Наши контакты"

  Scenario: listing static blocks
    When I follow "static_block_manager"
    Then I should see "home"
    And I should see "contacts"

  Scenario: editing static block
    Given I am on the admin static blocks page
    When I follow "contacts" within "#content"
    Then I should be on the edit admin static block "contacts" page
    And the "static_block_name" field should contain "contacts"
    And the "static_block_text_ru" field should contain "Наши контакты"
    
    When I fill in "static_block_text_en" with "Our contact info"
    And I press "static_block_apply"
    Then I should be on the edit admin static block "contacts" page
    And I should see element ".notice"
    And the "static_block_text_en" field should contain "Our contact info"
    
    When I fill in "static_block_name" with "contacts_old"
    And I press "static_block_submit"
    Then I should be on the admin static blocks page
    And I should see element ".notice"
    And I should see "contacts_old"

  Scenario: editing static block - failed
    Given I am on the edit admin static block "contacts" page
    When I fill in "static_block_name" with "home"
    And I press "static_block_submit"
    Then I should be on the edit admin static block "contacts" page
    And I should see element ".alert"

  Scenario: deleting static block
    Given I am on the admin static blocks page
    When I follow "Удалить" within xpath //tr[contains(.//text(),"home")]
    Then I should not see "home"
    And I should see element ".notice"
