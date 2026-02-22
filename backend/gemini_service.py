import os
from typing import List, Dict, Any
import google.generativeai as genai


class GeminiService:
    """Service for interacting with Google Gemini API"""
    
    def __init__(self):
        # Configure Gemini API
        api_key = os.getenv('GEMINI_API_KEY')
        if not api_key:
            print("Warning: GEMINI_API_KEY not set. Using mock responses.")
            self.model = None
        else:
            genai.configure(api_key=api_key)
            self.model = genai.GenerativeModel('gemini-pro')
    
    async def generate_business_insights(self, start_date: str, end_date: str) -> str:
        """Generate business insights based on sales data"""
        
        if not self.model:
            return self._mock_business_insights(start_date, end_date)
        
        prompt = f"""
        Analyze the sales data from {start_date} to {end_date} and provide actionable business insights.
        
        Please include:
        1. Key trends and patterns
        2. Recommendations for improvement
        3. Action items for the business owner
        
        Format the response in a clear, structured way with emojis for better readability.
        """
        
        try:
            response = self.model.generate_content(prompt)
            return response.text
        except Exception as e:
            print(f"Error generating insights: {e}")
            return self._mock_business_insights(start_date, end_date)
    
    async def generate_product_recommendations(self) -> List[str]:
        """Generate product recommendations"""
        
        if not self.model:
            return self._mock_product_recommendations()
        
        prompt = """
        Based on current market trends and sales patterns, suggest 5 products 
        that a small vendor or shop owner should consider stocking.
        
        Return only a list of product suggestions with brief reasons.
        """
        
        try:
            response = self.model.generate_content(prompt)
            recommendations = response.text.strip().split('\n')
            return [rec.strip() for rec in recommendations if rec.strip()][:5]
        except Exception as e:
            print(f"Error generating recommendations: {e}")
            return self._mock_product_recommendations()
    
    async def generate_sales_predictions(self, days_ahead: int) -> Dict[str, Any]:
        """Generate sales predictions"""
        
        if not self.model:
            return self._mock_sales_predictions(days_ahead)
        
        # For now, return mock data as prediction requires historical data
        return self._mock_sales_predictions(days_ahead)
    
    async def analyze_trends(self, start_date: str, end_date: str) -> Dict[str, Any]:
        """Analyze sales trends"""
        
        if not self.model:
            return self._mock_trends_analysis(start_date, end_date)
        
        # For now, return mock data as trend analysis requires historical data
        return self._mock_trends_analysis(start_date, end_date)
    
    # Mock response methods
    def _mock_business_insights(self, start_date: str, end_date: str) -> str:
        return f"""
Based on your sales data from {start_date} to {end_date}:

📈 Key Insights:
• Electronics category shows the highest revenue with steady growth
• Weekend sales are 35% higher than weekday sales
• Average transaction value increased by 12% compared to last period

💡 Recommendations:
• Stock up on Electronics items for the upcoming weekend
• Consider promotional campaigns for mid-week to boost sales
• Focus on upselling strategies to maintain the increasing transaction value

🎯 Action Items:
• Monitor inventory levels for top-selling products
• Analyze customer feedback for product improvements
• Plan marketing activities for slower days
        """
    
    def _mock_product_recommendations(self) -> List[str]:
        return [
            "Wireless Headphones - High demand in Electronics",
            "Yoga Mat - Trending in Sports category",
            "Smart Watch - Popular accessory",
            "Organic Coffee - Growing Food category trend",
            "LED Desk Lamp - Office essentials category",
        ]
    
    def _mock_sales_predictions(self, days_ahead: int) -> Dict[str, Any]:
        return {
            "periodDays": days_ahead,
            "predictedRevenue": 5420.50,
            "confidence": 0.85,
            "expectedSales": 127,
            "trends": {
                "Electronics": "increasing",
                "Clothing": "stable",
                "Food": "increasing",
                "Books": "stable",
            }
        }
    
    def _mock_trends_analysis(self, start_date: str, end_date: str) -> Dict[str, Any]:
        return {
            "period": {
                "start": start_date,
                "end": end_date,
            },
            "overallTrend": "positive",
            "growthRate": 15.5,
            "categoryTrends": {
                "Electronics": {"trend": "up", "percentage": 22.3},
                "Clothing": {"trend": "stable", "percentage": 2.1},
                "Food": {"trend": "up", "percentage": 18.7},
                "Books": {"trend": "down", "percentage": -5.2},
            },
            "insights": [
                "Electronics showing strong upward trend",
                "Food category gaining momentum",
                "Books category needs attention",
            ]
        }
