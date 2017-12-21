# Dev's Hotel

**This project is a hotel registration app**

<img src="https://github.com/QuestCode/DevHotel/blob/master/DevHotel/App%20Images/Dev_Hotel.gif" width="250">

**App Images**

*Registration Page*

<img src="https://github.com/QuestCode/DevHotel/blob/master/DevHotel/App%20Images/Registrations_Page1.0.1.png" width="250">

*New Registration Page*

<img src="https://github.com/QuestCode/DevHotel/blob/master/DevHotel/App%20Images/New_Registration_page.png" width="250">

*Room Type Page*

<img src="https://github.com/QuestCode/DevHotel/blob/master/DevHotel/App%20Images/Room_Type_Page.png" width="250">



*Code below in use to present app with Interface Builder*
```Swift
let navController = UINavigationController(rootViewController: RegistrationViewController())
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
```
