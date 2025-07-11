# Flutter
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# Dart/Protobuf
-keep class com.google.protobuf.** { *; }
-dontwarn com.google.protobuf.**

# Firebase
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# Facebook SDK
-keep class com.facebook.** { *; }
-dontwarn com.facebook.**

# Huawei SDK
-keep class com.huawei.** { *; }
-dontwarn com.huawei.**

# AndroidX Annotations
-keep class androidx.annotation.Keep
-dontwarn androidx.annotation.Keep

# Parcelable model classes
-keepclassmembers class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# Kotlin metadata
-keep class kotlin.Metadata { *; }

# Keep reflection-used classes
-keepclassmembers class * {
    *;
}

# Keep main app classes
-keep class com.propertier.propertiercom.** { *; }

# Prevent warnings
-dontwarn java.lang.invoke.*
-dontwarn kotlinx.coroutines.*
-dontwarn kotlin.Unit
-dontwarn kotlin.jvm.internal.*

# Fix crash from lambda expressions
-dontwarn kotlin.coroutines.jvm.internal.**
