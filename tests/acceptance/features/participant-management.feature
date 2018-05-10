Feature: participant-management

  Scenario: create a one-to-one conversation
    Given I am logged in
    And I have opened the Talk app
    When I create a one-to-one conversation with "admin"
    Then I see that the sidebar is open
    And I see that I can not add new participants
    And I see that the number of participants shown in the list is "2"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a moderator
    And I see that I can not moderate "admin"

  Scenario: open a one-to-one conversation as the other moderator
    Given I act as John
    And I am logged in
    And I have opened the Talk app
    And I create a one-to-one conversation with "admin"
    When I act as Jane
    And I am logged in as the admin
    And I have opened the Talk app
    And I open the "user0" conversation
    Then I see that the "user0" conversation is active
    And I see that the sidebar is open
    And I see that I can not add new participants
    And I see that the number of participants shown in the list is "2"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a moderator
    And I see that I can not moderate "admin"



  Scenario: create a group conversation
    Given I am logged in
    And I have opened the Talk app
    When I create a group conversation named "Group"
    Then I see that the sidebar is open
    And I see that I can add new participants
    And I see that the number of participants shown in the list is "1"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"

  Scenario: add user to a group conversation
    Given I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I see that the number of participants shown in the list is "1"
    When I add "admin" to the participants
    Then I see that the number of participants shown in the list is "2"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a normal participant
    And I see that I can moderate "admin"

  Scenario: open a group conversation as a user
    Given I act as John
    And I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I add "talk-user0" to the participants
    When I act as Jane
    And I am logged in as the admin
    And I have opened the Talk app
    And I open the "Group" conversation
    Then I see that the "Group" conversation is active
    And I see that the sidebar is open
    And I see that I can not add new participants
    And I see that the number of participants shown in the list is "3"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a normal participant
    And I see that I can not moderate "admin"
    And I see that "talk-user0" is shown in the list of participants as a normal participant
    And I see that I can not moderate "talk-user0"

  Scenario: add user to a group conversation when the user is already logged in
    Given I act as John
    And I am logged in
    And I have opened the Talk app
    And I act as Jane
    And I am logged in as the admin
    And I have opened the Talk app
    # Create a conversation to hide the "New conversation" drop down open by
    # default when there are no conversations; otherwise trying to click on the
    # conversation being added to would fail, as the drop down would be in front
    # of it.
    And I create a group conversation named "Dummy"
    And I act as John
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "talk-user0" to the participants
    When I add "admin" to the participants
    Then I act as Jane
    And I see that the "Group" conversation is shown in the list
    And I open the "Group" conversation
    And I see that the "Group" conversation is active
    And I see that the sidebar is open
    And I see that I can not add new participants
    And I see that the number of participants shown in the list is "3"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a normal participant
    And I see that I can not moderate "admin"
    And I see that "talk-user0" is shown in the list of participants as a normal participant
    And I see that I can not moderate "talk-user0"

  Scenario: add user to a group conversation when another user has the conversation open
    Given I act as John
    And I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I act as Jane
    And I am logged in as the admin
    And I have opened the Talk app
    And I open the "Group" conversation
    And I see that the "Group" conversation is active
    And I see that the sidebar is open
    And I see that the number of participants shown in the list is "2"
    When I act as John
    And I add "talk-user0" to the participants
    Then I act as Jane
    And I see that the number of participants shown in the list is "3"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a normal participant
    And I see that I can not moderate "admin"
    And I see that "talk-user0" is shown in the list of participants as a normal participant
    And I see that I can not moderate "talk-user0"

  Scenario: add user to a group conversation when another moderator has the conversation open
    Given I act as John
    And I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I promote "admin" to moderator
    And I act as Jane
    And I am logged in as the admin
    And I have opened the Talk app
    And I open the "Group" conversation
    And I see that the "Group" conversation is active
    And I see that the sidebar is open
    And I see that the number of participants shown in the list is "2"
    When I act as John
    And I add "talk-user0" to the participants
    Then I act as Jane
    And I see that the number of participants shown in the list is "3"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a moderator
    And I see that I can not moderate "admin"
    And I see that "talk-user0" is shown in the list of participants as a normal participant
    And I see that I can moderate "talk-user0"



  Scenario: promote user to moderator in a group conversation by the owner
    Given I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I see that "admin" is shown in the list of participants as a normal participant
    When I promote "admin" to moderator
    Then I see that the number of participants shown in the list is "2"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a moderator
    And I see that I can moderate "admin"

  Scenario: promote user to moderator in a group conversation by a moderator
    Given I act as John
    And I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I promote "admin" to moderator
    And I add "talk-user0" to the participants
    And I act as Jane
    And I am logged in as the admin
    And I have opened the Talk app
    And I open the "Group" conversation
    And I see that the "Group" conversation is active
    And I see that the sidebar is open
    And I see that "talk-user0" is shown in the list of participants as a normal participant
    When I promote "talk-user0" to moderator
    Then I see that the number of participants shown in the list is "3"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a moderator
    And I see that I can not moderate "admin"
    And I see that "talk-user0" is shown in the list of participants as a moderator
    And I see that I can moderate "talk-user0"

  Scenario: promote user to moderator in a group conversation when the user has the conversation open
    Given I act as John
    And I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I add "talk-user0" to the participants
    And I act as Jane
    And I am logged in as the admin
    And I have opened the Talk app
    And I open the "Group" conversation
    And I see that the "Group" conversation is active
    And I see that the sidebar is open
    And I see that I can not add new participants
    When I act as John
    And I promote "admin" to moderator
    Then I act as Jane
    And I see that I can add new participants
    And I see that the number of participants shown in the list is "3"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a moderator
    And I see that I can not moderate "admin"
    And I see that "talk-user0" is shown in the list of participants as a normal participant
    And I see that I can moderate "talk-user0"

  Scenario: promote user to moderator in a group conversation when another user has the conversation open
    Given I act as John
    And I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I add "talk-user0" to the participants
    And I act as Jane
    And I am logged in as the admin
    And I have opened the Talk app
    And I open the "Group" conversation
    And I see that the "Group" conversation is active
    And I see that the sidebar is open
    And I see that "talk-user0" is shown in the list of participants as a normal participant
    When I act as John
    And I promote "talk-user0" to moderator
    Then I act as Jane
    And I see that the number of participants shown in the list is "3"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a normal participant
    And I see that I can not moderate "admin"
    And I see that "talk-user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "talk-user0"

  Scenario: promote user to moderator in a group conversation when another moderator has the conversation open
    Given I act as John
    And I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I promote "admin" to moderator
    And I add "talk-user0" to the participants
    And I act as Jane
    And I am logged in as the admin
    And I have opened the Talk app
    And I open the "Group" conversation
    And I see that the "Group" conversation is active
    And I see that the sidebar is open
    And I see that "talk-user0" is shown in the list of participants as a normal participant
    When I act as John
    And I promote "talk-user0" to moderator
    Then I act as Jane
    And I see that the number of participants shown in the list is "3"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a moderator
    And I see that I can not moderate "admin"
    And I see that "talk-user0" is shown in the list of participants as a moderator
    And I see that I can moderate "talk-user0"



  Scenario: demote user from moderator in a group conversation by the owner
    Given I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I promote "admin" to moderator
    And I see that "admin" is shown in the list of participants as a moderator
    When I demote "admin" from moderator
    Then I see that the number of participants shown in the list is "2"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a normal participant
    And I see that I can moderate "admin"

  Scenario: demote user from moderator in a group conversation by a moderator
    Given I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I promote "admin" to moderator
    And I add "talk-user0" to the participants
    And I promote "talk-user0" to moderator
    And I act as Jane
    And I am logged in as the admin
    And I have opened the Talk app
    And I open the "Group" conversation
    And I see that the "Group" conversation is active
    And I see that the sidebar is open
    And I see that "talk-user0" is shown in the list of participants as a moderator
    When I demote "talk-user0" from moderator
    Then I see that the number of participants shown in the list is "3"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a moderator
    And I see that I can not moderate "admin"
    And I see that "talk-user0" is shown in the list of participants as a normal participant
    And I see that I can moderate "talk-user0"

  Scenario: demote user from moderator in a group conversation when the user has the conversation open
    Given I act as John
    And I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I promote "admin" to moderator
    And I add "talk-user0" to the participants
    And I act as Jane
    And I am logged in as the admin
    And I have opened the Talk app
    And I open the "Group" conversation
    And I see that the "Group" conversation is active
    And I see that the sidebar is open
    And I see that I can add new participants
    And I see that I can moderate "talk-user0"
    When I act as John
    And I demote "admin" from moderator
    Then I act as Jane
    And I see that I can not add new participants
    And I see that the number of participants shown in the list is "3"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a normal participant
    And I see that I can not moderate "admin"
    And I see that "talk-user0" is shown in the list of participants as a normal participant
    And I see that I can not moderate "talk-user0"

  Scenario: demote user from moderator in a group conversation when another user has the conversation open
    Given I act as John
    And I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I add "talk-user0" to the participants
    And I promote "talk-user0" to moderator
    And I act as Jane
    And I am logged in as the admin
    And I have opened the Talk app
    And I open the "Group" conversation
    And I see that the "Group" conversation is active
    And I see that the sidebar is open
    And I see that "talk-user0" is shown in the list of participants as a moderator
    When I act as John
    And I demote "talk-user0" from moderator
    Then I act as Jane
    And I see that the number of participants shown in the list is "3"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a normal participant
    And I see that I can not moderate "admin"
    And I see that "talk-user0" is shown in the list of participants as a normal participant
    And I see that I can not moderate "talk-user0"

  Scenario: demote user from moderator in a group conversation when another moderator has the conversation open
    Given I act as John
    And I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I promote "admin" to moderator
    And I add "talk-user0" to the participants
    And I promote "talk-user0" to moderator
    And I act as Jane
    And I am logged in as the admin
    And I have opened the Talk app
    And I open the "Group" conversation
    And I see that the "Group" conversation is active
    And I see that the sidebar is open
    And I see that "talk-user0" is shown in the list of participants as a moderator
    When I act as John
    And I demote "talk-user0" from moderator
    Then I act as Jane
    And I see that the number of participants shown in the list is "3"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a moderator
    And I see that I can not moderate "admin"
    And I see that "talk-user0" is shown in the list of participants as a normal participant
    And I see that I can moderate "talk-user0"



  Scenario: remove user from a group conversation by the owner
    Given I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I see that "admin" is shown in the list of participants as a normal participant
    When I remove "admin" from the participants
    Then I see that the number of participants shown in the list is "1"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"

  Scenario: remove user from a group conversation by a moderator
    Given I act as John
    And I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I promote "admin" to moderator
    And I add "talk-user0" to the participants
    And I act as Jane
    And I am logged in as the admin
    And I have opened the Talk app
    And I open the "Group" conversation
    And I see that the "Group" conversation is active
    And I see that the sidebar is open
    And I see that "talk-user0" is shown in the list of participants as a normal participant
    When I remove "talk-user0" from the participants
    Then I see that the number of participants shown in the list is "2"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a moderator
    And I see that I can not moderate "admin"

  Scenario: remove moderator from a group conversation by the owner
    Given I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I promote "admin" to moderator
    And I see that "admin" is shown in the list of participants as a moderator
    When I remove "admin" from the participants
    Then I see that the number of participants shown in the list is "1"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"

  Scenario: remove moderator from a group conversation by a moderator
    Given I act as John
    And I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I promote "admin" to moderator
    And I add "talk-user0" to the participants
    And I promote "talk-user0" to moderator
    And I act as Jane
    And I am logged in as the admin
    And I have opened the Talk app
    And I open the "Group" conversation
    And I see that the "Group" conversation is active
    And I see that the sidebar is open
    And I see that "talk-user0" is shown in the list of participants as a moderator
    When I remove "talk-user0" from the participants
    Then I see that the number of participants shown in the list is "2"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a moderator
    And I see that I can not moderate "admin"

  Scenario: remove user from a group conversation when the user has the conversation open
    Given I act as John
    And I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I act as Jane
    And I am logged in as the admin
    And I have opened the Talk app
    And I open the "Group" conversation
    And I see that the "Group" conversation is active
    When I act as John
    And I remove "admin" from the participants
    Then I act as Jane
    And I see that the "Group" conversation is not shown in the list
    # This fails when run without any timeout multiplier, as currently the empty
    # content message is shown after receiving several 404 errors instead of on
    # the first one.
    And I see that the "This conversation has ended" empty content message is shown in the main view
    And I see that the sidebar is closed

  Scenario: remove user from a group conversation when another user has the conversation open
    Given I act as John
    And I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I add "talk-user0" to the participants
    And I act as Jane
    And I am logged in as the admin
    And I have opened the Talk app
    And I open the "Group" conversation
    And I see that the "Group" conversation is active
    And I see that the sidebar is open
    And I see that "talk-user0" is shown in the list of participants as a normal participant
    When I act as John
    And I remove "talk-user0" from the participants
    Then I act as Jane
    And I see that the number of participants shown in the list is "2"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a normal participant
    And I see that I can not moderate "admin"

  Scenario: remove user from a group conversation when another moderator has the conversation open
    Given I act as John
    And I am logged in
    And I have opened the Talk app
    And I create a group conversation named "Group"
    And I see that the sidebar is open
    And I add "admin" to the participants
    And I promote "admin" to moderator
    And I add "talk-user0" to the participants
    And I act as Jane
    And I am logged in as the admin
    And I have opened the Talk app
    And I open the "Group" conversation
    And I see that the "Group" conversation is active
    And I see that the sidebar is open
    And I see that "talk-user0" is shown in the list of participants as a normal participant
    When I act as John
    And I remove "talk-user0" from the participants
    Then I act as Jane
    And I see that the number of participants shown in the list is "2"
    And I see that "user0" is shown in the list of participants as a moderator
    And I see that I can not moderate "user0"
    And I see that "admin" is shown in the list of participants as a moderator
    And I see that I can not moderate "admin"
