@wip
Feature: introducing our projects
  As a potential client
  I want to see their works
  So it helps to know what these guys are capable
  
  Background:
    Given section with name "Лого"
    And section with name "Стиль"
    And section "Лого" has project with name "Арбуз"
    And section "Лого" has project with name "Черешня"
    And project "Черешня" has following descriptions:
      | image             | text_ru                   | text_en            |
      | images/demo.jpg   | <h3>Черешня</h3>          | <h3>Cherry</h3>           |
      |                   | <p>Сочная, нежная!</p>    | <p>Juicy, sweet!</p>      |
      | images/demo2.jpg  | <p>Девушкам полезная.</p> | <p>Give to ladies it.</p> |
  
  Scenario: visit category
    Given I am on the home page
    When I follow "Лого"
    Then I should see "Лого" within ".menu .selected"
    And I should see "Стиль" within ".menu"
    And I should see "Арбуз" within ".projects_menu"
    And I should see "Черешня" within ".projects_menu"
  
  Scenario: visit project
    Given I am on the page of section "Лого"
    When I follow "Черешня"
    Then I should see "Лого" within ".menu .selected"
    And I should see "Стиль" within ".menu"
    And I should see "Арбуз" within ".projects_menu"
    And I should see "Черешня" within ".projects_menu .selected"
    And I should see "Черешня" within "h3"
    And I should see "Сочная, нежная!" within "p"
    And I should see "Девушкам полезная." within "p"
    And I should see element "img[src~='demo.jpg']"
    And I should see element "img[src~='demo2.jpg']"
  
  Scenario: changing locale
    Given project with name "Арбуз" has english name "Watermelon"
    And project with name "Черешня" has english name "Cherry"
    And I am on the page of project "Черешня"
    When I follow "switch_to_locale_en"
    Then I should be on the page of project "Черешня"
    And I should see "Watermelon" within ".projects_menu"
    And I should see "Cherry" within ".projects_menu .selected"
    And I should see "Cherry" within "h3"
    And I should see "Juicy, sweet!" within "p"
    And I should see "Give to ladies it." within "p"