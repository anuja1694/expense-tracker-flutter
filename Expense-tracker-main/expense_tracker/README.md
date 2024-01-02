# expense_tracker

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# Hosting server link
https://expense-tracker-5f15c.web.app/#/
# Manager credential

manager2@gmail.com
123456789

# user can register and use that details OR

test11@gmail.com
123456789

# Design figma
https://www.figma.com/file/RkLBWp7peRLPpF0yoH3FuH/Expense-Tracker?node-id=0%3A1&t=zY1LcmiAi9Gkz18P-1
# PWA link

https://expenses-track.surge.sh/#/

# Git hub link

https://github.coventry.ac.uk/suresha9/Expense-tracker.git

# Test suits

Test caseId      Test Scenario       Testcase title          pre-requisites          Test Steps                  Expected result             Actual resut


TC_001           user-Register            Register to account     Move to home page         1.Click on Signup text      1.Move to signup page        1.Move to signup page             
                                                                                        2.Enter details             2.save details to database   2.save details to database
                                                                                        3.click on sign up          3.Move to Home               3.Move to Home
                                                                                        move to Home screen
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
TC_002             user-Login              Login to account         move to home page    1.Enter the register details    1.check register data         1.check register data
                                                                                                                    2.if data exist move to home    2.if data exist move to home
                                                                                    2.click to sign in
                                                                                    3.check databse for data
                                                                                    4.if data exist move to home
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
TC_003          user-Forget password         Forgot password         move to signin      1.click on forgotpassword         1.move to forgot password       1.move to forgot password
                                                                                                                     2.sent link and rest password    2.sent link and rest password
                                                                                                                     3.after reset click on button    3.after reset click on button
                                                                                                                     4.move to sign in                  4.move to sign in
                                                                                        in signin
                                                                                    2.move to forgot password screen
                                                                                    3.enter email
                                                                                    4.check email in firebase
                                                                                    5.if exist sent reset link
                                                                                    6.after reset click back button
                                                                                    8.move to signin again with new passsword
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

