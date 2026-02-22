# Vendor-Helper (Shop Insights App)

This is an application targeting small vendors and shop owners to maximize their profit and reduce time costs. It has integrated AI that helps them analyze patterns and gain insights from their sales data.

## Features

- 📊 **Dashboard Analytics**: View comprehensive sales statistics and visualizations
- 💰 **Sales Management**: Add, track, and manage sales transactions
- 📸 **OCR Receipt Scanning**: Scan receipts using camera or gallery with OCR technology
- 🤖 **AI-Powered Insights**: Get intelligent business recommendations from Google Gemini AI
- 📈 **Trend Analysis**: Analyze sales trends and predict future performance
- 📱 **Mobile-First Design**: Built with Flutter for cross-platform mobile experience

## Architecture

### Frontend (Flutter/Dart)
The mobile application is built using Flutter with a clean architecture pattern:

- **Core**: Application constants and routing configuration
- **Models**: Data models for sales, users, and dashboard summaries
- **Repositories**: Data layer with support for dummy data, Firebase, and API backends
- **Services**: Business logic for dashboard, OCR, and authentication
- **Screens**: UI screens for login, dashboard, sales entry, OCR, and AI insights
- **Widgets**: Reusable UI components including charts and insight cards
- **Utils**: Utility functions for data parsing and formatting

### Backend (Python/FastAPI)
RESTful API backend providing AI insights:

- **FastAPI**: Modern, fast web framework for building APIs
- **Gemini AI Integration**: Google Gemini AI for generating business insights
- **Authentication**: JWT-based authentication middleware
- **CORS Support**: Configured for cross-origin requests

## Project Structure

```
shop_insights_app/
│
├── lib/
│   ├── main.dart
│   │
│   ├── core/
│   │   ├── constants.dart
│   │   └── app_router.dart
│   │
│   ├── models/
│   │   ├── sale_model.dart
│   │   ├── dashboard_summary.dart
│   │   └── user_model.dart
│   │
│   ├── repositories/
│   │   ├── sales_repository.dart
│   │   ├── dummy_sales_repository.dart
│   │   ├── firebase_sales_repository.dart
│   │   ├── insights_repository.dart
│   │   ├── dummy_insights_repository.dart
│   │   └── api_insights_repository.dart
│   │
│   ├── services/
│   │   ├── dashboard_service.dart
│   │   ├── ocr_service.dart
│   │   └── auth_service.dart
│   │
│   ├── screens/
│   │   ├── login_screen.dart
│   │   ├── dashboard_screen.dart
│   │   ├── add_sale_screen.dart
│   │   ├── ocr_screen.dart
│   │   └── ai_insight_screen.dart
│   │
│   ├── widgets/
│   │   ├── sales_chart.dart
│   │   ├── category_bar_chart.dart
│   │   ├── top_products_list.dart
│   │   └── insight_card.dart
│   │
│   └── utils/
│       └── parsers.dart
│
├── backend/
│   ├── main.py
│   ├── gemini_service.py
│   ├── auth_middleware.py
│   └── requirements.txt
│
└── README.md
```

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Python (>=3.8)
- Firebase account (optional, for production)
- Google Gemini API key (optional, for AI features)

### Frontend Setup

1. Install Flutter dependencies:
```bash
flutter pub get
```

2. Run the app:
```bash
flutter run
```

### Backend Setup

1. Navigate to the backend directory:
```bash
cd backend
```

2. Install Python dependencies:
```bash
pip install -r requirements.txt
```

3. Set up environment variables:
```bash
export GEMINI_API_KEY=your_gemini_api_key_here
export API_KEY=your_api_key_here  # Optional
```

4. Run the backend server:
```bash
python main.py
```

The API will be available at `http://localhost:8000`

### API Documentation

Once the backend is running, access the interactive API documentation at:
- Swagger UI: `http://localhost:8000/docs`
- ReDoc: `http://localhost:8000/redoc`

## Key Dependencies

### Flutter
- `flutter/material.dart` - Material Design widgets
- `firebase_auth` - Firebase authentication
- `cloud_firestore` - Firebase Firestore database
- `google_ml_kit` - ML Kit for OCR functionality
- `fl_chart` - Beautiful charts and graphs
- `http` - HTTP client for API calls
- `image_picker` - Image picking from camera/gallery

### Python
- `fastapi` - Modern web framework
- `uvicorn` - ASGI server
- `pydantic` - Data validation
- `google-generativeai` - Google Gemini AI SDK

## Configuration

### Firebase Setup
1. Create a Firebase project
2. Enable Authentication and Firestore
3. Download configuration files
4. Add to your Flutter project

### Gemini AI Setup
1. Get API key from Google AI Studio
2. Set the `GEMINI_API_KEY` environment variable
3. The backend will automatically use it for AI insights

## Development

### Running Tests
```bash
# Flutter tests
flutter test

# Python tests
pytest
```

### Code Style
```bash
# Flutter
flutter analyze

# Python
black backend/
flake8 backend/
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues and questions, please open an issue on GitHub or contact the development team.
