Feature: Showing Links
In order to save myself from having to rember a lot of crap
As a user 
I want to be able to see previously saved links


Scenario: When there are no links
Given I am on the homepage
Then I should see "Bookmark is fun"
And then there should be no links

Scenario: when there are links
Given I am on the homepage
Then I should see "Add Bookmarks"
And then there should be some links