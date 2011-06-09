Feature: manage projects
  As a admin
  I want to manage of list of projects
  So that can change view of that list in frontend
  
  Background:
    Given a admin with email "admin@domain.com" and password "123456"
    And I sign in as "admin@domain.com/123456"
    And section with name "Лого"
    And section with name "Стиль"
    And section "Лого" has project with name "Арбуз"
    And section "Лого" has project with name "Черешня"
    And project "Черешня" has following descriptions:
      | image     | text_ru             | text_en            |
      | demo.jpg  | <h3>Черешня</h3>    | <h3>Cherry</h3>    |
      |           | Сочная, нежная!     | Juicy, sweet!      |
      | demo2.jpg | Девушкам полезная.  | Give to ladies it. |
    And section "Стиль" has project with name "Мопс"

  Scenario: listing projects
    When I follow "project_manager"
    Then I should see "Арбуз" within "#content"
    And I should see "Черешня" within "#content"
    And I should see "Мопс" within "#content"
    
  @wip
  Scenario: filtering projects
    Given I am on the admin projects page
    When I select "Стиль" from "section_id"
    And I submit "section_filter_form"
    Then I should see "Мопс" within "#content"
    But I should not see "Арбуз" within "#content"
    And I should not see "Черешня" within "#content"
    
  @wip
  Scenario: creating new project - applying
    Given I am on the admin projects page
    When I follow "new_project"
    Then I should be on the new admin project page
    
    When I fill in "project_name_ru" with "Такса"
    And I select "Стиль" from "project_section"
    And I check "project_enabled"
    And I press "project_apply"
    Then I should be on the edit admin project "Такса" page
    And I should see element ".notice"
    And the "project_name_ru" field should contain "Такса"
    
  @wip
  Scenario: creating new project - saving
    Given I am on the new admin project page
    When I fill in "project_name_ru" with "Такса"
    And I select "Стиль" from "project_section"
    And I press "project_submit"
    Then I should be on the admin projects page
    And I should see element ".notice"
    And I should see "Такса" within "#content"
    
    When I select "Стиль" from "section_id"
    And I submit "section_filter_form"
    Then I should see "Такса" within "#content"
    
  @wip
  Scenario: creating new project - failed
    Given I am on the new admin project page
    And I press "project_submit"
    Then I should be on the new admin project page
    And I should see element ".alert"
    
  @wip
  Scenario: editing project
    
  @wip
  Scenario: editing project - failed
  
  @wip
  Scenario: toggling ativity of projects
    
  @wip
  Scenario: changing show order of projects
    
  @wip
  Scenario: deleting project
    
  @wip
  Scenario: listing descriptions
    
  @wip
  Scenario: creating new description
    
  @wip
  Scenario: editing description
    
  @wip
  Scenario: toggling ativity of description
    
  @wip
  Scenario: changing show order of descriptions
    
  @wip
  Scenario: deleting description
  