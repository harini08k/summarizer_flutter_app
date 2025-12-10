# Document Summarizer App (Flutter + Flask + Gemini AI)

An AI-powered document summarization application built using **Flutter**, **Python Flask**, **Google Gemini AI**, and **Firebase**.
Users can upload documents (PDF, DOCX, TXT), preview them, and generate concise summaries powered by Gemini. The app also supports Google Sign-In and maintains a summary history using Firestore.

---

## Features

* **Upload & Summarize Documents** (PDF, DOCX, TXT)
* **Preview Documents** before summarizing
* **Customizable Summary Length**
* **Google Authentication**
* **Summary History** (view, revisit, delete)
* **Flutter Frontend + Flask Backend Integration**

---

## Tech Stack

| Layer           | Technology                     |
| --------------- | ------------------------------ |
| Frontend        | Flutter                        |
| Backend         | Python Flask                   |
| AI Model        | Google Gemini API              |
| Authentication  | Firebase Auth (Google Sign-In) |
| Database        | Firestore                      |
| File Processing | pdfplumber, python-docx        |

---

# Project Structure

```
summarizer_flutter_app/
│── ragg/      # Flutter UI
│── backend/           # Flask backend
│── README.md
```

---

# Backend Setup (Flask)

### 1. Navigate to the backend folder:

```bash
cd backend
```

### 2. Install dependencies:

```bash
pip install Flask requests google-generativeai python-docx pdfplumber
```

### 3. Add your Gemini API Key

Create a `.env` file:

```
API_KEY=your_key_here
```

Or export it:

**macOS/Linux**

```bash
export API_KEY="your_key"
```

**Windows CMD**

```bash
set API_KEY=your_key
```

### 4. Start the server:

```bash
python app.py
```

Backend runs at:

```
http://127.0.0.1:5000
```

---

# Firebase Setup

1. Create a project in **Firebase Console**
2. Enable **Google Sign-In** (Authentication → Sign-In Method)
3. Set up **Firestore Database**
4. Add Firebase to your Flutter app:

   ```
   flutterfire configure
   ```
5. Add the downloaded configuration files:

   * `google-services.json` (Android)
   * `GoogleService-Info.plist` (iOS)

---

# Flutter Setup (Frontend)

### 1. Navigate to Flutter app:

```bash
cd ragg
```

### 2. Install dependencies:

```bash
flutter pub get
```

### 3. Update Backend API URL

In your API service file (e.g., `api_client.dart`):

```dart
final baseUrl = "http://localhost:5000";   // iOS & Web
// OR
final baseUrl = "http://10.0.2.2:5000";    // Android Emulator
```

### 4. Run the app:

```bash
flutter run
```

---

# How It Works

1. User uploads a document
2. Flutter sends the file to Flask backend
3. Flask extracts text → sends it to Gemini API
4. Gemini returns a summary
5. Summary is displayed in the app and stored in Firestore
6. User can view/delete summary history anytime

---

# Contributing

Pull requests are welcome!

---

# Disclaimer

This project uses Google Gemini API.
Make sure **API keys are stored securely** and not committed to GitHub.

---

# ⭐ If you found this project helpful, give it a star!

---
