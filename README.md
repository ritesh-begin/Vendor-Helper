# Vendor-Helper (Shop Insights App)

This is an application targeting small vendors and shop owners to maximize its profit and reduce the time cost. It has integrated AI that helps them to analyse the patterns and gain insight from it.

## Project Structure

```
shop_insights_app/
│
├── lib/
│   ├── main.dart                          # Main entry point
│   │
│   ├── core/
│   │   ├── constants.dart                 # App-wide constants
│   │   └── app_router.dart                # Navigation routing
│   │
│   ├── models/
│   │   ├── sale_model.dart                # Sales data model
│   │   ├── dashboard_summary.dart         # Dashboard summary model
│   │   └── user_model.dart                # User data model
│   │
│   ├── repositories/
│   │   ├── sales_repository.dart          # Sales repository interface
│   │   ├── dummy_sales_repository.dart    # Mock sales repository
│   │   ├── firebase_sales_repository.dart # Firebase sales repository
│   │   ├── insights_repository.dart       # Insights repository interface
│   │   ├── dummy_insights_repository.dart # Mock insights repository
│   │   └── api_insights_repository.dart   # API insights repository
│   │
│   ├── services/
│   │   ├── dashboard_service.dart         # Dashboard business logic
│   │   ├── ocr_service.dart               # OCR processing service
│   │   └── auth_service.dart              # Authentication service
│   │
│   ├── screens/
│   │   ├── login_screen.dart              # Login screen
│   │   ├── dashboard_screen.dart          # Main dashboard
│   │   ├── add_sale_screen.dart           # Add sale manually
│   │   ├── ocr_screen.dart                # OCR receipt scanning
│   │   └── ai_insight_screen.dart         # AI-powered insights
│   │
│   ├── widgets/
│   │   ├── sales_chart.dart               # Sales trend chart
│   │   ├── category_bar_chart.dart        # Category revenue chart
│   │   ├── top_products_list.dart         # Top products display
│   │   └── insight_card.dart              # Insight card widget
│   │
│   └── utils/
│       └── parsers.dart                   # Data parsing utilities
│
├── backend/
│   ├── main.py                            # FastAPI backend server
│   ├── gemini_service.py                  # Gemini AI integration
│   ├── auth_middleware.py                 # Authentication middleware
│   └── requirements.txt                   # Python dependencies
│
└── README.md
```

## Features

- **Dashboard**: View comprehensive sales analytics and metrics
- **Sales Management**: Add sales manually or via OCR
- **OCR Receipt Scanning**: Automatically extract sale data from receipts
- **AI Insights**: Get AI-powered business insights and recommendations
- **Analytics**: Visualize sales trends, category performance, and top products
- **User Authentication**: Secure login and user management

## Technology Stack

### Frontend (Flutter)
- **Framework**: Flutter/Dart
- **State Management**: StatefulWidget (can be extended with Provider/Bloc)
- **UI Components**: Material Design 3

### Backend (Python)
- **Framework**: FastAPI
- **AI Integration**: Google Gemini AI
- **Authentication**: JWT-based (configurable)
- **CORS**: Enabled for cross-origin requests

## Getting Started

### Prerequisites
- Flutter SDK (3.0+)
- Python 3.8+
- Gemini API Key (optional, for AI features)

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

3. Set up environment variables (optional):
```bash
export GEMINI_API_KEY=your_api_key_here
```

4. Run the backend server:
```bash
python main.py
```

The backend will be available at `http://localhost:8000`

## API Endpoints

- `GET /` - API information
- `GET /health` - Health check
- `POST /api/insights` - Get AI-powered insights
- `POST /api/ocr/process` - Process OCR images

## Future Enhancements

- Firebase integration for real-time data sync
- Enhanced OCR with Google Vision API
- Advanced analytics and reporting
- Multi-user support
- Mobile app deployment
- Cloud deployment (AWS/GCP/Azure)

## License

This project is open source and available under the MIT License.
