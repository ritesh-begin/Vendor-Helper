import os
from typing import Dict, Any, List, Optional
import google.generativeai as genai


class GeminiService:
    def __init__(self):
        # Initialize Gemini API
        # In production, use environment variable for API key
        api_key = os.getenv("GEMINI_API_KEY", "")
        if api_key:
            genai.configure(api_key=api_key)
            self.model = genai.GenerativeModel('gemini-pro')
        else:
            self.model = None
    
    async def generate_insights(
        self,
        start_date: Optional[str] = None,
        end_date: Optional[str] = None,
        category: Optional[str] = None
    ) -> Dict[str, Any]:
        """
        Generate business insights using Gemini AI
        """
        if not self.model:
            # Return mock data if API key not configured
            return self._get_mock_insights()
        
        prompt = f"""
        Analyze the following sales data and provide business insights:
        
        Period: {start_date} to {end_date}
        Category: {category or 'All'}
        
        Please provide:
        1. Key insights about revenue trends
        2. Category performance analysis
        3. Product recommendations
        4. Potential areas for improvement
        
        Format your response as structured JSON with insights array.
        """
        
        try:
            response = self.model.generate_content(prompt)
            # Parse and structure the response
            return self._parse_gemini_response(response.text)
        except Exception as e:
            print(f"Error generating insights: {e}")
            return self._get_mock_insights()
    
    async def generate_suggestions(
        self,
        sales_data: Dict[str, Any]
    ) -> List[str]:
        """
        Generate actionable suggestions based on sales data
        """
        if not self.model:
            return self._get_mock_suggestions()
        
        prompt = f"""
        Based on the following sales data, provide 5 actionable business suggestions:
        
        {sales_data}
        
        Focus on:
        - Revenue optimization
        - Inventory management
        - Customer retention
        - Product mix
        - Operational efficiency
        
        Return only the suggestions as a numbered list.
        """
        
        try:
            response = self.model.generate_content(prompt)
            return self._parse_suggestions(response.text)
        except Exception as e:
            print(f"Error generating suggestions: {e}")
            return self._get_mock_suggestions()
    
    async def analyze_trends(
        self,
        start_date: Optional[str] = None,
        end_date: Optional[str] = None
    ) -> Dict[str, Any]:
        """
        Analyze sales trends and make predictions
        """
        if not self.model:
            return self._get_mock_trends()
        
        prompt = f"""
        Analyze sales trends for the period {start_date} to {end_date}.
        
        Provide:
        1. Weekly trend analysis
        2. Monthly trend analysis
        3. Revenue predictions for next week
        4. Confidence level in predictions
        
        Format as JSON with trends and predictions.
        """
        
        try:
            response = self.model.generate_content(prompt)
            return self._parse_trends_response(response.text)
        except Exception as e:
            print(f"Error analyzing trends: {e}")
            return self._get_mock_trends()
    
    def _parse_gemini_response(self, text: str) -> Dict[str, Any]:
        """Parse Gemini response into structured format"""
        # In production, implement proper JSON parsing
        return self._get_mock_insights()
    
    def _parse_suggestions(self, text: str) -> List[str]:
        """Parse suggestions from Gemini response"""
        # In production, implement proper parsing
        return self._get_mock_suggestions()
    
    def _parse_trends_response(self, text: str) -> Dict[str, Any]:
        """Parse trends analysis from Gemini response"""
        # In production, implement proper JSON parsing
        return self._get_mock_trends()
    
    def _get_mock_insights(self) -> Dict[str, Any]:
        """Return mock insights for testing"""
        return {
            "insights": [
                {
                    "type": "revenue_trend",
                    "title": "Revenue Increasing",
                    "description": "Your revenue has increased by 15% compared to last period",
                    "sentiment": "positive"
                },
                {
                    "type": "top_category",
                    "title": "Electronics Leading",
                    "description": "Electronics category is generating the most revenue",
                    "sentiment": "neutral"
                },
                {
                    "type": "slow_product",
                    "title": "Low Sales Alert",
                    "description": "Some products have seen declining sales",
                    "sentiment": "negative"
                }
            ],
            "predictions": {
                "next_week_revenue": 5000.0,
                "confidence": 0.85
            }
        }
    
    def _get_mock_suggestions(self) -> List[str]:
        """Return mock suggestions for testing"""
        return [
            "Focus on high-margin products",
            "Consider bundling related products",
            "Implement a loyalty program",
            "Optimize inventory based on demand patterns",
            "Analyze customer buying patterns"
        ]
    
    def _get_mock_trends(self) -> Dict[str, Any]:
        """Return mock trends for testing"""
        return {
            "trends": [
                {
                    "period": "weekly",
                    "trend": "upward",
                    "percentage": 12.5
                },
                {
                    "period": "monthly",
                    "trend": "stable",
                    "percentage": 2.3
                }
            ],
            "predictions": {
                "next_week_revenue": 5000.0,
                "confidence": 0.85
            }
        }
