# Electrolink - Second Hand Electronics Marketplace 📱♻️

Electrolink is a professional, trust-based marketplace designed for buying and selling second-hand electronics. It bridges the gap between buyers and sellers through a secure, location-based platform that emphasizes user verification and manual quality control.

<img width="3200" height="1312" alt="Gemini_Generated_Image_w59qd1w59qd1w59q" src="https://github.com/user-attachments/assets/623284f2-2190-434a-82be-b60a891a87ae" />


## 👥 Team Members
- **Wafaa** - [@WafaaSisalem](https://github.com/WafaaSisalem) [Team Leader]
- **Amal** - [@amalanan](https://github.com/amalanan) [Deputy Team Leader]
- **Maha** - [@maha2001marwan](https://github.com/maha2001marwan) [Team Member]
- **Mohammed** - [@MOQ2](https://github.com/MOQ2) [Team Member]
- **Israa** - [@IsraaTomeh](https://github.com/IsraaTomeh) [Team Member]

## ✨ Features

### 🛒 Dual Role Marketplace
- **Seamless Browsing**: Explore a wide range of used electronics categorized for easy navigation.
- **Selling Made Easy**: Post your used gadgets with ease to find potential buyers.

### 📍 Location-Based Discovery
- **Nearby Listings**: Upon entry, the app detects your location to prioritize electronics available in your immediate vicinity.
- **Regional Filtering**: Browse listings based on specific cities or countries.

### 🛡️ Trust & Verification System (3-Tier Authentication)
To ensure a safe environment, users can verify their profiles through:
1. **Phone Verification**: Secure OTP-based mobile authentication.
2. **Email Verification**: Secure OTP-based email authentication.
3. **Identity Verification (KYC)**: Advanced verification by uploading ID/Passport/Driver's License photos and a matching live selfie.

### 👨‍✈️ Admin Moderation & Quality Control
- **Manual Review**: No listing goes public automatically. Every product is reviewed by an Admin to ensure authenticity and trust.
- **Verified Badges**: Profiles with completed verifications are highlighted to increase buyer confidence.

### 💬 Direct Peer-to-Peer Communication
- **No In-App Payments**: Transactions are finalized through direct communication between the buyer and the seller.
- **Favorites & Wishlist**: Save interesting items to contact the seller later.

## 🛠️ Tech Stack

- **Frontend:** Flutter (Dart), BLoC / Cubit Pattern, GoRouter
- **Networking:** Dio (Structured with Interceptors & Error Handling)
- **Architecture:** Simplified Clean Architecture (Core, Features, Data, Presentation)

## 🚀 Getting Started


### Prerequisites
- Flutter SDK 
- Google Maps API key

### Installation

1. Clone the repository
   ```bash
   git clone (https://github.com/2EMarket/electrolink-app.git)
   cd electrolink-app
   flutter pub get
   ```
2. **Google Maps Setup (Android)**
   - Get a Google Maps API key
   - Navigate to the `android/` folder.
   - Create a file named `local.properties`.
   - Add the following line with your Google Maps API Key instead of zero's:
     `MAPS_API_KEY=000000000000000000000000000000000`
     
5. Run the app
   ```bash
   flutter run
   ```

---
*Built with ❤️ by the Electrolink Team*
