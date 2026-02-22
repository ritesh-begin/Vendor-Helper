from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import Optional, Dict, Any, List
from datetime import datetime
import uvicorn

from gemini_service import GeminiService
from auth_middleware import verify_token

app = FastAPI(title="Shop Insights API")

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, specify actual origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

gemini_service = GeminiService()


class InsightsRequest(BaseModel):
    action: str
    start_date: Optional[str] = None
    end_date: Optional[str] = None
    category: Optional[str] = None
    sales_data: Optional[Dict[str, Any]] = None


class InsightsResponse(BaseModel):
    insights: Optional[List[Dict[str, Any]]] = None
    suggestions: Optional[List[str]] = None
    trends: Optional[Dict[str, Any]] = None
    predictions: Optional[Dict[str, Any]] = None


@app.get("/")
async def root():
    return {
        "message": "Shop Insights API",
        "version": "1.0.0",
        "status": "running"
    }


@app.get("/health")
async def health_check():
    return {"status": "healthy"}


@app.post("/api/insights", response_model=InsightsResponse)
async def get_insights(
    request: InsightsRequest,
    # token: str = Depends(verify_token)  # Uncomment when auth is enabled
):
    """
    Get AI-powered insights based on sales data
    """
    try:
        if request.action == "get_insights":
            insights = await gemini_service.generate_insights(
                start_date=request.start_date,
                end_date=request.end_date,
                category=request.category
            )
            return InsightsResponse(
                insights=insights.get("insights"),
                predictions=insights.get("predictions")
            )
        
        elif request.action == "get_suggestions":
            suggestions = await gemini_service.generate_suggestions(
                sales_data=request.sales_data or {}
            )
            return InsightsResponse(suggestions=suggestions)
        
        elif request.action == "analyze_trends":
            trends = await gemini_service.analyze_trends(
                start_date=request.start_date,
                end_date=request.end_date
            )
            return InsightsResponse(
                trends=trends.get("trends"),
                predictions=trends.get("predictions")
            )
        
        else:
            raise HTTPException(status_code=400, detail="Invalid action")
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.post("/api/ocr/process")
async def process_ocr(
    # image: UploadFile,  # Uncomment when implementing file upload
    # token: str = Depends(verify_token)
):
    """
    Process OCR for receipt images
    """
    # TODO: Implement OCR processing
    # This would use Google Vision API or similar service
    return {
        "success": True,
        "extracted_data": {
            "productName": "Sample Product",
            "price": 29.99,
            "quantity": 1,
            "category": "General"
        },
        "confidence": 0.85
    }


if __name__ == "__main__":
    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=8000,
        reload=True
    )
