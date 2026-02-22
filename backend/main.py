from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from datetime import datetime
from typing import List, Dict, Any
import os
import uvicorn

from gemini_service import GeminiService
from auth_middleware import authenticate_user

app = FastAPI(title="Shop Insights API", version="1.0.0")

# CORS configuration
# TODO: In production, replace with specific allowed origins
allowed_origins = os.getenv("ALLOWED_ORIGINS", "*").split(",")
app.add_middleware(
    CORSMiddleware,
    allow_origins=allowed_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize Gemini service
gemini_service = GeminiService()


# Request models
class InsightsRequest(BaseModel):
    startDate: str
    endDate: str


class PredictionsRequest(BaseModel):
    daysAhead: int


class TrendsRequest(BaseModel):
    startDate: str
    endDate: str


# Response models
class InsightsResponse(BaseModel):
    insights: str


class RecommendationsResponse(BaseModel):
    recommendations: List[str]


@app.get("/")
async def root():
    """Root endpoint"""
    return {"message": "Shop Insights API", "version": "1.0.0"}


@app.post("/api/insights/business", response_model=InsightsResponse)
async def get_business_insights(request: InsightsRequest):
    """
    Get AI-powered business insights based on sales data
    """
    try:
        insights = await gemini_service.generate_business_insights(
            start_date=request.startDate,
            end_date=request.endDate
        )
        return InsightsResponse(insights=insights)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/api/insights/recommendations", response_model=RecommendationsResponse)
async def get_product_recommendations():
    """
    Get AI-powered product recommendations
    """
    try:
        recommendations = await gemini_service.generate_product_recommendations()
        return RecommendationsResponse(recommendations=recommendations)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.post("/api/insights/predictions")
async def get_sales_predictions(request: PredictionsRequest) -> Dict[str, Any]:
    """
    Get sales predictions for the specified period
    """
    try:
        predictions = await gemini_service.generate_sales_predictions(
            days_ahead=request.daysAhead
        )
        return predictions
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.post("/api/insights/trends")
async def analyze_trends(request: TrendsRequest) -> Dict[str, Any]:
    """
    Analyze sales trends for the specified period
    """
    try:
        trends = await gemini_service.analyze_trends(
            start_date=request.startDate,
            end_date=request.endDate
        )
        return trends
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/health")
async def health_check():
    """Health check endpoint"""
    return {"status": "healthy", "timestamp": datetime.utcnow().isoformat()}


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
