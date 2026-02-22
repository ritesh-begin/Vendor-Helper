from fastapi import HTTPException, Security
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
import os


security = HTTPBearer()


def authenticate_user(credentials: HTTPAuthorizationCredentials = Security(security)) -> dict:
    """
    Middleware to authenticate API requests
    
    In production, this should validate JWT tokens or API keys
    For now, this is a placeholder implementation
    """
    token = credentials.credentials
    
    # TODO: Implement actual token validation
    # For development, we'll accept any token
    if not token:
        raise HTTPException(
            status_code=401,
            detail="Invalid authentication credentials",
            headers={"WWW-Authenticate": "Bearer"},
        )
    
    # Mock user data
    return {
        "user_id": "mock_user_123",
        "email": "user@example.com",
    }


def verify_api_key(api_key: str) -> bool:
    """
    Verify API key for external integrations
    """
    # Get expected API key from environment
    expected_key = os.getenv('API_KEY')
    
    if not expected_key:
        # In development mode without API_KEY set
        return True
    
    return api_key == expected_key
