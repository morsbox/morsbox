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

  Scenario: filtering projects
    Given I am on the admin projects page
    When I select "Стиль" from "section_id"
    And I submit "section_filter_form"
    Then I should see "Мопс" within "#content"
    But I should not see "Арбуз" within "#content"
    And I should not see "Черешня" within "#content"

  Scenario: creating new project - applying
    Given I am on the admin projects page
    When I follow "new_project"
    Then I should be on the new admin project page
    
    When I fill in "project_name_ru" with "Такса"
    And I select "Стиль" from "project_section_id"
    And I check "project_enabled"
    And I press "project_apply"
    Then I should be on the edit admin project "Такса" page
    And I should see element ".notice"
    And the "project_name_ru" field should contain "Такса"

  Scenario: creating new project - saving
    Given I am on the new admin project page
    When I fill in "project_name_ru" with "Такса"
    And I select "Стиль" from "project_section_id"
    And I press "project_submit"
    Then I should be on the admin projects page
    And I should see element ".notice"
    And I should see "Такса" within "#content"
    
    When I select "Стиль" from "section_id"
    And I submit "section_filter_form"
    Then I should see "Такса" within "#content"

  Scenario: creating new project - failed
    Given I am on the new admin project page
    And I press "project_submit"
    Then I should be on the new admin project page
    And I should see element ".alert"

  Scenario: editing project
    Given I am on the admin projects page
    When I follow "Черешня" within "#content"
    Then I should be on the edit admin project "Черешня" page
    
    When I fill in "project_name_en" with "Cherry"
    And I press "project_apply"
    Then I should be on the edit admin project "Черешня" page
    And I should see element ".notice"
    And the "project_name_en" field should contain "Cherry"
    
    When I fill in "project_name_ru" with "Вишня"
    And I press "project_submit"
    Then I should be on the admin projects page
    And I should see element ".notice"
    And I should see "Вишня" within "#content"

  Scenario: editing project - failed
    Given I am on the edit admin project "Черешня" page
    When I fill in "project_name_ru" with ""
    And I press "project_submit"
    Then I should be on the edit admin project "Черешня" page
    And I should see element ".alert"

  Scenario: toggling ativity of projects
    Given I am on the admin projects page
    When I follow "Вкл." within xpath //tr[.//text()="Черешня"]
    Then I should see "Выкл." within xpath //tr[.//text()="Черешня"]
    
    When I follow "Выкл." within xpath //tr[.//text()="Черешня"]
    Then I should see "Вкл." within xpath //tr[.//text()="Черешня"]

  Scenario: changing show order of projects
    Given I am on the admin projects page
    When I fill in "project_show_order" with "1" within xpath //tr[.//text()="Черешня"]
    And I submit edit form for project "Черешня"
    Then the "project_show_order" field should contain "1" within xpath //tr[.//text()="Черешня"]

  Scenario: deleting project
    Given I am on the admin projects page
    When I follow "Удалить" within xpath //tr[.//text()="Черешня"]
    Then I should not see "Черешня"

  Scenario: listing descriptions
    When I am on the edit admin project "Черешня" page
    Then I should see "Черешня" within "#content h3"
    And I should see "Сочная, нежная!" within "#content"
    And I should see "Девушкам полезная." within "#content"
    And I should see element "img[src*='demo.jpg']"
    And I should see element "img[src*='demo2.jpg']"

  Scenario: creating new description
    Given I am on the edit admin project "Черешня" page
    When I attach the file "features/demo/demo3.jpg" to "description_image" within "form#new_description"
    And I fill in "description_text_ru" with "Down Down" within "form#new_description"
    And I press "description_submit" within "form#new_description"
    Then I should be on the edit admin project "Черешня" page
    And I should see element ".notice"
    And I should see "Down Down" within "#content"
    And I should see element "img[src*='demo3.jpg']"

  Scenario: editing description
    Given I am on the edit admin project "Черешня" page
    When I attach the file "features/demo/demo3.jpg" to "description_image" within first edit description form
    And I fill in "description_text_ru" with "Down Down" within first edit description form
    And I press "description_submit" within first edit description form
    Then I should be on the edit admin project "Черешня" page
    And I should see element ".notice"
    And I should see "Down Down" within "#content"
    And I should see element "img[src*='demo3.jpg']"
    But I should not see element "#content h3"
    And I should not see element "img[src*='demo.jpg']"

  Scenario: deleting image
    Given I am on the edit admin project "Черешня" page
    When I check "description_image_file_name" within first edit description form
    And I press "description_submit" within first edit description form
    Then I should not see element "img[src*='demo.jpg']"

  Scenario: toggling ativity of description
    Given I am on the edit admin project "Черешня" page
    When I follow "Вкл." within xpath //tr[.//text()="Сочная, нежная!"]
    Then I should see "Выкл." within xpath //tr[.//text()="Сочная, нежная!"]
    
    When I follow "Выкл." within xpath //tr[.//text()="Сочная, нежная!"]
    Then I should see "Вкл." within xpath //tr[.//text()="Сочная, нежная!"]

  Scenario: deleting description
    Given I am on the edit admin project "Черешня" page
    When I follow "Удалить" within xpath //tr[.//text()="Сочная, нежная!"]
    Then I should not see "Сочная, нежная!"
    And I should see element ".notice"
  