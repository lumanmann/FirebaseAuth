# README

This repository is a simple record of [**Learn Swift HK** meeing on 2019/03/02](https://www.meetup.com/Learn-Swift-HK/events/256881188/)

We have discuss the difference between Private and Fileprivate and finish a simple Sign Up Page with programmatic autolayout and Firebase.

## Outcome
![](https://i.imgur.com/b1AT5lA.png)

## Notes




### **Private vs Fileprivate**
---

Just few key points:

- Private functions and variables are only accessible in its own class, including extension in other files.
- Fileprivate functions and variables are accessible in all the classes in that file, but cannot be accessed in other file, even in the extension of class where functions and variables are declared.
- fileprivate(set) 、 private(set) -> only setter is set to this access level
for example: `   private(set) public var foo: String? ` 

setter will be private while getter is public -- foo can only be set in that class but can be get publicly.



### **Programmatic Autolayout**


---



#### Step 1: Make a root view controller


Add the following codes to didFinishLaunchingWithOptions() function in AppDelegate

```swift
// init a window and assign to our app window
self.window = UIWindow() 
// show the window and makes it the key window
self.window?.makeKeyAndVisible() 

// init a SignUpController
let signUpController = SignUpController()
// init a navigation controller and make signUpController be its rootViewController
let navController =  UINavigationController(rootViewController: signUpController)

// set navController as the app rootViewController 
window?.rootViewController = navController

```

#### Step 2: Create a button for the avater

Add a Button in SignUpController:


```swift
let plusPhotoButton: UIButton = {
var button = UIButton(type: .system)
button.setImage(UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal), for: .normal)  // withRenderingMode -> default is showing the image with tint color

return button
}()

```
#### Step 3: Adding Autolayout by code

```swift
override func viewDidLoad() {
super.viewDidLoad()

self.view.backgroundColor = UIColor.white

view.addSubview(plusPhotoButton)
NSLayoutConstraint.activate([
plusPhotoButton.widthAnchor.constraint(equalToConstant: 140),
plusPhotoButton.heightAnchor.constraint(equalToConstant: 140),
plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
plusPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
])
}

```
> Remeber :
> add set button's property-**translatesAutoresizingMaskIntoConstraints** to be **false**
> 

#### Gotcha
We will have a UI like this:
![](https://i.imgur.com/gbIPkaD.png)




### **Advance way of doing Autolayout programmatically**


---


Add this method in the extension for UIView:
```swift
extension UIView {

func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?,
paddingTop: CGFloat, paddingLeading: CGFloat, paddingTrailing: CGFloat, paddingBottom: CGFloat, width: CGFloat, height: CGFloat) {

translatesAutoresizingMaskIntoConstraints = false

if let top = top {
self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
}

if let leading = leading {
self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
}

if let trailing = trailing {
self.trailingAnchor.constraint(equalTo: trailing, constant: -paddingTrailing).isActive = true
}

if let bottom = bottom {
self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
}

if width != 0 {
self.widthAnchor.constraint(equalToConstant: width).isActive = true
}

if height != 0 {
self.heightAnchor.constraint(equalToConstant: height).isActive = true
}

}
}
```

and then change the code in ViewDidLoad():
```swift
plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, trailing: nil, bottom: nil, paddingTop: 50, paddingLeading: 0, paddingTrailing: 0, paddingBottom: 0, width: 140, height: 140)

plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

```

We will have the exactly same UI as above~


