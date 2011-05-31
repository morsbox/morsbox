Feature: introducing our sections
  As a potential client
  I want to know about activity of Morsbox
  So it helps to understand, will they be able to do my problem
  
  Background:
    Given static block with name "home" and text "Главная страница"
    And section with name "Лого"
    And section with name "Стиль"

  Scenario: enter homepage
    When I go to the home page
    Then I should see "Главная страница"
    And I should see "Лого" within ".menu"
    And I should see "Стиль" within ".menu"

  Scenario: changing locale
    Given static block with name "home" has english text "Home page"
    And section with name "Лого" has english name "Logo"
    And section with name "Стиль" has english name "Style"
    When I go to the home page
    Then I should see element "#switch_to_locale_en"
    
    When I follow "switch_to_locale_en"
    Then I should see "Home page"
    And I should see "Logo" within ".menu"
    And I should see "Style" within ".menu"