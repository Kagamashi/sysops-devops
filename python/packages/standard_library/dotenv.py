## python-dotenv (manage environment variables)
# loads environment variables from a .env file
from _tools.python.packages.standard_library.dotenv import load_dotenv  # type: ignore
import os

load_dotenv()  # Load environment variables from .env file
api_key = os.getenv("API_KEY")
print(api_key)
