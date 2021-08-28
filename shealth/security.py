from jose import JWTError, jwt
import os

SECRET_KEY = os.environ.get("SECRET_KEY")
ALGORITHM = "HS256"


def create_access_token(email):
    """
    Create access token for user
    """
    payload = {
        "sub": email,
    }
    return jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)


def getUser(token):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
    except JWTError as e:
        return None
    return payload.get("sub")

print(SECRET_KEY)