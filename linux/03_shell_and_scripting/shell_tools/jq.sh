
# jq command is a powerful tool for parsing, filtering, and transforming JSON data.

cat data.json | jq '.'                # Pretty-print JSON
jq '.users[0].name' data.json         # Extract a field from JSON
jq '.users | map(select(.age > 30))' data.json  # Filter JSON where age > 30

# Tip: Use jq -r to output raw strings without quotes:
