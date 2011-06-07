Feature: manage sections
  As a admin
  I want to manage of list of sections
  So that can change view of that list in frontend
  
  Background:
    Given a admin with email "admin@domain.com" and password "123456"
    And I sign in as "admin@domain.com/123456"
    And section with name "Лого"
    And section with name "Стиль"
    
  Scenario: listing sections
    When I follow "section_manager"
    Then I should see "Лого" within "#content"
    And I should see "Стиль" within "#content"
  
  @wip
  Scenario: creating new section - applying
    Given I am on the admin sections page
    When I follow "new_section"
    Then I should be on the new admin section page
    
    When I fill in "section_name_ru" with "Веб"
    And I check "section_enabled"
    And I press "section_apply"
    Then I should be on the edit admin section "Веб" page
    And I should see element ".notice"
    And the "section_name_ru" field should contain "Веб"
    And I should see "Веб" within ".menu"
  
  Scenario: creating new section - saving
    Given I am on the new admin section page
    When I fill in "section_name_ru" with "Веб"
    And I press "section_submit"
    Then I should be on the admin sections page
    And I should see element ".notice"
    And I should see "Веб" within "#content"
   
  Scenario: creating new section - failed
    Given I am on the new admin section page
    And I press "section_submit"
    Then I should be on the new admin section page
    And I should see element ".alert"
  
  @wip
  Scenario: editing section
    Given I am on the admin sections page
    When I follow "Стиль" within "#content"
    Then I should be on the edit admin section "Стиль" page
    
    When I fill in "section_name_en" with "Style"
    And I press "section_apply"
    Then I should be on the edit admin section "Стиль" page
    And I should see element ".notice"
    And the "section_name_en" field should contain "Style"
    
    When I fill in "section_name_ru" with "Фирменный стиль"
    And I press "section_submit"
    Then I should be on the admin sections page
    And I should see element ".notice"
    And I should see "Фирменный стиль" within "#content"
    And I should see "Фирменный стиль" within ".menu"
  
  @wip
  Scenario: editing section - failed
    Given I am on the edit admin section "Стиль" page
    When I fill in "section_name_ru" with ""
    And I press "section_submit"
    Then I should be on the edit admin section "Стиль" page
    And I should see element ".alert"
  
  @wip
  Scenario: toggling ativity of sections
    Given I am on the admin sections page
    When I follow "Вкл." within xpath //tr[text()="Лого"]
    Then I should see "Выкл." within xpath //tr[text()="Лого"]
    And I should not see "Лого" within ".menu"
    
    When I follow "Выкл." within xpath //tr[text()="Лого"]
    Then I should see "Вкл." within xpath //tr[text()="Лого"]
    And I should see "Лого" within ".menu"
  
  @wip
  Scenario: changing show order of sections
  
  @wip
  Scenario: deleting sections
    Given I am on the admin sections page
    When I follow "Удалить" within "#content"
    Then I should not see "Лого"