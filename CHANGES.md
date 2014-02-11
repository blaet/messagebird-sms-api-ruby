0.1.4
-----------
- Introduces a new config option :enabled, which is set to false by default.
  This was added to prevent test and development enviroments from establishing actual connections
  to the MessageBird servers. Connections may be enabled by setting:
  ```ruby
  MessageBird.configure do
    enabled true
  end
  ```


0.1.3
-----------
- Sender_ID is now validated. Valid formats are:
  - 11 alphanumeric characters
  - telephone number string consisting of "+" + 11 numbers, e.g. "+31612345678"


0.1.2
-----------
- Ensure 1.8.7 compatibility


0.1.1
-----------
- Various small fixes


0.1.0
-----------
- First release
