'''
logging is used to track events in a program

logging.info() prints messages with INFO level but only if
  logging.basicCongi(level=logging.INFO) is set

DEBUG     detailed debugging info (level=logging.DEBUG)
INFO      general program information (level=logging.INFO)
WARNING   someting unexpected (always visible)
ERROR     serious problem occured
CRITICAL  severe issue, program may crash
'''

import logging

logging.basicConfig(level=logging.INFO)  # Set log level
logging.info("This is an info message")
# INFO:root:This is an info message


# write logs into a file
logging.basicConfig(filename="app.log", level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")
logging.info("This will be logged to app.log")


# customizing logging format
logging.basicConfig(format="%(asctime)s - %(levelname)s - %(message)s", level=logging.DEBUG)

logging.info("Info message")
logging.error("Error message")
# 2025-02-10 12:45:00 - INFO - Info message
# 2025-02-10 12:45:01 - ERROR - Error message


# using Logger object
logger = logging.getLogger("my_logger")
logger.setLevel(logging.DEBUG)

# Create console handler
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.DEBUG)

# Define log format
formatter = logging.Formatter("%(name)s - %(levelname)s - %(message)s")
console_handler.setFormatter(formatter)

# Add handler to logger
logger.addHandler(console_handler)

logger.info("This is an info message")
logger.error("This is an error message")
