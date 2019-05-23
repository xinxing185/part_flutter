# part_flutter
Add Flutter to existing Android App, the part of flutter

A new flutter module project.

# Development Step
Create Module

创建module
```
flutter create -t module module_name
```

Build Flutter aar for Android Project

将Flutter Module打包成aar

```
cd .android/
./gradlew flutter:assembkeDebug
```

attach to running app for hot reload


```
flutter attach
```


