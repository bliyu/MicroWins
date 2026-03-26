# 🌱 MicroWins – Daily Tiny Achievement App

### 👩‍💻 Team 14 | Mobile App Development

**George Brown College**

---

## 📱 Overview

**MicroWins** is a simple and motivating iOS application designed to help users stay consistent and productive by focusing on small daily achievements instead of overwhelming goals.

Rather than tracking large tasks, MicroWins encourages users to:

* break goals into small wins
* track daily progress
* build consistency over time
* reflect on mood and productivity

---

## 🎯 Problem

Many students and young adults feel overwhelmed managing large tasks, deadlines, and responsibilities. This often leads to procrastination and loss of motivation.

---

## 💡 Solution

MicroWins helps users:

* focus on **small, achievable daily wins**
* build **positive habits**
* track **progress and streaks**
* stay **mentally motivated**

---

## 🚀 Features

### ✅ Core Features

* Add daily **MicroWins**
* Mark wins as **completed/uncompleted**
* Delete wins
* View **today’s wins**

### 😊 Mood Tracking

* Daily mood check-in
* Visual mood selection (emoji-based)
* Stores mood for each day

### 📊 Dashboard

* Current streak 🔥
* Daily progress (completed vs total)
* Today’s mood overview

### 📅 Weekly Summary

* Total completed wins for the week
* Weekly progress breakdown
* Simple visual progress indicators

### 💾 Data Persistence

* Data is stored locally using **JSON file storage**
* Supports:

  * Read (load data on launch)
  * Write (save changes instantly)

---

## 🧭 App Screens

* Launch Screen
* Home Dashboard
* Add MicroWin
* MicroWins List
* Mood Check-In
* Weekly Summary

---

## 🛠️ Technologies Used

* **Swift**
* **SwiftUI**
* **NavigationStack**
* **TabView**
* **MVVM Architecture**
* **JSON File Storage (Persistence)**

---

## 📐 Architecture

The app follows the **MVVM (Model-View-ViewModel)** structure:

* **Models**

  * `MicroWin`
  * `MoodEntry`

* **ViewModel**

  * `MicroWinsStore`
  * Handles logic, data storage, and state management

* **Views**

  * Dashboard
  * Add MicroWin
  * List View
  * Mood Screen
  * Weekly Summary

---

## 📂 Project Structure

```
MicroWins/
│
├── Models/
│   ├── MicroWin.swift
│   └── MoodEntry.swift
│
├── ViewModels/
│   └── MicroWinsStore.swift
│
├── Views/
│   ├── RootTabView.swift
│   ├── SplashView.swift
│   ├── HomeDashboardView.swift
│   ├── AddMicroWinView.swift
│   ├── MicroWinsListView.swift
│   ├── MoodCheckInView.swift
│   ├── WeeklySummaryView.swift
│   └── Components/
│       └── InfoFooterView.swift
│
└── MicroWinsApp.swift
```

---

## 📱 Device Optimization

* Optimized for: **iPhone 15**
* Supports portrait mode
* Clean and responsive layout using SwiftUI

---

## 🧪 How to Run the App

1. Open the project in **Xcode**
2. Select an iPhone simulator (recommended: iPhone 15)
3. Click **Run ▶️**
4. Test:

   * Add a MicroWin
   * Mark it complete
   * Save a mood
   * View weekly summary

---

## 👥 Team Members

* Blen Abebe
* Shalev Haimovitz
* Jonathan Ivanov
* Melica Alikhani-Marqueti

---

## 📌 Contribution

Each team member contributed to:

* UI design (Figma)
* SwiftUI implementation
* Navigation and logic
* Testing and debugging

Contribution factor will be evaluated based on:

* ability to explain the code
* ability to modify the app during evaluation

---

## 🔮 Future Improvements

* Notifications / reminders
* Cloud sync (Firebase)
* Habit analytics
* User authentication
* Dark mode enhancements

---

## ✨ Conclusion

MicroWins demonstrates how small daily achievements can lead to meaningful progress over time. The app combines simplicity with motivation, helping users build consistent and positive habits.

---
