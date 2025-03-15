## requests (HTTP requests handling)
# simplifies working with APIs and web scraping
import requests  # type: ignore

response = requests.get("https://api.github.com")
print(response.status_code)  # Output: 200
print(response.json())  # Parse JSON response

